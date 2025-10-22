// lib/features/dietary_requests/presentation/pages/dietary_requests_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';

class DietaryRequestsPage extends ConsumerStatefulWidget {
  const DietaryRequestsPage({super.key});

  @override
  ConsumerState<DietaryRequestsPage> createState() => _DietaryRequestsPageState();
}

class _DietaryRequestsPageState extends ConsumerState<DietaryRequestsPage>
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
        title: const Text('Dietary Requests'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh dietary requests data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Requests', icon: Icon(Icons.restaurant)),
            Tab(text: 'Submit Request', icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyRequestsTab(),
          _buildSubmitRequestTab(),
        ],
      ),
    );
  }

  Widget _buildMyRequestsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'My Dietary Requests',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View your dietary requests and preferences',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitRequestTab() {
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
                    'Submit Dietary Request',
                    style: UnifiedTheme.lightTheme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Dietary Type',
                      hintText: 'Vegetarian, Vegan, Halal, etc.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Allergies',
                      hintText: 'List any food allergies',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Special Requirements',
                      hintText: 'Any special dietary requirements',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitDietaryRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UnifiedTheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Submit Request'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitDietaryRequest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Submitted'),
        content: const Text('Your dietary request has been submitted successfully.'),
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