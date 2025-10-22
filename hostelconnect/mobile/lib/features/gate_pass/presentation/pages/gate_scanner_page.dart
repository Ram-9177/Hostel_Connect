// lib/features/gate_pass/presentation/pages/gate_scanner_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hostelconnect/core/api/gate_pass_api_service.dart';
import 'package:hostelconnect/core/models/gate_pass_models.dart';
import 'package:hostelconnect/shared/theme/app_theme.dart';

class GateScannerPage extends ConsumerStatefulWidget {
  const GateScannerPage({Key? key}) : super(key: key);

  static const String route = '/gate-scanner';

  @override
  ConsumerState<GateScannerPage> createState() => _GateScannerPageState();
}

class _GateScannerPageState extends ConsumerState<GateScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scanResult;
  GateScanResult? lastScanDetails;
  List<GateScanResult> scanHistory = []; // Store last 10 scans
  bool _isScanning = false;

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanResult != scanData.code && !_isScanning) {
        setState(() {
          scanResult = scanData.code;
          _isScanning = true;
        });
        await _processScan(scanData.code!);
      }
    });
  }

  Future<void> _processScan(String token) async {
    // Simulate device ID for now
    const String deviceId = 'warden-device-001';
    try {
      final apiService = ref.read(gatePassApiServiceProvider);
      final result = await apiService.scanGatePassQr(token, deviceId);
      setState(() {
        lastScanDetails = result;
        scanHistory.insert(0, result); // Add to history
        if (scanHistory.length > 10) {
          scanHistory.removeLast(); // Keep only last 10
        }
      });
      _showScanResultDialog(result);
    } catch (e) {
      setState(() {
        lastScanDetails = null;
        _showErrorDialog('Scan Failed', e.toString());
      });
    } finally {
      // Resume camera after a short delay
      Future.delayed(const Duration(seconds: 3), () {
        controller?.resumeCamera();
        setState(() {
          scanResult = null; // Clear current scan result
          _isScanning = false;
        });
      });
    }
  }

  Color _getResultCardColor(GateScanResult? result) {
    if (result == null) return AppTheme.textSecondary;
    if (!result.ok) return AppTheme.error;
    if (result.warnings.isNotEmpty) return AppTheme.warning;
    return AppTheme.success;
  }

  IconData _getResultIcon(GateScanResult? result) {
    if (result == null) return Icons.qr_code_scanner;
    if (!result.ok) return Icons.cancel;
    if (result.warnings.isNotEmpty) return Icons.warning_amber;
    return Icons.check_circle;
  }

  void _showScanResultDialog(GateScanResult result) {
    // Implement sound/haptic feedback here
    // AudioServices.playSystemSound(SystemSoundType.click);
    // HapticFeedback.lightImpact();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _getResultCardColor(result),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(_getResultIcon(result), color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  result.ok ? 'Scan Successful' : 'Scan Failed',
                  style: AppTheme.titleLarge.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildInfoRow('Student', '${result.student.firstName} ${result.student.lastName}'),
                _buildInfoRow('Roll Number', result.student.rollNumber),
                _buildInfoRow('Room', '${result.student.roomId ?? 'N/A'} (Bed ${result.student.bedId ?? 'N/A'})'),
                _buildInfoRow('Direction', result.direction == GatePassDirection.out ? 'OUT' : 'IN'),
                _buildInfoRow('Reason', result.gatePass.reason),
                _buildInfoRow('Time Window', '${_formatTime(result.gatePass.departureTime)} - ${_formatTime(result.gatePass.expectedReturnTime)}'),
                if (result.warnings.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Warnings:',
                    style: AppTheme.bodyMedium.copyWith(color: Colors.yellow, fontWeight: FontWeight.bold),
                  ),
                  ...result.warnings.map((warning) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 2),
                    child: Text('• $warning', style: AppTheme.bodySmall.copyWith(color: Colors.yellow)),
                  )),
                ],
                if (result.message != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Message: ${result.message}',
                    style: AppTheme.bodySmall.copyWith(color: Colors.white70),
                  ),
                ],
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: AppTheme.titleMedium.copyWith(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: AppTheme.bodySmall.copyWith(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Gate Pass Scanner'),
        backgroundColor: AppTheme.warning,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/warden-home'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: AppTheme.warning,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: AppTheme.background,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (lastScanDetails != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getResultCardColor(lastScanDetails),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_getResultIcon(lastScanDetails), color: Colors.white, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                lastScanDetails!.ok ? 'SCAN OK' : 'SCAN FAILED',
                                style: AppTheme.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${lastScanDetails!.student.firstName} ${lastScanDetails!.student.lastName}',
                            style: AppTheme.bodyMedium.copyWith(color: Colors.white),
                          ),
                          Text(
                            '${lastScanDetails!.student.rollNumber} | ${lastScanDetails!.student.roomId ?? 'N/A'}',
                            style: AppTheme.bodySmall.copyWith(color: Colors.white70),
                          ),
                          Text(
                            'Direction: ${lastScanDetails!.direction == GatePassDirection.out ? 'OUT' : 'IN'}',
                            style: AppTheme.bodySmall.copyWith(color: Colors.white70),
                          ),
                          if (lastScanDetails!.warnings.isNotEmpty)
                            Text(
                              'Warnings: ${lastScanDetails!.warnings.join(', ')}',
                              style: AppTheme.bodySmall.copyWith(color: Colors.yellow),
                            ),
                        ],
                      ),
                    )
                  else
                    Text(
                      scanResult != null ? 'Processing Scan...' : 'Point camera at QR Code',
                      style: AppTheme.titleMedium.copyWith(color: AppTheme.textPrimary),
                    ),
                  const SizedBox(height: 12),
                  if (scanHistory.isNotEmpty)
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: scanHistory.length,
                        itemBuilder: (context, index) {
                          final entry = scanHistory[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Chip(
                              backgroundColor: _getResultCardColor(entry).withOpacity(0.7),
                              label: Text(
                                '${entry.student.firstName} ${entry.direction == GatePassDirection.out ? 'OUT' : 'IN'}',
                                style: AppTheme.bodySmall.copyWith(color: Colors.white),
                              ),
                              onDeleted: () {
                                setState(() {
                                  scanHistory.removeAt(index);
                                });
                              },
                              deleteIconColor: Colors.white,
                            ),
                          );
                        },
                      ),
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