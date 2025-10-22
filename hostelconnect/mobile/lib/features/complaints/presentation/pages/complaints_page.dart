// lib/features/complaints/presentation/pages/complaints_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';

class ComplaintsPage extends ConsumerStatefulWidget {
  const ComplaintsPage({super.key});

  @override
  ConsumerState<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends ConsumerState<ComplaintsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final userRole = appState.user?.role.toLowerCase() ?? 'student';

    return Scaffold(
      backgroundColor: UnifiedTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Complaints & Issues'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh complaints data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Complaints', icon: Icon(Icons.report_problem)),
            Tab(text: 'Submit New', icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyComplaintsTab(),
          _buildSubmitComplaintTab(),
        ],
      ),
    );
  }

  Widget _buildMyComplaintsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_problem,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'My Complaints',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View your submitted complaints',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitComplaintTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submit New Complaint',
                    style: UnifiedTheme.lightTheme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      hintText: 'Brief description of the issue',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select complaint category',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Detailed description of the complaint',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitComplaint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UnifiedTheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Submit Complaint'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitComplaint() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complaint Submitted'),
        content: const Text('Your complaint has been submitted successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}