// lib/features/attendance/presentation/widgets/scanner_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/theme/telugu_theme.dart';

class ScannerView extends StatefulWidget {
  final Function(String) onScan;
  final bool isKioskMode;
  final List<ScanResult> pendingScans;

  const ScannerView({
    super.key,
    required this.onScan,
    this.isKioskMode = false,
    this.pendingScans = const [],
  });

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  bool _isScanning = false;
  String? _lastScanResult;

  @override
  void initState() {
    super.initState();
    if (widget.isKioskMode) {
      // Lock orientation for kiosk mode
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  void dispose() {
    if (widget.isKioskMode) {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      if (widget.isKioskMode) {
        return _buildKioskLayout(r);
      } else {
        return _buildMobileLayout(r);
      }
    });
  }

  Widget _buildKioskLayout(HResponsive r) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Scanner area (left side)
          Expanded(
            flex: 3,
            child: _buildScannerArea(r),
          ),
          // Results panel (right side)
          Expanded(
            flex: 2,
            child: _buildResultsPanel(r),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(HResponsive r) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: _buildScannerArea(r)),
          if (widget.pendingScans.isNotEmpty)
            Container(
              height: r.size == HSize.xs ? 200 : 250,
              child: _buildPendingList(r),
            ),
        ],
      ),
    );
  }

  Widget _buildScannerArea(HResponsive r) {
    final scanSize = widget.isKioskMode 
        ? r.width * 0.6.clamp(0.0, 720.0)
        : r.width * 0.8;

    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scanner frame
            Container(
              width: scanSize,
              height: scanSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
              ),
              child: Stack(
                children: [
                  // Camera preview placeholder
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(HTokens.cardRadius),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: scanSize * 0.3,
                            color: Colors.white,
                          ),
                          SizedBox(height: HTokens.md),
                          Text(
                            'Position QR code within frame',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: HFontSize.responsive(r, base: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Corner indicators
                  ..._buildCornerIndicators(scanSize),
                ],
              ),
            ),
            SizedBox(height: HTokens.xl),
            // Scan button
            ElevatedButton.icon(
              onPressed: _isScanning ? null : _simulateScan,
              icon: Icon(_isScanning ? Icons.stop : Icons.qr_code_scanner),
              label: Text(_isScanning ? 'Scanning...' : 'Start Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: HTokens.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: HTokens.xl,
                  vertical: HTokens.md,
                ),
                minimumSize: Size(44, 44), // Accessibility
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsPanel(HResponsive r) {
    return Container(
      color: HTokens.surface,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(HTokens.lg),
            child: Text(
              'Scan Results',
              style: TextStyle(
                fontSize: HFontSize.responsive(r, base: 24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pendingScans.length,
              itemBuilder: (context, index) {
                final scan = widget.pendingScans[index];
                return _buildScanResultCard(r, scan);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingList(HResponsive r) {
    return Container(
      color: HTokens.surface,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(HTokens.md),
            child: Text(
              'Recent Scans',
              style: TextStyle(
                fontSize: HFontSize.responsive(r, base: 18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pendingScans.length,
              itemBuilder: (context, index) {
                final scan = widget.pendingScans[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: scan.success ? Colors.green : Colors.red,
                    child: Icon(
                      scan.success ? Icons.check : Icons.error,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(scan.studentName),
                  subtitle: Text(scan.timestamp),
                  trailing: Text(scan.status),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanResultCard(HResponsive r, ScanResult scan) {
    return Card(
      margin: EdgeInsets.all(HTokens.sm),
      child: Padding(
        padding: EdgeInsets.all(HTokens.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: scan.success ? Colors.green : Colors.red,
                  child: Icon(
                    scan.success ? Icons.check : Icons.error,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: HTokens.sm),
                Expanded(
                  child: Text(
                    scan.studentName,
                    style: TextStyle(
                      fontSize: HFontSize.responsive(r, base: 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: HTokens.sm),
            Text('Status: ${scan.status}'),
            Text('Time: ${scan.timestamp}'),
            if (scan.roomNumber != null)
              Text('Room: ${scan.roomNumber}'),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCornerIndicators(double size) {
    const cornerSize = 20.0;
    const cornerLength = 30.0;
    
    return [
      // Top-left
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: HTokens.primary, width: 3),
              left: BorderSide(color: HTokens.primary, width: 3),
            ),
          ),
        ),
      ),
      // Top-right
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: HTokens.primary, width: 3),
              right: BorderSide(color: HTokens.primary, width: 3),
            ),
          ),
        ),
      ),
      // Bottom-left
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: HTokens.primary, width: 3),
              left: BorderSide(color: HTokens.primary, width: 3),
            ),
          ),
        ),
      ),
      // Bottom-right
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: HTokens.primary, width: 3),
              right: BorderSide(color: HTokens.primary, width: 3),
            ),
          ),
        ),
      ),
    ];
  }

  void _simulateScan() {
    setState(() {
      _isScanning = true;
    });

    // Simulate scan delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isScanning = false;
        _lastScanResult = 'QR_CODE_${DateTime.now().millisecondsSinceEpoch}';
      });
      
      widget.onScan(_lastScanResult!);
      
      // Haptic feedback
      HapticFeedback.lightImpact();
    });
  }
}

class ScanResult {
  final String studentName;
  final String status;
  final String timestamp;
  final bool success;
  final String? roomNumber;

  const ScanResult({
    required this.studentName,
    required this.status,
    required this.timestamp,
    required this.success,
    this.roomNumber,
  });
}
