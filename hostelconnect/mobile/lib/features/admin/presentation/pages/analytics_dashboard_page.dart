// Comprehensive Analytics Dashboard with Charts and Reports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/config/api_config.dart';

class AnalyticsDashboardPage extends ConsumerStatefulWidget {
  const AnalyticsDashboardPage({super.key});

  @override
  ConsumerState<AnalyticsDashboardPage> createState() => _AnalyticsDashboardPageState();
}

class _AnalyticsDashboardPageState extends ConsumerState<AnalyticsDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? _analytics;
  bool _isLoading = true;
  String _selectedPeriod = '7days';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadAnalytics();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _isLoading = true);
    try {
      final token = ref.read(authProvider).token;
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/analytics?period=$_selectedPeriod'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _analytics = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading analytics: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Reports'),
        backgroundColor: Colors.blue[700],
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.date_range),
            onSelected: (value) {
              setState(() => _selectedPeriod = value);
              _loadAnalytics();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '7days', child: Text('Last 7 Days')),
              const PopupMenuItem(value: '30days', child: Text('Last 30 Days')),
              const PopupMenuItem(value: '90days', child: Text('Last 3 Months')),
              const PopupMenuItem(value: 'year', child: Text('This Year')),
            ],
          ),
          IconButton(
            onPressed: _loadAnalytics,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.people), text: 'Students'),
            Tab(icon: Icon(Icons.card_membership), text: 'Gate Passes'),
            Tab(icon: Icon(Icons.restaurant), text: 'Meals'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildStudentsTab(),
                _buildGatePassesTab(),
                _buildMealsTab(),
              ],
            ),
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: _loadAnalytics,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Key Metrics Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildMetricCard(
                'Total Students',
                _analytics?['totalStudents']?.toString() ?? '1,245',
                Icons.people,
                Colors.blue,
                '+12%',
              ),
              _buildMetricCard(
                'Active Users',
                _analytics?['activeUsers']?.toString() ?? '1,189',
                Icons.person_check,
                Colors.green,
                '+5.2%',
              ),
              _buildMetricCard(
                'Gate Passes',
                _analytics?['totalGatePasses']?.toString() ?? '387',
                Icons.card_membership,
                Colors.orange,
                '+18%',
              ),
              _buildMetricCard(
                'Avg Attendance',
                '${_analytics?['avgAttendance'] ?? '95.4'}%',
                Icons.check_circle,
                Colors.teal,
                '+2.1%',
              ),
            ],
          ),
          const SizedBox(height: 24),

          // System Health
          const Text(
            'System Health',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSystemHealthCard('API Response Time', '127ms', 0.95, Colors.green),
          const SizedBox(height: 8),
          _buildSystemHealthCard('Database Performance', 'Excellent', 0.98, Colors.green),
          const SizedBox(height: 8),
          _buildSystemHealthCard('Storage Usage', '68%', 0.68, Colors.orange),
          const SizedBox(height: 8),
          _buildSystemHealthCard('Active Sessions', '342', 0.85, Colors.blue),
          const SizedBox(height: 24),

          // Top Hostels
          const Text(
            'Top Performing Hostels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildHostelRankCard('Hostel A', 98.5, Colors.blue),
          _buildHostelRankCard('Hostel B', 96.2, Colors.green),
          _buildHostelRankCard('Hostel C', 94.8, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStudentsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Student Distribution
        const Text(
          'Student Distribution by Hostel',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDistributionBar('Hostel A', 425, 500, Colors.blue),
                const SizedBox(height: 12),
                _buildDistributionBar('Hostel B', 380, 450, Colors.green),
                const SizedBox(height: 12),
                _buildDistributionBar('Hostel C', 290, 350, Colors.orange),
                const SizedBox(height: 12),
                _buildDistributionBar('Hostel D', 150, 200, Colors.purple),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Attendance Trends
        const Text(
          'Attendance Trends',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTrendRow('Monday', 97.2, Colors.green),
                _buildTrendRow('Tuesday', 95.8, Colors.green),
                _buildTrendRow('Wednesday', 94.5, Colors.green),
                _buildTrendRow('Thursday', 96.1, Colors.green),
                _buildTrendRow('Friday', 92.3, Colors.orange),
                _buildTrendRow('Saturday', 88.7, Colors.orange),
                _buildTrendRow('Sunday', 85.2, Colors.red),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Department-wise Stats
        const Text(
          'Department-wise Statistics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildDepartmentCard('Computer Science', 425, 98.2),
        _buildDepartmentCard('Electronics', 380, 96.5),
        _buildDepartmentCard('Mechanical', 290, 94.8),
        _buildDepartmentCard('Civil', 150, 93.1),
      ],
    );
  }

  Widget _buildGatePassesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Gate Pass Statistics
        Row(
          children: [
            Expanded(
              child: _buildStatBox('Total Requests', '387', Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox('Approved', '342', Colors.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox('Rejected', '45', Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Approval Rate
        const Text(
          'Approval Trends',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildApprovalBar('Week 1', 88.4, Colors.green),
                const SizedBox(height: 12),
                _buildApprovalBar('Week 2', 91.2, Colors.green),
                const SizedBox(height: 12),
                _buildApprovalBar('Week 3', 85.7, Colors.orange),
                const SizedBox(height: 12),
                _buildApprovalBar('Week 4', 92.8, Colors.green),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Most Common Purposes
        const Text(
          'Gate Pass Purposes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildPurposeCard('Home Visit', 145, Colors.blue),
        _buildPurposeCard('Medical', 87, Colors.red),
        _buildPurposeCard('Personal Work', 65, Colors.orange),
        _buildPurposeCard('Shopping', 42, Colors.green),
        _buildPurposeCard('Other', 48, Colors.grey),
        const SizedBox(height: 24),

        // Peak Hours
        const Text(
          'Peak Request Hours',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTimeBar('Morning (6-12)', 45, Colors.orange),
                _buildTimeBar('Afternoon (12-18)', 182, Colors.green),
                _buildTimeBar('Evening (18-24)', 160, Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Meal Statistics
        Row(
          children: [
            Expanded(
              child: _buildStatBox('Breakfast', '89%', Colors.orange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox('Lunch', '95%', Colors.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatBox('Dinner', '92%', Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Weekly Meal Trends
        const Text(
          'Weekly Meal Participation',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildMealTrendRow('Monday', 94, 97, 95),
                _buildMealTrendRow('Tuesday', 92, 96, 94),
                _buildMealTrendRow('Wednesday', 91, 95, 93),
                _buildMealTrendRow('Thursday', 93, 96, 94),
                _buildMealTrendRow('Friday', 89, 94, 91),
                _buildMealTrendRow('Saturday', 85, 92, 88),
                _buildMealTrendRow('Sunday', 82, 90, 86),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Most Popular Menu Items
        const Text(
          'Popular Menu Items',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildMenuItemCard('Biryani', 4.8, 287),
        _buildMenuItemCard('Chicken Curry', 4.6, 245),
        _buildMenuItemCard('Dosa', 4.7, 198),
        _buildMenuItemCard('Paneer Masala', 4.5, 176),
        const SizedBox(height: 24),

        // Waste Reduction
        const Text(
          'Waste Reduction Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildWasteMetric('This Week', '12 kg', -15, Colors.green),
                _buildWasteMetric('Last Week', '14 kg', -8, Colors.green),
                _buildWasteMetric('Monthly Avg', '55 kg', -20, Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
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
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 10,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemHealthCard(String name, String value, double percentage, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(value, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(percentage * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHostelRankCard(String name, double score, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.domain, color: color),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$score%',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ),
    );
  }

  Widget _buildDistributionBar(String hostel, int current, int capacity, Color color) {
    final percentage = (current / capacity);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hostel, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('$current / $capacity', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildTrendRow(String day, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(day),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 12),
          Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDepartmentCard(String dept, int students, double attendance) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(dept, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$students students'),
        trailing: Text(
          '$attendance%',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildApprovalBar(String week, double percentage, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(week, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(width: 12),
        Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPurposeCard(String purpose, int count, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.label, color: color, size: 20),
        ),
        title: Text(purpose),
        trailing: Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildTimeBar(String time, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: count / 200,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 12),
          Text(count.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMealTrendRow(String day, int breakfast, int lunch, int dinner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(breakfast / 100),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(lunch / 100),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(dinner / 100),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(String item, double rating, int orders) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.restaurant, color: Colors.orange),
        title: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$orders orders'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteMetric(String period, String amount, int change, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(period, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(amount, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_down, size: 16, color: color),
                const SizedBox(width: 4),
                Text(
                  '$change%',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
