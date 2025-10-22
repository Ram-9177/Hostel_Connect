// lib/features/reports/presentation/pages/reports_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/telugu_theme.dart';
import '../../../../shared/widgets/responsive_page.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/widgets/ui/professional_button.dart';
import '../../../../shared/widgets/ui/card.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return HPage(
      appBar: AppBar(
        title: Text(HTeluguTheme.getTeluguEnglishText('reports', 'Reports')),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: HResponsive.builder(builder: (ctx, r) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(r),
              SizedBox(height: HTokens.lg),
              _buildReportsGrid(r),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTeluguTheme.getTeluguEnglishText('reports_analytics', 'Reports & Analytics'),
            style: HTeluguTheme.heading1.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTokens.sm),
          Text(
            HTeluguTheme.getTeluguEnglishText(
              'reports_description',
              'View detailed reports and analytics for hostel management.',
            ),
            style: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsGrid(HResponsive r) {
    final reports = [
      {
        'title': HTeluguTheme.getTeluguEnglishText('attendance_report', 'Attendance Report'),
        'description': HTeluguTheme.getTeluguEnglishText('attendance_report_desc', 'View student attendance statistics'),
        'icon': Icons.people,
        'color': Colors.blue,
      },
      {
        'title': HTeluguTheme.getTeluguEnglishText('room_occupancy', 'Room Occupancy'),
        'description': HTeluguTheme.getTeluguEnglishText('room_occupancy_desc', 'Track room utilization rates'),
        'icon': Icons.bed,
        'color': Colors.green,
      },
      {
        'title': HTeluguTheme.getTeluguEnglishText('meal_reports', 'Meal Reports'),
        'description': HTeluguTheme.getTeluguEnglishText('meal_reports_desc', 'Analyze meal consumption patterns'),
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'title': HTeluguTheme.getTeluguEnglishText('gate_pass_reports', 'Gate Pass Reports'),
        'description': HTeluguTheme.getTeluguEnglishText('gate_pass_reports_desc', 'Monitor student movements'),
        'icon': Icons.exit_to_app,
        'color': Colors.purple,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: HTokens.md,
        mainAxisSpacing: HTokens.md,
      ),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return GestureDetector(
          onTap: () => _openReport(report['title'] as String),
          child: HCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  report['icon'] as IconData,
                  size: 48,
                  color: report['color'] as Color,
                ),
                SizedBox(height: HTokens.sm),
                Text(
                  report['title'] as String,
                  style: HTeluguTheme.heading3.copyWith(
                    color: HTeluguTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  report['description'] as String,
                  style: HTeluguTheme.caption.copyWith(
                    color: HTeluguTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openReport(String reportTitle) {
    // TODO: Implement report viewing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(HTeluguTheme.getTeluguEnglishText(
          'report_coming_soon',
          'Report feature coming soon!',
        )),
        backgroundColor: HTeluguTheme.primary,
      ),
    );
  }
}
