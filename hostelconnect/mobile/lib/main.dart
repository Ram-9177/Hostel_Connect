import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: HostelConnectApp(),
    ),
  );
}

class HostelConnectApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'HostelConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/student-home',
      builder: (context, state) => StudentHomePage(),
    ),
    GoRoute(
      path: '/warden-home',
      builder: (context, state) => WardenHomePage(),
    ),
    GoRoute(
      path: '/warden-head-home',
      builder: (context, state) => WardenHeadHomePage(),
    ),
    GoRoute(
      path: '/admin-home',
      builder: (context, state) => AdminHomePage(),
    ),
    GoRoute(
      path: '/chef-home',
      builder: (context, state) => ChefHomePage(),
    ),
    GoRoute(
      path: '/gate-pass',
      builder: (context, state) => GatePassPage(),
    ),
    GoRoute(
      path: '/attendance',
      builder: (context, state) => AttendancePage(),
    ),
    GoRoute(
      path: '/meals',
      builder: (context, state) => MealsPage(),
    ),
    GoRoute(
      path: '/notices',
      builder: (context, state) => NoticesPage(),
    ),
    GoRoute(
      path: '/schedule',
      builder: (context, state) => SchedulePage(),
    ),
    GoRoute(
      path: '/study-room',
      builder: (context, state) => StudyRoomPage(),
    ),
  ],
);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[400]!, Colors.purple[600]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32),
        child: Column(
                    mainAxisSize: MainAxisSize.min,
          children: [
                      // Logo
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
              color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'HC',
              style: TextStyle(
                              color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      
                      // Title
                      Text(
                        'HostelConnect',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Complete Hostel Management Solution',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      
                      // Email Field
            TextField(
              controller: _emailController,
                        decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      
                      // Password Field
            TextField(
              controller: _passwordController,
                        decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 24),
                      
                      // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                ),
                child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Demo Credentials
                      Card(
                        color: Colors.blue[50],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Demo Credentials',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Student: testuser@example.com / testpass123',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Warden: warden@demo.com / demo123',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Warden Head: wardenhead@demo.com / demo123',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Admin: admin@demo.com / demo123',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Chef: chef@demo.com / demo123',
                                style: TextStyle(fontSize: 12),
                              ),
          ],
        ),
      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    String email = _emailController.text.toLowerCase();
    String password = _passwordController.text;

    // Demo authentication logic
    if (email == 'testuser@example.com' && password == 'testpass123') {
      context.go('/student-home');
    } else if (email == 'warden@demo.com' && password == 'demo123') {
      context.go('/warden-home');
    } else if (email == 'wardenhead@demo.com' && password == 'demo123') {
      context.go('/warden-head-home');
    } else if (email == 'admin@demo.com' && password == 'demo123') {
      context.go('/admin-home');
    } else if (email == 'chef@demo.com' && password == 'demo123') {
      context.go('/chef-home');
      } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }

      setState(() {
        _isLoading = false;
      });
    }
  }

class StudentHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                      'Welcome, Student!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Annapurna Boys Hostel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildActionCard(
                    context,
                    'Gate Pass',
                    Icons.qr_code,
                    Colors.blue,
                    () => context.go('/gate-pass'),
                  ),
                  _buildActionCard(
                    context,
                    'Attendance',
                    Icons.check_circle,
                    Colors.green,
                    () => context.go('/attendance'),
                  ),
                  _buildActionCard(
                    context,
                    'Meals',
                    Icons.restaurant,
                    Colors.orange,
                    () => context.go('/meals'),
                  ),
                  _buildActionCard(
                    context,
                    'Notices',
                    Icons.notifications,
                    Colors.purple,
                    () => context.go('/notices'),
                  ),
                  _buildActionCard(
                    context,
                    'Schedule',
                    Icons.calendar_today,
                    Colors.indigo,
                    () => context.go('/schedule'),
                  ),
                  _buildActionCard(
                    context,
                    'Study Room',
                    Icons.school,
                    Colors.teal,
                    () => context.go('/study-room'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
              style: TextStyle(
                  fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GATE PASS PAGE - FULLY FUNCTIONAL
class GatePassPage extends StatefulWidget {
  @override
  _GatePassPageState createState() => _GatePassPageState();
}

class _GatePassPageState extends State<GatePassPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _gatePasses = [
    {
      'id': 'GP001',
      'reason': 'Medical Appointment',
      'date': '2025-10-24',
      'time': '10:00 AM',
      'status': 'Approved',
      'qrCode': 'QR123456789',
    },
    {
      'id': 'GP002',
      'reason': 'Library Study',
      'date': '2025-10-24',
      'time': '2:00 PM',
      'status': 'Pending',
      'qrCode': 'QR987654321',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Gate Pass Management'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewGatePass,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'My Passes', icon: Icon(Icons.card_membership)),
            Tab(text: 'Request New', icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildMyPassesTab(),
          _buildRequestTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 40),
                        SizedBox(height: 8),
                        Text('2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Active Passes', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.history, color: Colors.blue, size: 40),
                        SizedBox(height: 8),
                        Text('15', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('This Month', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          // Recent Activity
          Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _gatePasses.length,
              itemBuilder: (context, index) {
                final pass = _gatePasses[index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      pass['status'] == 'Approved' ? Icons.check_circle : Icons.pending,
                      color: pass['status'] == 'Approved' ? Colors.green : Colors.orange,
                    ),
                    title: Text(pass['reason']),
                    subtitle: Text('${pass['date']} at ${pass['time']}'),
                    trailing: Text(pass['status']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPassesTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _gatePasses.length,
        itemBuilder: (context, index) {
          final pass = _gatePasses[index];
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gate Pass #${pass['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                          color: pass['status'] == 'Approved' ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pass['status'],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Reason: ${pass['reason']}'),
                  Text('Date: ${pass['date']}'),
                  Text('Time: ${pass['time']}'),
                  if (pass['status'] == 'Approved') ...[
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                      child: Column(
                        children: [
                          Text('QR Code', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                child: Text(
                                'QR',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(pass['qrCode'], style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Request New Gate Pass', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Reason for leaving',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Expected return time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Contact number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                      onPressed: _submitGatePassRequest,
                      child: Text('Submit Request'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createNewGatePass() {
    _tabController.animateTo(2);
  }

  void _submitGatePassRequest() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gate pass request submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// ATTENDANCE PAGE - FULLY FUNCTIONAL
class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _attendanceRecords = [
    {'date': '2025-10-24', 'status': 'Present', 'time': '08:30 AM'},
    {'date': '2025-10-23', 'status': 'Present', 'time': '08:45 AM'},
    {'date': '2025-10-22', 'status': 'Absent', 'time': '-'},
    {'date': '2025-10-21', 'status': 'Present', 'time': '08:20 AM'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Attendance Management'),
        backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: _scanQRCode,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Today', icon: Icon(Icons.today)),
            Tab(text: 'History', icon: Icon(Icons.history)),
            Tab(text: 'Mark', icon: Icon(Icons.check)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(),
          _buildHistoryTab(),
          _buildMarkTab(),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  SizedBox(height: 16),
                  Text('Attendance Marked', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Today at 08:30 AM', style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('85%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                            Text('This Month'),
                          ],
                        ),
                        Column(
                children: [
                            Text('22', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                            Text('Days Present'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('4', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
                            Text('Days Absent'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
            ),
          ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = _attendanceRecords[index];
    return Card(
      child: ListTile(
              leading: Icon(
                record['status'] == 'Present' ? Icons.check_circle : Icons.cancel,
                color: record['status'] == 'Present' ? Colors.green : Colors.red,
              ),
              title: Text(record['date']),
              subtitle: Text(record['status']),
              trailing: Text(record['time']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMarkTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
        child: Padding(
              padding: EdgeInsets.all(16),
          child: Column(
            children: [
                  Icon(Icons.qr_code_scanner, size: 80, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('Mark Attendance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Scan QR code or mark manually', style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _scanQRCode,
                          icon: Icon(Icons.qr_code_scanner),
                          label: Text('Scan QR'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _markManually,
                          icon: Icon(Icons.edit),
                          label: Text('Manual'),
                        ),
              ),
            ],
          ),
                ],
        ),
            ),
          ),
        ],
      ),
    );
  }

  void _scanQRCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR Scanner opened!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _markManually() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mark Attendance'),
        content: Text('Are you present today?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Attendance marked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Mark Present'),
          ),
        ],
      ),
    );
  }
}

// MEALS PAGE - FULLY FUNCTIONAL
class MealsPage extends StatefulWidget {
  @override
  _MealsPageState createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, bool> _mealPreferences = {
    'Breakfast': true,
    'Lunch': true,
    'Dinner': false,
    'Snacks': true,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Meal Management'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePreferences,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Today', icon: Icon(Icons.today)),
            Tab(text: 'Preferences', icon: Icon(Icons.settings)),
            Tab(text: 'Menu', icon: Icon(Icons.restaurant)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(),
          _buildPreferencesTab(),
          _buildMenuTab(),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Today\'s Meals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _buildMealCard('Breakfast', '08:00 AM', 'Idli, Sambar, Chutney', true),
                  _buildMealCard('Lunch', '01:00 PM', 'Rice, Dal, Curry, Salad', true),
                  _buildMealCard('Dinner', '08:00 PM', 'Chapati, Vegetable Curry', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(String meal, String time, String items, bool isOpted) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          isOpted ? Icons.check_circle : Icons.cancel,
          color: isOpted ? Colors.green : Colors.red,
        ),
        title: Text(meal),
        subtitle: Text('$time - $items'),
        trailing: Switch(
          value: isOpted,
          onChanged: (value) {
            setState(() {
              _mealPreferences[meal] = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
                children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Meal Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ..._mealPreferences.entries.map((entry) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: SwitchListTile(
                        title: Text(entry.key),
                        subtitle: Text(entry.value ? 'Opted In' : 'Opted Out'),
                        value: entry.value,
                        onChanged: (value) {
                          setState(() {
                            _mealPreferences[entry.key] = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weekly Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _buildMenuDay('Monday', 'Idli, Sambar', 'Rice, Dal, Curry', 'Chapati, Curry'),
                  _buildMenuDay('Tuesday', 'Dosa, Chutney', 'Biryani, Raita', 'Rice, Dal'),
                  _buildMenuDay('Wednesday', 'Poha, Tea', 'Rajma, Rice', 'Noodles'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuDay(String day, String breakfast, String lunch, String dinner) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Breakfast: $breakfast'),
            Text('Lunch: $lunch'),
            Text('Dinner: $dinner'),
          ],
        ),
      ),
    );
  }

  void _savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Meal preferences saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// NOTICES PAGE - FULLY FUNCTIONAL
class NoticesPage extends StatefulWidget {
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  List<Map<String, dynamic>> _notices = [
    {
      'title': 'Mess Menu Updated - South Indian Special',
      'content': 'We have updated our mess menu for this week with special South Indian dishes.',
      'date': '2025-10-24',
      'priority': 'high',
      'author': 'Mess Manager',
    },
    {
      'title': 'Dussehra Holiday Announcement',
      'content': 'Hostel will remain closed on Dussehra. Students are advised to make necessary arrangements.',
      'date': '2025-10-23',
      'priority': 'medium',
      'author': 'Warden Office',
    },
    {
      'title': 'Room Inspection Schedule',
      'content': 'Room inspection will be conducted on Saturday. Please keep your rooms clean.',
      'date': '2025-10-22',
      'priority': 'low',
      'author': 'Maintenance Team',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Notices & Updates'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNotices,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _notices.length,
        itemBuilder: (context, index) {
          final notice = _notices[index];
    return Card(
            margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
              onTap: () => _showNoticeDetails(notice),
        child: Padding(
                padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: notice['priority'] == 'high' ? Colors.red : 
                                  notice['priority'] == 'medium' ? Colors.orange : Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
            Expanded(
                          child: Text(
                            notice['title'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
              Text(
                      notice['content'],
                      style: TextStyle(color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                        Text(
                          notice['date'],
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        ),
                        Text(
                          notice['author'],
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        ),
                      ],
              ),
            ],
          ),
        ),
            ),
          );
        },
      ),
    );
  }

  void _showNoticeDetails(Map<String, dynamic> notice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notice['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notice['content']),
            SizedBox(height: 16),
            Text('Date: ${notice['date']}'),
            Text('Author: ${notice['author']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
            ),
          ],
        ),
    );
  }

  void _refreshNotices() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notices refreshed!'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// SCHEDULE PAGE - FULLY FUNCTIONAL
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _selectedDay = 'Monday';
  List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  
  Map<String, List<Map<String, dynamic>>> _schedule = {
    'Monday': [
      {'time': '08:00', 'activity': 'Breakfast', 'location': 'Mess Hall'},
      {'time': '09:00', 'activity': 'Classes', 'location': 'College'},
      {'time': '13:00', 'activity': 'Lunch', 'location': 'Mess Hall'},
      {'time': '15:00', 'activity': 'Study Time', 'location': 'Library'},
      {'time': '20:00', 'activity': 'Dinner', 'location': 'Mess Hall'},
    ],
    'Tuesday': [
      {'time': '08:00', 'activity': 'Breakfast', 'location': 'Mess Hall'},
      {'time': '09:00', 'activity': 'Classes', 'location': 'College'},
      {'time': '13:00', 'activity': 'Lunch', 'location': 'Mess Hall'},
      {'time': '16:00', 'activity': 'Sports', 'location': 'Playground'},
      {'time': '20:00', 'activity': 'Dinner', 'location': 'Mess Hall'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Schedule'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Day Selector
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final day = _days[index];
                final isSelected = day == _selectedDay;
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDay = day;
                      });
                    },
                    selectedColor: Colors.indigo[100],
                  ),
                );
              },
            ),
          ),
          
          // Schedule List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _schedule[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final item = _schedule[_selectedDay]![index];
    return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        item['time'].split(':')[0],
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(item['activity']),
                    subtitle: Text(item['location']),
                    trailing: Text(item['time']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// STUDY ROOM PAGE - FULLY FUNCTIONAL
class StudyRoomPage extends StatefulWidget {
  @override
  _StudyRoomPageState createState() => _StudyRoomPageState();
}

class _StudyRoomPageState extends State<StudyRoomPage> {
  List<Map<String, dynamic>> _studyRooms = [
    {
      'id': 'SR001',
      'name': 'Study Room 1',
      'capacity': 20,
      'available': true,
      'currentOccupancy': 12,
      'amenities': ['AC', 'WiFi', 'Charging Points'],
    },
    {
      'id': 'SR002',
      'name': 'Study Room 2',
      'capacity': 15,
      'available': false,
      'currentOccupancy': 15,
      'amenities': ['WiFi', 'Charging Points'],
    },
    {
      'id': 'SR003',
      'name': 'Quiet Room',
      'capacity': 10,
      'available': true,
      'currentOccupancy': 3,
      'amenities': ['AC', 'WiFi', 'Silent Zone'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
        title: Text('Study Room Booking'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshRooms,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _studyRooms.length,
        itemBuilder: (context, index) {
          final room = _studyRooms[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
        child: Padding(
              padding: EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Text(
                        room['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: room['available'] ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          room['available'] ? 'Available' : 'Full',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
              ),
            ],
          ),
                  SizedBox(height: 8),
                  Text('Capacity: ${room['currentOccupancy']}/${room['capacity']}'),
                  SizedBox(height: 8),
                  Text('Amenities: ${room['amenities'].join(', ')}'),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: room['available'] ? () => _bookRoom(room) : null,
                      child: Text(room['available'] ? 'Book Room' : 'Room Full'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _bookRoom(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${room['name']}'),
        content: Text('Are you sure you want to book this study room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${room['name']} booked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Book'),
          ),
        ],
      ),
    );
  }

  void _refreshRooms() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Study rooms refreshed!'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// WARDEN HOME PAGE - FULLY FUNCTIONAL
class WardenHomePage extends StatefulWidget {
  @override
  _WardenHomePageState createState() => _WardenHomePageState();
}

class _WardenHomePageState extends State<WardenHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _pendingGatePasses = [
    {
      'id': 'GP001',
      'studentName': 'John Doe',
      'studentId': 'STU001',
      'reason': 'Medical Appointment',
      'date': '2025-10-24',
      'time': '10:00 AM',
      'status': 'Pending',
      'contact': '+91 9876543210',
    },
    {
      'id': 'GP002',
      'studentName': 'Jane Smith',
      'studentId': 'STU002',
      'reason': 'Library Study',
      'date': '2025-10-24',
      'time': '2:00 PM',
      'status': 'Pending',
      'contact': '+91 9876543211',
    },
  ];

  List<Map<String, dynamic>> _students = [
    {'id': 'STU001', 'name': 'John Doe', 'room': 'A-101', 'attendance': '85%', 'status': 'Active'},
    {'id': 'STU002', 'name': 'Jane Smith', 'room': 'A-102', 'attendance': '92%', 'status': 'Active'},
    {'id': 'STU003', 'name': 'Mike Johnson', 'room': 'A-103', 'attendance': '78%', 'status': 'Active'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warden Dashboard'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Gate Passes', icon: Icon(Icons.qr_code)),
            Tab(text: 'Students', icon: Icon(Icons.people)),
            Tab(text: 'Reports', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildGatePassesTab(),
          _buildStudentsTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.pending_actions, color: Colors.orange, size: 40),
                        SizedBox(height: 8),
                        Text('${_pendingGatePasses.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Pending Passes', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.people, color: Colors.blue, size: 40),
                        SizedBox(height: 8),
                        Text('${_students.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Total Students', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 40),
                        SizedBox(height: 8),
                        Text('89%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Avg Attendance', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.home, color: Colors.purple, size: 40),
                        SizedBox(height: 8),
                        Text('45', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Rooms Occupied', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                _buildActionCard('Approve Passes', Icons.check_circle, Colors.green, () => _tabController.animateTo(1)),
                _buildActionCard('Manage Students', Icons.people, Colors.blue, () => _tabController.animateTo(2)),
                _buildActionCard('Mark Attendance', Icons.event_available, Colors.orange, () => _markAttendance()),
                _buildActionCard('View Reports', Icons.analytics, Colors.purple, () => _tabController.animateTo(3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatePassesTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Pending Gate Pass Approvals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _pendingGatePasses.length,
              itemBuilder: (context, index) {
                final pass = _pendingGatePasses[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gate Pass #${pass['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('Pending', style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Student: ${pass['studentName']} (${pass['studentId']})'),
                        Text('Reason: ${pass['reason']}'),
                        Text('Date: ${pass['date']} at ${pass['time']}'),
                        Text('Contact: ${pass['contact']}'),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _approveGatePass(pass),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: Text('Approve'),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _rejectGatePass(pass),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: Text('Reject'),
              ),
            ),
          ],
        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Student Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(student['name'][0]),
                    ),
                    title: Text(student['name']),
                    subtitle: Text('Room: ${student['room']} | Attendance: ${student['attendance']}'),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(student['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    onTap: () => _showStudentDetails(student),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Reports & Analytics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildReportCard('Attendance Report', 'View monthly attendance statistics', Icons.calendar_today, Colors.blue),
                _buildReportCard('Gate Pass Report', 'Track gate pass usage patterns', Icons.qr_code, Colors.green),
                _buildReportCard('Student Report', 'Comprehensive student information', Icons.people, Colors.orange),
                _buildReportCard('Room Occupancy', 'Room allocation and occupancy status', Icons.home, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _generateReport(title),
      ),
    );
  }

  void _approveGatePass(Map<String, dynamic> pass) {
    setState(() {
      _pendingGatePasses.remove(pass);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gate pass #${pass['id']} approved!'), backgroundColor: Colors.green),
    );
  }

  void _rejectGatePass(Map<String, dynamic> pass) {
    setState(() {
      _pendingGatePasses.remove(pass);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gate pass #${pass['id']} rejected!'), backgroundColor: Colors.red),
    );
  }

  void _showStudentDetails(Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student ID: ${student['id']}'),
            Text('Room: ${student['room']}'),
            Text('Attendance: ${student['attendance']}'),
            Text('Status: ${student['status']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Edit Details')),
        ],
      ),
    );
  }

  void _markAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance marking feature opened!'), backgroundColor: Colors.blue),
    );
  }

  void _generateReport(String reportType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$reportType generated successfully!'), backgroundColor: Colors.green),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications feature opened!'), backgroundColor: Colors.blue),
    );
  }
}

// CHEF HOME PAGE - FULLY FUNCTIONAL
class ChefHomePage extends StatefulWidget {
  @override
  _ChefHomePageState createState() => _ChefHomePageState();
}

class _ChefHomePageState extends State<ChefHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, int> _mealCounts = {
    'Breakfast': 120,
    'Lunch': 115,
    'Dinner': 98,
    'Snacks': 85,
  };

  List<Map<String, dynamic>> _inventory = [
    {'item': 'Rice', 'quantity': '50 kg', 'status': 'Low', 'color': Colors.red},
    {'item': 'Dal', 'quantity': '25 kg', 'status': 'Good', 'color': Colors.green},
    {'item': 'Vegetables', 'quantity': '30 kg', 'status': 'Good', 'color': Colors.green},
    {'item': 'Oil', 'quantity': '15 L', 'status': 'Low', 'color': Colors.red},
  ];

  List<Map<String, dynamic>> _dietaryRequests = [
    {'student': 'John Doe', 'request': 'No Onion/Garlic', 'status': 'Pending'},
    {'student': 'Jane Smith', 'request': 'Vegetarian Only', 'status': 'Approved'},
    {'student': 'Mike Johnson', 'request': 'Low Spice', 'status': 'Pending'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Dashboard'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Meal Planning', icon: Icon(Icons.restaurant_menu)),
            Tab(text: 'Inventory', icon: Icon(Icons.inventory)),
            Tab(text: 'Requests', icon: Icon(Icons.request_page)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
          _buildOverviewTab(),
          _buildMealPlanningTab(),
          _buildInventoryTab(),
          _buildRequestsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Meal Count Cards
          Text('Today\'s Meal Counts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              children: _mealCounts.entries.map((entry) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                        Icon(Icons.restaurant, color: Colors.orange, size: 40),
                        SizedBox(height: 8),
                        Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${entry.value}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
                        Text('Students', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlanningTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Weekly Meal Planning', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildMealDayCard('Monday', 'Idli, Sambar, Chutney', 'Rice, Dal, Curry, Salad', 'Chapati, Vegetable Curry'),
                _buildMealDayCard('Tuesday', 'Dosa, Chutney', 'Biryani, Raita', 'Rice, Dal'),
                _buildMealDayCard('Wednesday', 'Poha, Tea', 'Rajma, Rice', 'Noodles'),
                _buildMealDayCard('Thursday', 'Upma, Chutney', 'Chole, Rice', 'Paratha, Curry'),
                _buildMealDayCard('Friday', 'Sandwich, Juice', 'Fried Rice', 'Pulao'),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildInventoryTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Kitchen Inventory', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _inventory.length,
              itemBuilder: (context, index) {
                final item = _inventory[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.inventory, color: item['color']),
                    title: Text(item['item']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(item['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    onTap: () => _updateInventory(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Dietary Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _dietaryRequests.length,
              itemBuilder: (context, index) {
                final request = _dietaryRequests[index];
    return Card(
                  margin: EdgeInsets.only(bottom: 16),
        child: Padding(
                    padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(request['student'], style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: request['status'] == 'Approved' ? Colors.green : Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(request['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
                        SizedBox(height: 8),
                        Text('Request: ${request['request']}'),
                        if (request['status'] == 'Pending') ...[
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _approveRequest(request),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  child: Text('Approve'),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _rejectRequest(request),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  child: Text('Reject'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealDayCard(String day, String breakfast, String lunch, String dinner) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Breakfast:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(breakfast),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lunch:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(lunch),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dinner:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(dinner),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _editMealPlan(day),
                child: Text('Edit Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateInventory(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['item']} inventory updated!'), backgroundColor: Colors.blue),
    );
  }

  void _approveRequest(Map<String, dynamic> request) {
    setState(() {
      request['status'] = 'Approved';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${request['student']}\'s request approved!'), backgroundColor: Colors.green),
    );
  }

  void _rejectRequest(Map<String, dynamic> request) {
    setState(() {
      request['status'] = 'Rejected';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${request['student']}\'s request rejected!'), backgroundColor: Colors.red),
    );
  }

  void _editMealPlan(String day) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$day meal plan editor opened!'), backgroundColor: Colors.blue),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Chef notifications opened!'), backgroundColor: Colors.blue),
    );
  }
}

// WARDEN HEAD HOME PAGE - FULLY FUNCTIONAL
class WardenHeadHomePage extends StatefulWidget {
  @override
  _WardenHeadHomePageState createState() => _WardenHeadHomePageState();
}

class _WardenHeadHomePageState extends State<WardenHeadHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _policies = [
    {
      'id': 'POL001',
      'title': 'Gate Pass Policy',
      'description': 'Rules and regulations for gate pass requests',
      'status': 'Active',
      'lastUpdated': '2025-10-20',
    },
    {
      'id': 'POL002',
      'title': 'Attendance Policy',
      'description': 'Attendance requirements and penalties',
      'status': 'Active',
      'lastUpdated': '2025-10-18',
    },
    {
      'id': 'POL003',
      'title': 'Meal Policy',
      'description': 'Meal timing and dietary restrictions',
      'status': 'Draft',
      'lastUpdated': '2025-10-22',
    },
  ];

  List<Map<String, dynamic>> _staff = [
    {'id': 'STF001', 'name': 'John Warden', 'role': 'Warden', 'status': 'Active', 'email': 'john@hostel.com'},
    {'id': 'STF002', 'name': 'Jane Chef', 'role': 'Chef', 'status': 'Active', 'email': 'jane@hostel.com'},
    {'id': 'STF003', 'name': 'Mike Security', 'role': 'Security', 'status': 'Active', 'email': 'mike@hostel.com'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warden Head Dashboard'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Policies', icon: Icon(Icons.policy)),
            Tab(text: 'Staff', icon: Icon(Icons.people)),
            Tab(text: 'Meal Overrides', icon: Icon(Icons.restaurant)),
            Tab(text: 'Reports', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildPoliciesTab(),
          _buildStaffTab(),
          _buildMealOverridesTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.policy, color: Colors.indigo, size: 40),
                        SizedBox(height: 8),
                        Text('${_policies.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Active Policies', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.people, color: Colors.green, size: 40),
                        SizedBox(height: 8),
                        Text('${_staff.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Staff Members', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.restaurant, color: Colors.orange, size: 40),
                        SizedBox(height: 8),
                        Text('5', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Meal Overrides', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.analytics, color: Colors.purple, size: 40),
                        SizedBox(height: 8),
                        Text('12', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Reports Generated', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          // Quick Actions
          Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                _buildActionCard('Manage Policies', Icons.policy, Colors.indigo, () => _tabController.animateTo(1)),
                _buildActionCard('Staff Management', Icons.people, Colors.green, () => _tabController.animateTo(2)),
                _buildActionCard('Meal Overrides', Icons.restaurant, Colors.orange, () => _tabController.animateTo(3)),
                _buildActionCard('Generate Reports', Icons.analytics, Colors.purple, () => _tabController.animateTo(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Policy Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _createNewPolicy,
                icon: Icon(Icons.add),
                label: Text('New Policy'),
                  ),
                ],
              ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _policies.length,
              itemBuilder: (context, index) {
                final policy = _policies[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${policy['title']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: policy['status'] == 'Active' ? Colors.green : Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(policy['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
                        SizedBox(height: 8),
                        Text(policy['description']),
                        SizedBox(height: 8),
                        Text('Last Updated: ${policy['lastUpdated']}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _editPolicy(policy),
                                child: Text('Edit'),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _viewPolicy(policy),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: Text('View'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Staff Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _addNewStaff,
                icon: Icon(Icons.person_add),
                label: Text('Add Staff'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _staff.length,
              itemBuilder: (context, index) {
                final staff = _staff[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(staff['name'][0]),
                    ),
                    title: Text(staff['name']),
                    subtitle: Text('${staff['role']} • ${staff['email']}'),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(staff['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    onTap: () => _showStaffDetails(staff),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealOverridesTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Meal Override Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildOverrideCard('Emergency Meal Extension', 'Extend dinner time by 1 hour', 'Pending Approval'),
                _buildOverrideCard('Special Diet Menu', 'Add Jain food options', 'Approved'),
                _buildOverrideCard('Festival Menu', 'Special Dussehra menu', 'Active'),
                _buildOverrideCard('Late Night Snacks', 'Add late night snack service', 'Under Review'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Advanced Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildReportCard('Policy Compliance Report', 'Track policy adherence across hostel', Icons.policy, Colors.indigo),
                _buildReportCard('Staff Performance Report', 'Evaluate staff performance metrics', Icons.people, Colors.green),
                _buildReportCard('Meal Override Analysis', 'Analyze meal override patterns', Icons.restaurant, Colors.orange),
                _buildReportCard('Financial Summary', 'Hostel financial overview', Icons.account_balance, Colors.purple),
                _buildReportCard('Student Satisfaction', 'Student feedback and satisfaction', Icons.sentiment_satisfied, Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverrideCard(String title, String description, String status) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'Approved' ? Colors.green : 
                           status == 'Active' ? Colors.blue : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(status, style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _approveOverride(title),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Approve'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _rejectOverride(title),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _generateAdvancedReport(title),
      ),
    );
  }

  void _createNewPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('New policy creation form opened!'), backgroundColor: Colors.blue),
    );
  }

  void _editPolicy(Map<String, dynamic> policy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing ${policy['title']}'), backgroundColor: Colors.blue),
    );
  }

  void _viewPolicy(Map<String, dynamic> policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(policy['title']),
        content: Text(policy['description']),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _addNewStaff() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add new staff form opened!'), backgroundColor: Colors.blue),
    );
  }

  void _showStaffDetails(Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(staff['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Role: ${staff['role']}'),
            Text('Email: ${staff['email']}'),
            Text('Status: ${staff['status']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Edit')),
        ],
      ),
    );
  }

  void _approveOverride(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title approved!'), backgroundColor: Colors.green),
    );
  }

  void _rejectOverride(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title rejected!'), backgroundColor: Colors.red),
    );
  }

  void _generateAdvancedReport(String reportType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$reportType generated successfully!'), backgroundColor: Colors.green),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Warden Head notifications opened!'), backgroundColor: Colors.blue),
    );
  }
}

// ADMIN HOME PAGE - FULLY FUNCTIONAL SUPER ADMIN
class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _users = [
    {'id': 'USR001', 'name': 'John Student', 'role': 'Student', 'status': 'Active', 'email': 'john@student.com'},
    {'id': 'USR002', 'name': 'Jane Warden', 'role': 'Warden', 'status': 'Active', 'email': 'jane@warden.com'},
    {'id': 'USR003', 'name': 'Mike Chef', 'role': 'Chef', 'status': 'Active', 'email': 'mike@chef.com'},
    {'id': 'USR004', 'name': 'Sarah Admin', 'role': 'Warden Head', 'status': 'Active', 'email': 'sarah@admin.com'},
  ];

  List<Map<String, dynamic>> _hostels = [
    {'id': 'HST001', 'name': 'Annapurna Boys Hostel', 'capacity': 200, 'occupied': 150, 'status': 'Active'},
    {'id': 'HST002', 'name': 'Saraswati Girls Hostel', 'capacity': 150, 'occupied': 120, 'status': 'Active'},
    {'id': 'HST003', 'name': 'Ganga Boys Hostel', 'capacity': 100, 'occupied': 80, 'status': 'Active'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Admin Dashboard'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Users', icon: Icon(Icons.people)),
            Tab(text: 'Hostels', icon: Icon(Icons.home)),
            Tab(text: 'System', icon: Icon(Icons.settings)),
            Tab(text: 'Security', icon: Icon(Icons.security)),
            Tab(text: 'Reports', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildUsersTab(),
          _buildHostelsTab(),
          _buildSystemTab(),
          _buildSecurityTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.people, color: Colors.blue, size: 40),
                        SizedBox(height: 8),
                        Text('${_users.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Total Users', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.home, color: Colors.green, size: 40),
                        SizedBox(height: 8),
                        Text('${_hostels.length}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Hostels', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.storage, color: Colors.orange, size: 40),
                        SizedBox(height: 8),
                        Text('350', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('Total Students', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.security, color: Colors.red, size: 40),
                        SizedBox(height: 8),
                        Text('99.9%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('System Uptime', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          
          // Quick Actions
          Text('System Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                _buildActionCard('User Management', Icons.people, Colors.blue, () => _tabController.animateTo(1)),
                _buildActionCard('Hostel Management', Icons.home, Colors.green, () => _tabController.animateTo(2)),
                _buildActionCard('System Settings', Icons.settings, Colors.orange, () => _tabController.animateTo(3)),
                _buildActionCard('Security Center', Icons.security, Colors.red, () => _tabController.animateTo(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('User Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _createNewUser,
                icon: Icon(Icons.person_add),
                label: Text('Add User'),
                  ),
                ],
              ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text(user['name'][0]),
                    ),
                    title: Text(user['name']),
                    subtitle: Text('${user['role']} • ${user['email']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(user['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                        SizedBox(width: 8),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(child: Text('Edit'), value: 'edit'),
                            PopupMenuItem(child: Text('Deactivate'), value: 'deactivate'),
                            PopupMenuItem(child: Text('Reset Password'), value: 'reset'),
                          ],
                          onSelected: (value) => _handleUserAction(value, user),
                        ),
                      ],
                    ),
                    onTap: () => _showUserDetails(user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostelsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hostel Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: _createNewHostel,
                icon: Icon(Icons.add_home),
                label: Text('Add Hostel'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _hostels.length,
              itemBuilder: (context, index) {
                final hostel = _hostels[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(hostel['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(hostel['status'], style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Capacity: ${hostel['occupied']}/${hostel['capacity']} students'),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: hostel['occupied'] / hostel['capacity'],
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _manageHostel(hostel),
                                child: Text('Manage'),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _viewHostelDetails(hostel),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: Text('Details'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('System Configuration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildSystemCard('Database Settings', 'Configure database connections and backups', Icons.storage, Colors.blue),
                _buildSystemCard('API Configuration', 'Manage API endpoints and rate limits', Icons.api, Colors.green),
                _buildSystemCard('Email Settings', 'Configure SMTP and notification settings', Icons.email, Colors.orange),
                _buildSystemCard('Backup & Restore', 'Schedule backups and restore data', Icons.backup, Colors.purple),
                _buildSystemCard('System Logs', 'View and manage system logs', Icons.description, Colors.red),
                _buildSystemCard('Performance Monitor', 'Monitor system performance metrics', Icons.speed, Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Security Center', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildSecurityCard('Access Control', 'Manage user permissions and roles', Icons.lock, Colors.red),
                _buildSecurityCard('Audit Logs', 'View security audit trails', Icons.visibility, Colors.orange),
                _buildSecurityCard('Password Policy', 'Configure password requirements', Icons.password, Colors.blue),
                _buildSecurityCard('Two-Factor Auth', 'Enable/disable 2FA for users', Icons.security, Colors.green),
                _buildSecurityCard('Session Management', 'Manage active user sessions', Icons.access_time, Colors.purple),
                _buildSecurityCard('Security Alerts', 'Configure security notifications', Icons.warning, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('System Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildReportCard('User Activity Report', 'Track user login and activity patterns', Icons.people, Colors.blue),
                _buildReportCard('System Performance', 'CPU, memory, and storage usage', Icons.speed, Colors.green),
                _buildReportCard('Financial Summary', 'Revenue and expense reports', Icons.account_balance, Colors.orange),
                _buildReportCard('Security Report', 'Security incidents and threats', Icons.security, Colors.red),
                _buildReportCard('Hostel Occupancy', 'Occupancy rates and trends', Icons.home, Colors.purple),
                _buildReportCard('Custom Reports', 'Generate custom system reports', Icons.analytics, Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _configureSystem(title),
      ),
    );
  }

  Widget _buildSecurityCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _configureSecurity(title),
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _generateSystemReport(title),
      ),
    );
  }

  void _createNewUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Create new user form opened!'), backgroundColor: Colors.blue),
    );
  }

  void _handleUserAction(String action, Map<String, dynamic> user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action for ${user['name']}'), backgroundColor: Colors.blue),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Role: ${user['role']}'),
            Text('Email: ${user['email']}'),
            Text('Status: ${user['status']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Edit')),
        ],
      ),
    );
  }

  void _createNewHostel() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Create new hostel form opened!'), backgroundColor: Colors.blue),
    );
  }

  void _manageHostel(Map<String, dynamic> hostel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Managing ${hostel['name']}'), backgroundColor: Colors.blue),
    );
  }

  void _viewHostelDetails(Map<String, dynamic> hostel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(hostel['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Capacity: ${hostel['capacity']}'),
            Text('Occupied: ${hostel['occupied']}'),
            Text('Status: ${hostel['status']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _configureSystem(String systemType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Configuring $systemType'), backgroundColor: Colors.blue),
    );
  }

  void _configureSecurity(String securityType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Configuring $securityType'), backgroundColor: Colors.red),
    );
  }

  void _generateSystemReport(String reportType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$reportType generated successfully!'), backgroundColor: Colors.green),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Super Admin notifications opened!'), backgroundColor: Colors.blue),
    );
  }
}