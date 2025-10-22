import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hostelconnect/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HostelConnect Mobile App User Acceptance Tests', () {
    testWidgets('Complete user journey test', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test 1: Login Flow
      await _testLoginFlow(tester);

      // Test 2: Dashboard Navigation
      await _testDashboardNavigation(tester);

      // Test 3: Gate Pass Request
      await _testGatePassRequest(tester);

      // Test 4: Attendance Scanning
      await _testAttendanceScanning(tester);

      // Test 5: Meal Intent Submission
      await _testMealIntentSubmission(tester);

      // Test 6: Profile Management
      await _testProfileManagement(tester);

      // Test 7: Notifications
      await _testNotifications(tester);

      // Test 8: Offline Functionality
      await _testOfflineFunctionality(tester);
    });

    testWidgets('Role-based access test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test different user roles
      await _testStudentRole(tester);
      await _testWardenRole(tester);
      await _testAdminRole(tester);
    });

    testWidgets('Performance and responsiveness test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test app performance
      await _testAppPerformance(tester);
      await _testResponsiveDesign(tester);
    });
  });
}

Future<void> _testLoginFlow(WidgetTester tester) async {
  // Find login form elements
  final emailField = find.byKey(const Key('email_field'));
  final passwordField = find.byKey(const Key('password_field'));
  final loginButton = find.byKey(const Key('login_button'));

  expect(emailField, findsOneWidget);
  expect(passwordField, findsOneWidget);
  expect(loginButton, findsOneWidget);

  // Enter credentials
  await tester.enterText(emailField, 'student@test.com');
  await tester.enterText(passwordField, 'password123');
  await tester.pumpAndSettle();

  // Tap login button
  await tester.tap(loginButton);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  // Verify successful login (should navigate to dashboard)
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);
}

Future<void> _testDashboardNavigation(WidgetTester tester) async {
  // Test navigation between different sections
  final homeTab = find.byKey(const Key('home_tab'));
  final attendanceTab = find.byKey(const Key('attendance_tab'));
  final mealsTab = find.byKey(const Key('meals_tab'));
  final gatePassTab = find.byKey(const Key('gatepass_tab'));

  // Navigate to attendance
  await tester.tap(attendanceTab);
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('attendance_page')), findsOneWidget);

  // Navigate to meals
  await tester.tap(mealsTab);
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('meals_page')), findsOneWidget);

  // Navigate to gate pass
  await tester.tap(gatePassTab);
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('gatepass_page')), findsOneWidget);

  // Return to home
  await tester.tap(homeTab);
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);
}

Future<void> _testGatePassRequest(WidgetTester tester) async {
  // Navigate to gate pass page
  await tester.tap(find.byKey(const Key('gatepass_tab')));
  await tester.pumpAndSettle();

  // Tap new request button
  await tester.tap(find.byKey(const Key('new_gatepass_button')));
  await tester.pumpAndSettle();

  // Fill gate pass form
  await tester.enterText(
    find.byKey(const Key('reason_field')),
    'Medical appointment',
  );
  await tester.enterText(
    find.byKey(const Key('destination_field')),
    'City Hospital',
  );

  // Select departure time
  await tester.tap(find.byKey(const Key('departure_time_field')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();

  // Select return time
  await tester.tap(find.byKey(const Key('return_time_field')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();

  // Submit request
  await tester.tap(find.byKey(const Key('submit_gatepass_button')));
  await tester.pumpAndSettle();

  // Verify success message
  expect(find.text('Gate pass request submitted successfully'), findsOneWidget);
}

Future<void> _testAttendanceScanning(WidgetTester tester) async {
  // Navigate to attendance page
  await tester.tap(find.byKey(const Key('attendance_tab')));
  await tester.pumpAndSettle();

  // Tap scan button
  await tester.tap(find.byKey(const Key('scan_attendance_button')));
  await tester.pumpAndSettle();

  // Simulate QR code scan
  await tester.tap(find.byKey(const Key('simulate_qr_scan')));
  await tester.pumpAndSettle();

  // Verify attendance recorded
  expect(find.text('Attendance recorded successfully'), findsOneWidget);
}

Future<void> _testMealIntentSubmission(WidgetTester tester) async {
  // Navigate to meals page
  await tester.tap(find.byKey(const Key('meals_tab')));
  await tester.pumpAndSettle();

  // Select meal type
  await tester.tap(find.byKey(const Key('breakfast_intent')));
  await tester.pumpAndSettle();

  // Submit intent
  await tester.tap(find.byKey(const Key('submit_meal_intent')));
  await tester.pumpAndSettle();

  // Verify intent submitted
  expect(find.text('Meal intent submitted'), findsOneWidget);
}

Future<void> _testProfileManagement(WidgetTester tester) async {
  // Navigate to profile
  await tester.tap(find.byKey(const Key('profile_tab')));
  await tester.pumpAndSettle();

  // Tap edit profile
  await tester.tap(find.byKey(const Key('edit_profile_button')));
  await tester.pumpAndSettle();

  // Update phone number
  await tester.enterText(
    find.byKey(const Key('phone_field')),
    '+1234567890',
  );

  // Save changes
  await tester.tap(find.byKey(const Key('save_profile_button')));
  await tester.pumpAndSettle();

  // Verify changes saved
  expect(find.text('Profile updated successfully'), findsOneWidget);
}

Future<void> _testNotifications(WidgetTester tester) async {
  // Navigate to notifications
  await tester.tap(find.byKey(const Key('notifications_button')));
  await tester.pumpAndSettle();

  // Check if notifications are displayed
  expect(find.byKey(const Key('notifications_list')), findsOneWidget);

  // Tap on a notification
  if (find.byKey(const Key('notification_item')).evaluate().isNotEmpty) {
    await tester.tap(find.byKey(const Key('notification_item')).first);
    await tester.pumpAndSettle();
  }
}

Future<void> _testOfflineFunctionality(WidgetTester tester) async {
  // Simulate offline mode
  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/platform',
    const StandardMethodCodec().encodeMethodCall(
      const MethodCall('setNetworkStatus', {'isOnline': false}),
    ),
    (data) {},
  );

  await tester.pumpAndSettle();

  // Check offline indicator
  expect(find.byKey(const Key('offline_indicator')), findsOneWidget);

  // Test offline functionality
  await tester.tap(find.byKey(const Key('gatepass_tab')));
  await tester.pumpAndSettle();

  // Should still be able to create gate pass request offline
  await tester.tap(find.byKey(const Key('new_gatepass_button')));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('gatepass_form')), findsOneWidget);
}

Future<void> _testStudentRole(WidgetTester tester) async {
  // Login as student
  await _loginAsRole(tester, 'student@test.com', 'password123');

  // Verify student-specific features
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);
  expect(find.byKey(const Key('request_gatepass_button')), findsOneWidget);
  expect(find.byKey(const Key('scan_attendance_button')), findsOneWidget);

  // Verify admin features are not accessible
  expect(find.byKey(const Key('admin_panel')), findsNothing);
}

Future<void> _testWardenRole(WidgetTester tester) async {
  // Login as warden
  await _loginAsRole(tester, 'warden@test.com', 'password123');

  // Verify warden-specific features
  expect(find.byKey(const Key('warden_dashboard')), findsOneWidget);
  expect(find.byKey(const Key('approve_gatepass_button')), findsOneWidget);
  expect(find.byKey(const Key('manage_rooms_button')), findsOneWidget);
}

Future<void> _testAdminRole(WidgetTester tester) async {
  // Login as admin
  await _loginAsRole(tester, 'admin@test.com', 'password123');

  // Verify admin-specific features
  expect(find.byKey(const Key('admin_dashboard')), findsOneWidget);
  expect(find.byKey(const Key('user_management')), findsOneWidget);
  expect(find.byKey(const Key('system_settings')), findsOneWidget);
}

Future<void> _loginAsRole(WidgetTester tester, String email, String password) async {
  await tester.enterText(find.byKey(const Key('email_field')), email);
  await tester.enterText(find.byKey(const Key('password_field')), password);
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

Future<void> _testAppPerformance(WidgetTester tester) async {
  // Test app startup time
  final stopwatch = Stopwatch()..start();
  
  app.main();
  await tester.pumpAndSettle();
  
  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // Less than 3 seconds

  // Test navigation performance
  stopwatch.reset();
  stopwatch.start();

  await tester.tap(find.byKey(const Key('attendance_tab')));
  await tester.pumpAndSettle();

  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(500)); // Less than 500ms
}

Future<void> _testResponsiveDesign(WidgetTester tester) async {
  // Test different screen sizes
  await tester.binding.setSurfaceSize(const Size(400, 800)); // Phone
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);

  await tester.binding.setSurfaceSize(const Size(800, 600)); // Tablet
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);

  await tester.binding.setSurfaceSize(const Size(1200, 800)); // Desktop
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('student_dashboard')), findsOneWidget);
}
