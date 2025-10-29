import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/network/api_config.dart';

class GateSecurityScreen extends StatefulWidget {
  const GateSecurityScreen({Key? key}) : super(key: key);

  @override
  State<GateSecurityScreen> createState() => _GateSecurityScreenState();
}

class _GateSecurityScreenState extends State<GateSecurityScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isScanning = false;
  List<Map<String, dynamic>> _recentEvents = [];
  Map<String, dynamic>? _selectedStudent;
  bool _isLoading = false;
  String _errorMessage = '';
  final _manualController = TextEditingController();

  // Use centralized API base URL

  @override
  void initState() {
    super.initState();
    _loadRecentEvents();
  }

  @override
  void dispose() {
    cameraController.dispose();
    _manualController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        _processQRCode(code);
      }
    }
  }

  Future<void> _processQRCode(String qrCode) async {
    setState(() {
      _isScanning = false;
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/gate/scan'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'qrCode': qrCode,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _selectedStudent = data['student'];
          _recentEvents.insert(0, data['event']);
          if (_recentEvents.length > 10) {
            _recentEvents = _recentEvents.take(10).toList();
          }
        });
        
        _showSuccessDialog(data['message']);
      } else {
        final error = jsonDecode(response.body);
        setState(() {
          _errorMessage = error['message'] ?? 'Failed to process QR code';
        });
        _showErrorDialog(_errorMessage);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: $e';
      });
      _showErrorDialog(_errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
        _isScanning = true;
      });
    }
  }

  Future<void> _loadRecentEvents() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/gate/events'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _recentEvents = List<Map<String, dynamic>>.from(data['events'] ?? []);
        });
      }
    } catch (e) {
      print('Error loading recent events: $e');
    }
  }

  Future<void> _manualGateAction(String action) async {
    final id = _manualController.text.trim();
    if (id.isEmpty) {
      _showErrorDialog('Enter Hall Ticket or Student ID');
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/gate/manual'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'studentId': id,
          'action': action,
          'location': 'Main Gate',
          'reason': 'Manual ${action.toLowerCase()}',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _recentEvents.insert(0, data['event']);
          if (_recentEvents.length > 10) {
            _recentEvents = _recentEvents.take(10).toList();
          }
        });
        _showSuccessDialog(data['message'] ?? 'Success');
      } else {
        final error = jsonDecode(response.body);
        _showErrorDialog(error['message'] ?? 'Failed');
      }
    } catch (e) {
      _showErrorDialog('Network error: $e');
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gate Security'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isScanning ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isScanning = !_isScanning;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // QR Scanner
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MobileScanner(
                  controller: cameraController,
                  onDetect: _onDetect,
                ),
              ),
            ),
          ),
          
          // Status and Controls + Manual IN/OUT
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Text(
                    _isScanning ? 'Scanning...' : 'Tap play to start scanning',
                    style: const TextStyle(fontSize: 16),
                  ),
                
                const SizedBox(height: 16),
                
                // Manual controls
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _manualController,
                        decoration: const InputDecoration(
                          labelText: 'Hall Ticket / Student ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : () => _manualGateAction('OUT'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      icon: const Icon(Icons.logout),
                      label: const Text('OUT'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : () => _manualGateAction('IN'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      icon: const Icon(Icons.login),
                      label: const Text('IN'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Student Info
                if (_selectedStudent != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student: ${_selectedStudent!['firstName']} ${_selectedStudent!['lastName']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Room: ${_selectedStudent!['roomId'] ?? 'N/A'}'),
                        Text('Status: ${_selectedStudent!['status'] ?? 'Active'}'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Recent Events
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Events',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recentEvents.length,
                      itemBuilder: (context, index) {
                        final event = _recentEvents[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              event['type'] == 'IN' ? Icons.login : Icons.logout,
                              color: event['type'] == 'IN' ? Colors.green : Colors.red,
                            ),
                            title: Text('${event['studentName']} - ${event['type']}'),
                            subtitle: Text(
                              '${event['timestamp']} - ${event['reason'] ?? 'Gate Pass'}',
                            ),
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