import 'package:flutter/material.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/features/attendance/presentation/widgets/scanner_view.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _isKioskMode = false;

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        appBar: AppBar(
          title: Text(HTeluguTheme.getTeluguEnglishText('attendance_scanner', 'Attendance Scanner')),
          backgroundColor: HTeluguTheme.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isKioskMode ? Icons.phone_android : Icons.desktop_windows),
              onPressed: () {
                setState(() {
                  _isKioskMode = !_isKioskMode;
                });
              },
            ),
          ],
        ),
        body: ScannerView(
          isKioskMode: _isKioskMode,
          onScan: (qrToken) {
            // Handle scan result
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Scanned: $qrToken'),
                backgroundColor: HTokens.success,
              ),
            );
          },
        ),
      );
    });
  }
}
