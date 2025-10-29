// lib/features/help/presentation/pages/help_center_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpCenterPage extends ConsumerStatefulWidget {
  const HelpCenterPage({super.key});

  @override
  ConsumerState<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends ConsumerState<HelpCenterPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  final List<FAQItem> _faqs = [
    FAQItem(
      category: 'Gate Pass',
      question: 'How do I request a gate pass?',
      answer: 'Go to Gate Pass section, tap "Request Gate Pass", fill in the details (reason, date, time), and submit. Your warden will approve or reject the request.',
    ),
    FAQItem(
      category: 'Gate Pass',
      question: 'How long does approval take?',
      answer: 'Gate pass approvals typically take 15-30 minutes during working hours. For urgent requests, contact your warden directly.',
    ),
    FAQItem(
      category: 'Gate Pass',
      question: 'Can I edit a submitted gate pass?',
      answer: 'You can only edit or cancel a gate pass if it is still in "Pending" status. Once approved or rejected, changes are not allowed.',
    ),
    FAQItem(
      category: 'Attendance',
      question: 'How do I mark my attendance?',
      answer: 'Scan the QR code displayed at your hostel entrance using the attendance scanner in the app. Attendance is marked automatically.',
    ),
    FAQItem(
      category: 'Attendance',
      question: 'What if I miss attendance?',
      answer: 'If you miss attendance, contact your warden immediately with a valid reason. They can mark manual attendance.',
    ),
    FAQItem(
      category: 'Meals',
      question: 'How do I update meal preferences?',
      answer: 'Go to Meals section, select tomorrow\'s date, and toggle your meal preferences (Breakfast, Lunch, Dinner). Changes lock at 11 PM.',
    ),
    FAQItem(
      category: 'Meals',
      question: 'Can I change after 11 PM?',
      answer: 'No, meal selection locks at 11 PM to allow the kitchen to prepare accurate quantities. Plan ahead!',
    ),
    FAQItem(
      category: 'Complaints',
      question: 'How do I file a complaint?',
      answer: 'Go to Complaints section, tap "+ New Complaint", select category (Maintenance/Food/Security/Other), describe the issue, attach photo if needed, and submit.',
    ),
    FAQItem(
      category: 'Complaints',
      question: 'How do I track my complaint?',
      answer: 'All complaints are visible in the Complaints section with real-time status: Pending, In Progress, or Resolved.',
    ),
    FAQItem(
      category: 'Account',
      question: 'How do I reset my password?',
      answer: 'Go to Settings > Account Management > Change Password. Enter current password, new password, and confirm.',
    ),
    FAQItem(
      category: 'Account',
      question: 'How do I view my digital ID card?',
      answer: 'Go to Settings > Account Management > Digital ID Card. You can view, download, or share your student ID.',
    ),
    FAQItem(
      category: 'Technical',
      question: 'App is not working properly',
      answer: 'Try these steps: 1) Force close and reopen app, 2) Clear cache in Settings > Data & Storage, 3) Update to latest version, 4) Contact support.',
    ),
    FAQItem(
      category: 'Technical',
      question: 'QR scanner not working',
      answer: 'Grant camera permissions: Settings > Apps > HostelConnect > Permissions > Camera. If issue persists, restart the app.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFAQs = _searchQuery.isEmpty
        ? _faqs
        : _faqs.where((faq) =>
            faq.question.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faq.answer.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faq.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'FAQs'),
            Tab(text: 'Contact Support'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQsTab(filteredFAQs),
          _buildContactSupportTab(),
        ],
      ),
    );
  }

  Widget _buildFAQsTab(List<FAQItem> faqs) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search FAQs...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF3B82F6)),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),

        // FAQs List
        Expanded(
          child: faqs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];
                    return _buildFAQCard(faq);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFAQCard(FAQItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getCategoryColor(faq.category).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(faq.category),
              color: _getCategoryColor(faq.category),
              size: 20,
            ),
          ),
          title: Text(
            faq.question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF1F2937),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              faq.category,
              style: TextStyle(
                fontSize: 12,
                color: _getCategoryColor(faq.category),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          children: [
            Text(
              faq.answer,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSupportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Methods
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),

          _buildContactCard(
            icon: Icons.phone,
            title: 'Call Us',
            subtitle: '+91 1234567890',
            color: const Color(0xFF10B981),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening phone dialer...')),
              );
            },
          ),

          _buildContactCard(
            icon: Icons.email,
            title: 'Email Support',
            subtitle: 'support@hostelconnect.com',
            color: const Color(0xFF3B82F6),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening email client...')),
              );
            },
          ),

          _buildContactCard(
            icon: Icons.chat_bubble,
            title: 'Live Chat',
            subtitle: 'Available 9 AM - 6 PM',
            color: const Color(0xFF8B5CF6),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Live chat coming soon!')),
              );
            },
          ),

          const SizedBox(height: 24),

          // Quick Links
          const Text(
            'Quick Links',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),

          _buildQuickLinkCard(
            'User Guide',
            'Step-by-step instructions',
            Icons.book_outlined,
            () {},
          ),
          _buildQuickLinkCard(
            'Video Tutorials',
            'Watch how-to videos',
            Icons.play_circle_outline,
            () {},
          ),
          _buildQuickLinkCard(
            'Report a Bug',
            'Help us improve the app',
            Icons.bug_report_outlined,
            () {},
          ),
          _buildQuickLinkCard(
            'Feature Request',
            'Suggest new features',
            Icons.lightbulb_outline,
            () {},
          ),

          const SizedBox(height: 24),

          // Office Hours
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Office Hours',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                _buildOfficeHour('Monday - Friday', '9:00 AM - 6:00 PM'),
                _buildOfficeHour('Saturday', '10:00 AM - 4:00 PM'),
                _buildOfficeHour('Sunday', 'Closed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildQuickLinkCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF3B82F6)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, size: 20),
      ),
    );
  }

  Widget _buildOfficeHour(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            hours,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Gate Pass':
        return const Color(0xFFF59E0B);
      case 'Attendance':
        return const Color(0xFF10B981);
      case 'Meals':
        return const Color(0xFF8B5CF6);
      case 'Complaints':
        return const Color(0xFFEF4444);
      case 'Account':
        return const Color(0xFF3B82F6);
      case 'Technical':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Gate Pass':
        return Icons.exit_to_app;
      case 'Attendance':
        return Icons.check_circle_outline;
      case 'Meals':
        return Icons.restaurant;
      case 'Complaints':
        return Icons.report_problem_outlined;
      case 'Account':
        return Icons.person_outline;
      case 'Technical':
        return Icons.settings;
      default:
        return Icons.help_outline;
    }
  }
}

class FAQItem {
  final String category;
  final String question;
  final String answer;

  FAQItem({
    required this.category,
    required this.question,
    required this.answer,
  });
}
