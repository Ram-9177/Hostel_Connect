// lib/features/gatepass/presentation/widgets/qr_unlock_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/gatepass_models.dart';
import '../../../../core/providers/gatepass_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'interstitial_ad_widget.dart';

class QRUnlockWidget extends ConsumerStatefulWidget {
  final String gatePassId;
  final VoidCallback? onQRGenerated;
  final VoidCallback? onQRScanned;

  const QRUnlockWidget({
    super.key,
    required this.gatePassId,
    this.onQRGenerated,
    this.onQRScanned,
  });

  @override
  ConsumerState<QRUnlockWidget> createState() => _QRUnlockWidgetState();
}

class _QRUnlockWidgetState extends ConsumerState<QRUnlockWidget>
    with TickerProviderStateMixin {
  late AnimationController _unlockController;
  late AnimationController _qrController;
  late Animation<double> _unlockAnimation;
  late Animation<double> _qrAnimation;
  
  bool _isGeneratingQR = false;
  bool _isQRVisible = false;
  String? _qrCode;
  DateTime? _qrExpiresAt;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _unlockController.dispose();
    _qrController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _unlockController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _qrController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _unlockAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _unlockController,
      curve: Curves.elasticOut,
    ));
    
    _qrAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _qrController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _generateQRCode() async {
    setState(() {
      _isGeneratingQR = true;
    });

    try {
      final request = QRGenerationRequest(
        gatePassId: widget.gatePassId,
        studentId: 'student_1', // TODO: Get from auth context
        requireAdCompletion: true,
      );

      final gatepassService = ref.read(gatepassServiceProvider);
      final result = await gatepassService.generateQRCode(request);

      if (result.state == LoadState.success && result.data != null) {
        final gatePass = result.data!;
        
        setState(() {
          _qrCode = gatePass.qrCode;
          _qrExpiresAt = gatePass.qrExpiresAt;
          _isQRVisible = true;
          _isGeneratingQR = false;
        });

        // Start animations
        _unlockController.forward();
        await Future.delayed(const Duration(milliseconds: 300));
        _qrController.forward();

        Toast.showSuccess(context, 'QR code generated successfully!');
        widget.onQRGenerated?.call();
      } else {
        setState(() {
          _isGeneratingQR = false;
        });
        Toast.showError(context, result.error ?? 'Failed to generate QR code');
      }
    } catch (e) {
      setState(() {
        _isGeneratingQR = false;
      });
      Toast.showError(context, 'Error generating QR code: $e');
    }
  }

  Future<void> _showAdFirst() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => InterstitialAdWidget(
          gatePassId: widget.gatePassId,
          onAdCompleted: () {
            Navigator.pop(context, true);
          },
          onEmergencyBypass: () {
            Navigator.pop(context, true);
          },
        ),
      ),
    );

    if (result == true) {
      // Ad completed or emergency bypass used, now generate QR
      await _generateQRCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('QR Code Unlock'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: IOSGradeTheme.primary,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Gate Pass QR Code',
                      style: IOSGradeTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Generate your QR code to access the gate',
                      style: IOSGradeTheme.bodyLarge.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Ad Requirement Card
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: IOSGradeTheme.info,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Advertisement Required',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'To generate your QR code, you must watch a 20-second advertisement. This helps support the hostel management system.',
                      style: IOSGradeTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: IOSGradeTheme.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: IOSGradeTheme.warning.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: IOSGradeTheme.warning,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Advertisement duration: 20 seconds',
                            style: IOSGradeTheme.bodySmall.copyWith(
                              color: IOSGradeTheme.warning,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // QR Code Display Area
            if (_isQRVisible) ...[
              AnimatedBuilder(
                animation: _qrAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _qrAnimation.value,
                    child: Opacity(
                      opacity: _qrAnimation.value,
                      child: IOSGradeCard(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text(
                                'Your QR Code',
                                style: IOSGradeTheme.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              // QR Code Placeholder
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: IOSGradeTheme.border,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_2,
                                      size: 80,
                                      color: IOSGradeTheme.primary,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _qrCode?.substring(0, 8) ?? '',
                                      style: IOSGradeTheme.bodySmall.copyWith(
                                        color: IOSGradeTheme.textSecondary,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // QR Code Info
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: IOSGradeTheme.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: IOSGradeTheme.success.withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: IOSGradeTheme.success,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'QR Code Generated Successfully',
                                          style: IOSGradeTheme.bodyMedium.copyWith(
                                            color: IOSGradeTheme.success,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_qrExpiresAt != null) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Expires: ${_formatDateTime(_qrExpiresAt!)}',
                                        style: IOSGradeTheme.bodySmall.copyWith(
                                          color: IOSGradeTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement share functionality
                        Toast.showInfo(context, 'Share functionality not implemented');
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IOSGradeTheme.secondary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement download functionality
                        Toast.showInfo(context, 'Download functionality not implemented');
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IOSGradeTheme.info,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Generate QR Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isGeneratingQR ? null : _showAdFirst,
                  icon: _isGeneratingQR 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.play_circle_filled),
                  label: Text(
                    _isGeneratingQR 
                        ? 'Generating QR Code...'
                        : 'Watch Ad & Generate QR Code',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IOSGradeTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Instructions
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Use Your QR Code',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInstructionStep(
                      '1',
                      'Show your QR code to the gate security',
                      Icons.qr_code_scanner,
                    ),
                    _buildInstructionStep(
                      '2',
                      'Security will scan your QR code',
                      Icons.security,
                    ),
                    _buildInstructionStep(
                      '3',
                      'Gate will unlock for departure/return',
                      Icons.lock_open,
                    ),
                    _buildInstructionStep(
                      '4',
                      'Your gate pass will be automatically updated',
                      Icons.update,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            icon,
            color: IOSGradeTheme.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: IOSGradeTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// QR Code Scanner Widget for Gate Security
class GateQRScannerWidget extends ConsumerStatefulWidget {
  final String gateLocation;
  final VoidCallback? onScanSuccess;
  final VoidCallback? onScanError;

  const GateQRScannerWidget({
    super.key,
    required this.gateLocation,
    this.onScanSuccess,
    this.onScanError,
  });

  @override
  ConsumerState<GateQRScannerWidget> createState() => _GateQRScannerWidgetState();
}

class _GateQRScannerWidgetState extends ConsumerState<GateQRScannerWidget> {
  final TextEditingController _manualEntryController = TextEditingController();
  bool _isScanning = false;
  bool _isProcessing = false;
  String? _lastScannedCode;

  @override
  void dispose() {
    _manualEntryController.dispose();
    super.dispose();
  }

  Future<void> _processQRCode(String qrCode) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
      _lastScannedCode = qrCode;
    });

    try {
      // Validate QR code
      final gatepassService = ref.read(gatepassServiceProvider);
      final validationResult = await gatepassService.validateQRCode(qrCode);

      if (validationResult.state == LoadState.success && validationResult.data == true) {
        // Get gate pass details
        final gatePassResult = await gatepassService.getGatePassByQR(qrCode);
        
        if (gatePassResult.state == LoadState.success && gatePassResult.data != null) {
          final gatePass = gatePassResult.data!;
          
          // Record gate scan event
          final scanEvent = GateScanEvent(
            id: 'scan_${DateTime.now().millisecondsSinceEpoch}',
            gatePassId: gatePass.id,
            studentId: gatePass.studentId,
            studentName: gatePass.studentName,
            scanType: _determineScanType(gatePass),
            scanTime: DateTime.now(),
            scannedBy: 'security', // TODO: Get from auth context
            scannedByName: 'Security Guard', // TODO: Get from auth context
            gateLocation: widget.gateLocation,
            qrCode: qrCode,
            qrNonce: gatePass.qrNonce,
            isEmergencyBypass: gatePass.adCompleted != true,
            emergencyReason: gatePass.adCompleted != true ? 'Ad bypass used' : null,
          );

          final scanResult = await gatepassService.recordGateScan(scanEvent);
          
          if (scanResult.state == LoadState.success) {
            Toast.showSuccess(context, 'Gate scan recorded successfully');
            widget.onScanSuccess?.call();
          } else {
            Toast.showError(context, scanResult.error ?? 'Failed to record scan');
            widget.onScanError?.call();
          }
        } else {
          Toast.showError(context, 'Invalid QR code');
          widget.onScanError?.call();
        }
      } else {
        Toast.showError(context, 'Invalid QR code');
        widget.onScanError?.call();
      }
    } catch (e) {
      Toast.showError(context, 'Error processing QR code: $e');
      widget.onScanError?.call();
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  GateScanType _determineScanType(GatePass gatePass) {
    // Logic to determine if this is departure or return
    // For now, we'll use a simple heuristic
    if (gatePass.actualDepartureTime == null) {
      return GateScanType.departure;
    } else {
      return GateScanType.return_;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gate Scanner - ${widget.gateLocation}'),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Scanner Area
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isScanning ? IOSGradeTheme.success : IOSGradeTheme.error,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      color: _isScanning ? IOSGradeTheme.success : IOSGradeTheme.error,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isScanning ? 'Scanning...' : 'Scanner Ready',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Position QR code within the frame',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Manual Entry
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Manual Entry',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _manualEntryController,
                    decoration: const InputDecoration(
                      hintText: 'Enter QR code manually',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _processQRCode(value.trim());
                        _manualEntryController.clear();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _isProcessing ? null : () {
                      final qrCode = _manualEntryController.text.trim();
                      if (qrCode.isNotEmpty) {
                        _processQRCode(qrCode);
                        _manualEntryController.clear();
                      }
                    },
                    child: Text(_isProcessing ? 'Processing...' : 'Process QR Code'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
