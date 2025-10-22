const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;
const HOST = '0.0.0.0';

// Middleware
app.use(cors({
  origin: true,
  credentials: true,
}));
app.use(express.json());

// Test endpoint
app.get('/api/v1/', (req, res) => {
  res.json({ 
    status: 'ok', 
    message: 'HostelConnect API is running!',
    timestamp: new Date().toISOString()
  });
});

// Health check
app.get('/api/v1/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Test login endpoint
app.post('/api/v1/auth/login', (req, res) => {
  const { email, password } = req.body;
  
  // Demo credentials
  const demoUsers = {
    'student@demo.com': { password: 'password123', role: 'student' },
    'warden@demo.com': { password: 'password123', role: 'warden' },
    'wardenhead@demo.com': { password: 'password123', role: 'warden_head' },
    'chef@demo.com': { password: 'password123', role: 'chef' },
    'admin@demo.com': { password: 'password123', role: 'super_admin' }
  };
  
  if (demoUsers[email] && demoUsers[email].password === password) {
    res.json({
      success: true,
      user: {
        id: 'demo-user-' + Date.now(),
        email: email,
        firstName: email.split('@')[0],
        lastName: 'User',
        role: demoUsers[email].role,
        phone: '9876543210',
        studentId: 'STU001',
        hostelId: 'hostel-1',
        roomId: 'room-101',
        isActive: true,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      },
      tokens: {
        accessToken: 'demo-access-token-' + Date.now(),
        refreshToken: 'demo-refresh-token-' + Date.now(),
        expiresIn: 3600
      },
      deviceId: 'device-' + Date.now()
    });
  } else {
    res.status(401).json({
      success: false,
      message: 'Invalid credentials'
    });
  }
});

app.listen(PORT, HOST, () => {
  console.log(`🚀 HostelConnect API running on ${HOST}:${PORT}`);
  console.log(`📚 API Documentation: http://localhost:${PORT}/api/v1/`);
  console.log(`🔗 Test Login: POST http://localhost:${PORT}/api/v1/auth/login`);
});
