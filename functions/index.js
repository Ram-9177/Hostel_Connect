// Firebase Cloud Functions for HostelConnect Education Pipeline
// Implements: 
//  A) Bulk user import from CSV (Storage trigger)
//  B) Create announcement (HTTPS callable)
//  C) Move student to room (HTTPS callable)

const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize app once
try {
  admin.app();
} catch (e) {
  admin.initializeApp();
}

// A) Bulk user import from CSV
exports.importStudentsFromCSV = functions.storage.object().onFinalize(async (object) => {
  const filePath = object.name || '';
  if (!filePath.startsWith('imports/students/')) return null;

  const bucket = admin.storage().bucket();
  const file = bucket.file(filePath);
  const [data] = await file.download();
  const csv = data.toString('utf8');

  // Parse CSV: Name,Hall Ticket,College code,Number,Hostel Name
  const lines = csv.split('\n').filter(Boolean).slice(1); // Skip header
  const batch = admin.firestore().batch();

  for (const line of lines) {
    const [name, hallTicket, collegeCode, phone, hostelName] = line.split(',');
    if (!hallTicket) continue;
    const email = `${hallTicket}@students.mycollege.in`;

    // Create Auth user; ignore if exists
    let userRecord;
    try {
      userRecord = await admin.auth().createUser({
        email,
        password: String(hallTicket).trim(), // Initial password = hall ticket
        displayName: name,
      });
    } catch (err) {
      if (err.errorInfo && err.errorInfo.code === 'auth/email-already-exists') {
        userRecord = await admin.auth().getUserByEmail(email);
      } else {
        console.error('Failed to create user for line:', line, err);
        continue;
      }
    }

    // Create Firestore doc
    const userRef = admin.firestore().collection('users').doc(userRecord.uid);
    batch.set(userRef, {
      uid: userRecord.uid,
      email,
      hallTicket,
      displayName: name,
      collegeCode,
      phone,
      hostelName,
      role: 'student',
      needsPasswordChange: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  }

  await batch.commit();
  return { success: true, count: lines.length };
});

// B) Create announcement (admin only)
exports.createAnnouncement = functions.https.onCall(async (data, context) => {
  // Verify admin role
  if (!context.auth || !context.auth.token || !['admin', 'super_admin'].includes(context.auth.token.role)) {
    throw new functions.https.HttpsError('permission-denied', 'Admin only');
  }

  const { title, body, audienceType = 'ALL', hostelName, floor, roomNo } = data || {};
  if (!title || !body) {
    throw new functions.https.HttpsError('invalid-argument', 'title and body are required');
  }

  // Create announcement doc
  const announcementRef = await admin.firestore().collection('announcements').add({
    collegeId: context.auth.token.collegeId || 'default',
    title,
    body,
    audience: { type: audienceType, hostelName, floor, roomNo },
    createdBy: context.auth.uid,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Determine FCM topic
  let topic = `college_${context.auth.token.collegeId || 'default'}`;
  if (audienceType === 'HOSTEL' && hostelName) topic += `_hostel_${hostelName}`;
  if (audienceType === 'FLOOR' && floor) topic += `_floor_${floor}`;
  if (audienceType === 'ROOM' && roomNo) topic += `_room_${roomNo}`;

  // Send FCM notification
  await admin.messaging().sendToTopic(topic, {
    notification: { title, body },
    data: { announcementId: announcementRef.id },
  });

  return { success: true, announcementId: announcementRef.id };
});

// C) Move student to room (admin only)
exports.moveStudentToRoom = functions.https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.token || !['admin', 'super_admin'].includes(context.auth.token.role)) {
    throw new functions.https.HttpsError('permission-denied', 'Admin only');
  }

  const { studentUid, hostelName, floor, roomNo, bedNo } = data || {};
  if (!studentUid || !hostelName || typeof floor === 'undefined' || !roomNo || typeof bedNo === 'undefined') {
    throw new functions.https.HttpsError('invalid-argument', 'studentUid, hostelName, floor, roomNo, bedNo are required');
  }

  const roomId = `${hostelName}-${floor}-${roomNo}`;
  const roomRef = admin.firestore().collection('rooms').doc(roomId);
  const roomDoc = await roomRef.get();

  if (!roomDoc.exists) {
    throw new functions.https.HttpsError('not-found', 'Room not found');
  }

  const roomData = roomDoc.data() || {};
  if ((roomData.occupantsCount || 0) >= (roomData.capacity || 0)) {
    throw new functions.https.HttpsError('failed-precondition', 'Room full');
  }

  // Update room
  await roomRef.update({
    occupants: admin.firestore.FieldValue.arrayUnion({
      uid: studentUid,
      bed: bedNo,
      movedAt: admin.firestore.FieldValue.serverTimestamp(),
    }),
    occupantsCount: admin.firestore.FieldValue.increment(1),
  });

  // Update user
  await admin.firestore().collection('users').doc(studentUid).set({
    room: { hostelName, floor, roomNo, bedNo },
  }, { merge: true });

  // Log move
  await admin.firestore().collection('room_moves').add({
    uid: studentUid,
    collegeId: context.auth.token.collegeId || 'default',
    roomId,
    movedAt: admin.firestore.FieldValue.serverTimestamp(),
    movedBy: context.auth.uid,
  });

  return { success: true };
});
