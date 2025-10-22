// lib/features/issue_reporting/presentation/pages/issue_reporting_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/telugu_theme.dart';
import '../../../../shared/widgets/responsive_page.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/widgets/ui/professional_button.dart';
import '../../../../shared/widgets/ui/card.dart';
import '../../../../shared/widgets/ui/input_field.dart';

class IssueReportingPage extends ConsumerStatefulWidget {
  const IssueReportingPage({super.key});

  @override
  ConsumerState<IssueReportingPage> createState() => _IssueReportingPageState();
}

class _IssueReportingPageState extends ConsumerState<IssueReportingPage> {
  final _formKey = GlobalKey<FormState>();
  final _issueController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCategory = 'Maintenance';
  String _selectedPriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return HPage(
      appBar: AppBar(
        title: Text(HTeluguTheme.getTeluguEnglishText('report_issue', 'Report Issue')),
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
              _buildIssueForm(r),
              SizedBox(height: HTokens.lg),
              _buildIssuesList(r),
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
            HTeluguTheme.getTeluguEnglishText('report_issue', 'Report Issue'),
            style: HTeluguTheme.heading1.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTokens.sm),
          Text(
            HTeluguTheme.getTeluguEnglishText(
              'issue_reporting_description',
              'Report maintenance issues, safety concerns, or other problems.',
            ),
            style: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueForm(HResponsive r) {
    return HCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('new_issue', 'New Issue'),
              style: HTeluguTheme.heading2.copyWith(
                color: HTeluguTheme.primary,
              ),
            ),
            SizedBox(height: HTokens.md),
            
            HInputField(
              controller: _issueController,
              label: HTeluguTheme.getTeluguEnglishText('issue_description', 'Issue Description'),
              hintText: HTeluguTheme.getTeluguEnglishText('describe_issue', 'Describe the issue in detail'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return HTeluguTheme.getTeluguEnglishText('please_describe_issue', 'Please describe the issue');
                }
                return null;
              },
            ),
            
            SizedBox(height: HTokens.md),
            
            HInputField(
              controller: _locationController,
              label: HTeluguTheme.getTeluguEnglishText('location', 'Location'),
              hintText: HTeluguTheme.getTeluguEnglishText('enter_location', 'Enter the location of the issue'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return HTeluguTheme.getTeluguEnglishText('please_enter_location', 'Please enter location');
                }
                return null;
              },
            ),
            
            SizedBox(height: HTokens.lg),
            
            HProfessionalButton(
              text: HTeluguTheme.getTeluguEnglishText('report_issue', 'Report Issue'),
              variant: HProfessionalButtonVariant.primary,
              size: HProfessionalButtonSize.lg,
              onPressed: _reportIssue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssuesList(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTeluguTheme.getTeluguEnglishText('my_reports', 'My Reports'),
            style: HTeluguTheme.heading2.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTokens.md),
          
          // TODO: Load issues from API
          const Center(
            child: Text('No issues reported yet'),
          ),
        ],
      ),
    );
  }

  void _reportIssue() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement issue reporting API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(HTeluguTheme.getTeluguEnglishText(
            'issue_reported_successfully',
            'Issue reported successfully!',
          )),
          backgroundColor: Colors.green,
        ),
      );
      _clearForm();
    }
  }

  void _clearForm() {
    _issueController.clear();
    _locationController.clear();
    _formKey.currentState?.reset();
  }
}
