// lib/features/attendance/presentation/widgets/qr_scanner_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../core/models/attendance_models.dart';
import '../../../../core/services/attendance_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class QRScannerWidget extends ConsumerStatefulWidget {
  final String sessionId;
  final AttendanceSession session;
  final VoidCallback? onScanSuccess;
  final VoidCallback? onScanError;

  const QRScannerWidget({
    super.key,
    required this.sessionId,
    required this.session,
    this.onScanSuccess,
    this.onScanError,
  });

  @override
  ConsumerState<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends ConsumerState<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _isScanning = false;
  bool _isProcessing = false;
  String? _lastScannedCode;
  DateTime? _lastScanTime;

  @override
  void initState() {
    super.initState();
    _isScanning = true;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'QR Scanner - ${widget.session.title}',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isScanning ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: _toggleScanning,
          ),
        ],
      ),
      body: Column(
        children: [
          // Scanner View
          Expanded(
            flex: 3,
            child: _buildScannerView(),
          ),
          
          // Instructions and Status
          Expanded(
            flex: 1,
            child: _buildInstructionsPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerView() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _isScanning ? IOSGradeTheme.success : IOSGradeTheme.error,
          width: 2,
        ),
      ),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: _isScanning ? IOSGradeTheme.success : IOSGradeTheme.error,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }

  Widget _buildInstructionsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          if (_isProcessing)
            const CircularProgressIndicator(color: IOSGradeTheme.success)
          else
            Icon(
              _isScanning ? Icons.qr_code_scanner : Icons.pause_circle,
              color: _isScanning ? IOSGradeTheme.success : IOSGradeTheme.error,
              size: 32,
            ),
          
          const SizedBox(height: 8),
          
          Text(
            _isScanning ? 'Scanning for QR codes...' : 'Scanner paused',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 4),
          
          Text(
            'Position the QR code within the frame',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          
          if (_lastScannedCode != null) ...[
            const SizedBox(height: 8),
            Text(
              'Last scanned: ${_lastScannedCode!.substring(0, 8)}...',
              style: const TextStyle(
                color: IOSGradeTheme.success,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (_isScanning && !_isProcessing) {
        _processQRCode(scanData.code);
      }
    });
  }

  Future<void> _processQRCode(String? qrCode) async {
    if (qrCode == null || qrCode.isEmpty) return;
    
    // Prevent duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_lastScanTime != null && now.difference(_lastScanTime!).inSeconds < 2) {
      return;
    }
    
    setState(() {
      _isProcessing = true;
      _lastScannedCode = qrCode;
      _lastScanTime = now;
    });

    try {
      // Validate QR code format
      if (!_isValidQRCode(qrCode)) {
        Toast.showError(context, 'Invalid QR code format');
        widget.onScanError?.call();
        return;
      }

      // Check for duplicates
      final attendanceService = ref.read(attendanceServiceProvider);
      final duplicateCheck = await attendanceService.checkDuplicateEntry(widget.sessionId, _extractStudentId(qrCode));
      
      if (duplicateCheck.state == LoadState.success && duplicateCheck.data == true) {
        Toast.showWarning(context, 'Student already marked present');
        widget.onScanError?.call();
        return;
      }

      // Process the scan
      final scanRequest = QRScanRequest(
        sessionId: widget.sessionId,
        qrCode: qrCode,
        scannedBy: 'warden', // TODO: Get from auth context
        timestamp: DateTime.now(),
      );

      final result = await attendanceService.scanQRCode(scanRequest);
      
      if (result.state == LoadState.success && result.data != null) {
        Toast.showSuccess(context, 'Attendance marked successfully');
        widget.onScanSuccess?.call();
        
        // Haptic feedback
        // HapticFeedback.mediumImpact();
      } else {
        Toast.showError(context, result.error ?? 'Failed to process QR code');
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

  bool _isValidQRCode(String qrCode) {
    // Basic validation - QR code should contain student ID and session ID
    try {
      final parts = qrCode.split('|');
      return parts.length >= 3 && parts[0].isNotEmpty && parts[1].isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  String _extractStudentId(String qrCode) {
    try {
      final parts = qrCode.split('|');
      return parts[0];
    } catch (e) {
      return '';
    }
  }

  void _toggleScanning() {
    setState(() {
      _isScanning = !_isScanning;
    });
    
    if (_isScanning) {
      controller?.resumeCamera();
    } else {
      controller?.pauseCamera();
    }
  }

  Future<void> _toggleFlash() async {
    await controller?.toggleFlash();
  }

  Future<void> _flipCamera() async {
    await controller?.flipCamera();
  }
}

/// QR Code Generator Widget
class QRCodeGeneratorWidget extends ConsumerWidget {
  final String sessionId;
  final String studentId;
  final String studentName;
  final VoidCallback? onGenerated;

  const QRCodeGeneratorWidget({
    super.key,
    required this.sessionId,
    required this.studentId,
    required this.studentName,
    this.onGenerated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<LoadStateData<AttendanceQRCode>>(
      future: ref.read(attendanceServiceProvider).generateQRCode(sessionId, studentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data?.state == LoadState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: IOSGradeTheme.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to generate QR code',
                  style: IOSGradeTheme.bodyLarge.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Retry generation
                    ref.invalidate(attendanceServiceProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final qrCode = snapshot.data?.data;
        if (qrCode == null) {
          return const Center(child: Text('No QR code data'));
        }

        return IOSGradeCard(
          child: Column(
            children: [
              Text(
                studentName,
                style: IOSGradeTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // QR Code Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: IOSGradeTheme.border),
                ),
                child: Column(
                  children: [
                    // QR Code would be displayed here using qr_flutter package
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'QR Code\nPlaceholder',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'Session: ${qrCode.sessionId}',
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                    
                    Text(
                      'Expires: ${_formatDateTime(qrCode.expiresAt)}',
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement share functionality
                      Toast.showInfo(context, 'Share functionality not implemented');
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                  
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement download functionality
                      Toast.showInfo(context, 'Download functionality not implemented');
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// QR Code List Widget
class QRCodeListWidget extends ConsumerWidget {
  final String sessionId;
  final List<String> studentIds;

  const QRCodeListWidget({
    super.key,
    required this.sessionId,
    required this.studentIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<LoadStateData<List<AttendanceQRCode>>>(
      future: ref.read(attendanceServiceProvider).generateBulkQRCodes(sessionId, studentIds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data?.state == LoadState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: IOSGradeTheme.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to generate QR codes',
                  style: IOSGradeTheme.bodyLarge.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
              ],
            ),
          );
        }

        final qrCodes = snapshot.data?.data ?? [];
        
        return ListView.builder(
          itemCount: qrCodes.length,
          itemBuilder: (context, index) {
            final qrCode = qrCodes[index];
            return QRCodeGeneratorWidget(
              sessionId: sessionId,
              studentId: qrCode.studentId,
              studentName: 'Student ${qrCode.studentId}', // TODO: Get actual name
            );
          },
        );
      },
    );
  }
}
