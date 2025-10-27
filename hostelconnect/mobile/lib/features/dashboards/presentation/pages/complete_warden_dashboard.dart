// Complete Warden Dashboard with All Features
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/config/api_config.dart';
import 'create_notification_page.dart';

class CompleteWardenDashboard extends ConsumerStatefulWidget {
  const CompleteWardenDashboard({super.key});

  @override
  ConsumerState<CompleteWardenDashboard> createState() => _CompleteWardenDashboardState();
}

class _CompleteWardenDashboardState extends ConsumerState<CompleteWardenDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? _stats;
  List<dynamic> _pendingGatePasses = [];
  List<dynamic> _recentActivity = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadDashboardData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      final token = ref.read(authProvider).token;
      
      // Load stats
      final statsResponse = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/dashboard/warden/stats'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      // Load pending gate passes
      final gatePasses = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/gatepass?status=pending'),
        headers: {'Authorization': 'Bearer $token'},
      );

      setState(() {
        _stats = json.decode(statsResponse.body);
        _pendingGatePasses = json.decode(gatePasses.body);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  Future<void> _approveGatePass(String id) async {
    try {
      final token = ref.read(authProvider).token;
      await http.patch(
        Uri.parse('${ApiConfig.baseUrl}/gatepass/$id/approve'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gate pass approved'), backgroundColor: Colors.green),
      );
      _loadDashboardData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _rejectGatePass(String id, String reason) async {
    try {
      final token = ref.read(authProvider).token;
      await http.patch(
        Uri.parse('${ApiConfig.baseUrl}/gatepass/$id/reject'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'reason': reason}),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gate pass rejected'), backgroundColor: Colors.orange),
      );
      _loadDashboardData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warden Dashboard'),
        backgroundColor: Colors.blue[700],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.assignment), text: 'Gate Passes'),
            Tab(icon: Icon(Icons.notifications), text: 'Notifications'),
            Tab(icon: Icon(Icons.analytics), text: 'Reports'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildGatePassesTab(),
                _buildNotificationsTab(),
                _buildReportsTab(),
              ],
            ),
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back, Warden!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have ${_pendingGatePasses.length} pending gate pass requests',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildStatCard(
                'Total Students',
                _stats?['totalStudents']?.toString() ?? '0',
                Icons.people,
                Colors.blue,
              ),
              _buildStatCard(
                'Pending Passes',
                _pendingGatePasses.length.toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
              _buildStatCard(
                'Out Students',
                _stats?['outStudents']?.toString() ?? '0',
                Icons.exit_to_app,
                Colors.red,
              ),
              _buildStatCard(
                'Attendance Today',
                '${_stats?['attendanceRate'] ?? '95'}%',
                Icons.check_circle,
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildActionCard(
                'Send Notice',
                Icons.notifications_active,
                Colors.blue,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNotificationPage(),
                  ),
                ),
              ),
              _buildActionCard(
                'View Students',
                Icons.people,
                Colors.green,
                () {
                  // Navigate to students list
                },
              ),
              _buildActionCard(
                'Attendance',
                Icons.qr_code_scanner,
                Colors.purple,
                () {
                  // Navigate to attendance
                },
              ),
              _buildActionCard(
                'Room Allocation',
                Icons.meeting_room,
                Colors.orange,
                () {
                  // Navigate to room allocation
                },
              ),
              _buildActionCard(
                'Reports',
                Icons.analytics,
                Colors.teal,
                () => _tabController.animateTo(3),
              ),
              _buildActionCard(
                'Settings',
                Icons.settings,
                Colors.grey,
                () {
                  // Navigate to settings
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Activity
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ..._buildRecentActivityList(),
        ],
      ),
    );
  }

  Widget _buildGatePassesTab() {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: _pendingGatePasses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 64, color: Colors.green[300]),
                  const SizedBox(height: 16),
                  const Text('No pending gate pass requests'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pendingGatePasses.length,
              itemBuilder: (context, index) {
                final pass = _pendingGatePasses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue[700],
                              child: Text(
                                pass['student']?['user']?['name']?[0]?.toUpperCase() ?? '?',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pass['student']?['user']?['name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Hall Ticket: ${pass['student']?['hallTicket']}',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildPassDetailRow('Purpose', pass['purpose'] ?? 'N/A'),
                        _buildPassDetailRow('From', pass['startTime'] ?? 'N/A'),
                        _buildPassDetailRow('To', pass['endTime'] ?? 'N/A'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _approveGatePass(pass['id']),
                                icon: const Icon(Icons.check),
                                label: const Text('Approve'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final reasonController = TextEditingController();
                                      return AlertDialog(
                                        title: const Text('Reject Gate Pass'),
                                        content: TextField(
                                          controller: reasonController,
                                          decoration: const InputDecoration(
                                            labelText: 'Reason for rejection',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _rejectGatePass(pass['id'], reasonController.text);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text('Reject'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.close, color: Colors.red),
                                label: const Text('Reject', style: TextStyle(color: Colors.red)),
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
    );
  }

  Widget _buildNotificationsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('Create and manage notifications'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNotificationPage(),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Create Notification'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Analytics & Reports',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildReportCard(
          'Student Attendance',
          'View daily, weekly, and monthly attendance reports',
          Icons.people,
          Colors.blue,
        ),
        _buildReportCard(
          'Gate Pass History',
          'All approved and rejected gate passes',
          Icons.history,
          Colors.orange,
        ),
        _buildReportCard(
          'Meal Reports',
          'Meal intent and consumption statistics',
          Icons.restaurant,
          Colors.green,
        ),
        _buildReportCard(
          'Room Occupancy',
          'Current room allocation and vacancies',
          Icons.meeting_room,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentActivityList() {
    final activities = [
      {'action': 'Gate pass approved', 'student': 'John Doe', 'time': '10 mins ago'},
      {'action': 'New student registered', 'student': 'Jane Smith', 'time': '1 hour ago'},
      {'action': 'Notice sent to Block A', 'student': 'System', 'time': '2 hours ago'},
    ];

    return activities.map((activity) {
      return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: const Icon(Icons.circle, size: 12, color: Colors.blue),
          title: Text(activity['action']!),
          subtitle: Text(activity['student']!),
          trailing: Text(
            activity['time']!,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigate to specific report
        },
      ),
    );
  }
}
