// lib/features/gate_pass/presentation/pages/gate_pass_request_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hostelconnect/core/api/gate_pass_api_service.dart';
import 'package:hostelconnect/core/models/gate_pass_models.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/shared/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GatePassRequestPage extends ConsumerStatefulWidget {
  const GatePassRequestPage({Key? key}) : super(key: key);

  static const String route = '/student-home/gate-pass-request';
  static const String name = 'gatePassRequest';

  @override
  ConsumerState<GatePassRequestPage> createState() => _GatePassRequestPageState();
}

class _GatePassRequestPageState extends ConsumerState<GatePassRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  DateTime? _departureDate;
  TimeOfDay? _departureTime;
  DateTime? _expectedReturnDate;
  TimeOfDay? _expectedReturnTime;
  String? _qrToken;
  int _qrTtlSeconds = 0;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _expectedReturnDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureTime = picked;
        } else {
          _expectedReturnTime = picked;
        }
      });
    }
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_departureDate == null || _departureTime == null || _expectedReturnDate == null || _expectedReturnTime == null) {
      setState(() {
        _errorMessage = 'Please select both date and time for departure and return.';
      });
      return;
    }

    final studentId = ref.read(appStateNotifierProvider).currentUser?.id;
    if (studentId == null) {
      setState(() {
        _errorMessage = 'Student ID not found. Please log in again.';
      });
      return;
    }

    final departureDateTime = DateTime(
      _departureDate!.year,
      _departureDate!.month,
      _departureDate!.day,
      _departureTime!.hour,
      _departureTime!.minute,
    );
    final expectedReturnDateTime = DateTime(
      _expectedReturnDate!.year,
      _expectedReturnDate!.month,
      _expectedReturnDate!.day,
      _expectedReturnTime!.hour,
      _expectedReturnTime!.minute,
    );

    if (expectedReturnDateTime.isBefore(departureDateTime)) {
      setState(() {
        _errorMessage = 'Return time cannot be before departure time.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _qrToken = null; // Clear previous QR
      _isLoading = true;
    });

    final request = GatePassRequest(
      studentId: studentId,
      reason: _reasonController.text,
      departureTime: departureDateTime,
      expectedReturnTime: expectedReturnDateTime,
    );

    try {
      final apiService = ref.read(gatePassApiServiceProvider);
      final gatePass = await apiService.requestGatePass(request);

      // Generate QR for the approved pass
      final qrData = await apiService.generateGatePassQr(gatePass.id);
      setState(() {
        _qrToken = qrData['token'];
        _qrTtlSeconds = qrData['ttlSeconds'] ?? 30;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gate Pass Requested and QR Generated!'),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Request Gate Pass'),
        backgroundColor: AppTheme.warning,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/student-home'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.warning.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.exit_to_app, color: AppTheme.warning, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          'Gate Pass Request',
                          style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill out the details for your gate pass request. Your request will be reviewed by the warden.',
                      style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Reason Field
              Text(
                'Reason for leaving',
                style: AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  hintText: 'Enter the reason for leaving hostel premises',
                  prefixIcon: const Icon(Icons.edit_note),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Reason cannot be empty';
                  }
                  if (value.length < 10) {
                    return 'Please provide a detailed reason (at least 10 characters)';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              
              const SizedBox(height: 24),
              
              // Departure Date & Time
              Text(
                'Departure Details',
                style: AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: AppTheme.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                                  ),
                                  Text(
                                    _departureDate != null 
                                        ? DateFormat('MMM dd, yyyy').format(_departureDate!)
                                        : 'Select date',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: _departureDate != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context, true),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: AppTheme.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                                  ),
                                  Text(
                                    _departureTime != null 
                                        ? _departureTime!.format(context)
                                        : 'Select time',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: _departureTime != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Expected Return Date & Time
              Text(
                'Expected Return Details',
                style: AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: AppTheme.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                                  ),
                                  Text(
                                    _expectedReturnDate != null 
                                        ? DateFormat('MMM dd, yyyy').format(_expectedReturnDate!)
                                        : 'Select date',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: _expectedReturnDate != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context, false),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: AppTheme.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                                  ),
                                  Text(
                                    _expectedReturnTime != null 
                                        ? _expectedReturnTime!.format(context)
                                        : 'Select time',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: _expectedReturnTime != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Error Message
              if (_errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppTheme.error, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.error),
                        ),
                      ),
                    ],
                  ),
                ),
              
              if (_errorMessage != null) const SizedBox(height: 16),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.warning,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Request Gate Pass',
                          style: AppTheme.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // QR Code Display
              if (_qrToken != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.qr_code, color: AppTheme.success, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Your Gate Pass QR Code',
                            style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Valid for $_qrTtlSeconds seconds',
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: QrImageView(
                          data: _qrToken!,
                          version: QrVersions.auto,
                          size: 200.0,
                          gapless: false,
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(40, 40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Show this QR code to the warden at the gate.',
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}