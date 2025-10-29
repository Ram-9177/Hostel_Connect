import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_config.dart';
import 'dart:convert';
import '../../../../core/config/environment.dart';
import '../../../../core/services/offline_storage_service.dart';
import '../../../../core/services/sync_service.dart';

class EmergencyRequestScreen extends StatefulWidget {
  const EmergencyRequestScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyRequestScreen> createState() => _EmergencyRequestScreenState();
}

class _EmergencyRequestScreenState extends State<EmergencyRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedRequestType = 'HEALTH';
  String _selectedPriority = 'MEDIUM';
  bool _isLoading = false;
  bool _isOnline = true;
  int _offlineDataCount = 0;

  final List<Map<String, dynamic>> _requestTypes = [
    {'value': 'HEALTH', 'label': 'Health Emergency', 'icon': '🏥'},
    {'value': 'FAMILY', 'label': 'Family Emergency', 'icon': '👨‍👩‍👧‍👦'},
    {'value': 'ACADEMIC', 'label': 'Academic Emergency', 'icon': '📚'},
    {'value': 'FOOD', 'label': 'Food Request', 'icon': '🍽️'},
    {'value': 'OTHER', 'label': 'Other Emergency', 'icon': '📋'},
  ];

  final List<Map<String, dynamic>> _priorities = [
    {'value': 'LOW', 'label': 'Low Priority', 'color': Colors.green},
    {'value': 'MEDIUM', 'label': 'Medium Priority', 'color': Colors.orange},
    {'value': 'HIGH', 'label': 'High Priority', 'color': Colors.red},
    {'value': 'URGENT', 'label': 'Urgent', 'color': Colors.red[800]!},
  ];

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _loadOfflineDataCount();
  }

  Future<void> _checkConnectivity() async {
    _isOnline = await OfflineStorageService.isOnline();
    setState(() {});
  }

  Future<void> _loadOfflineDataCount() async {
    final dataCount = await OfflineStorageService.getOfflineDataCount();
    _offlineDataCount = dataCount['syncQueue'] ?? 0;
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitEmergencyRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = {
        'studentId': 'STU001', // This should come from user session
        'studentName': 'John Student', // This should come from user session
        'roomNumber': 'A-101', // This should come from user session
        'hostelName': 'Boys Hostel A', // This should come from user session
        'requestType': _selectedRequestType,
        'priority': _selectedPriority,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'contactNumber': _contactController.text,
        'emergencyContact': _emergencyContactController.text,
        'location': _locationController.text.isNotEmpty ? _locationController.text : null,
        'status': 'PENDING',
        'requestedAt': DateTime.now().toIso8601String(),
      };

      // Check connectivity
      _isOnline = await OfflineStorageService.isOnline();

      if (_isOnline) {
        // Try online submission first
        try {
          final response = await http.post(
            Uri.parse('${ApiConfig.baseUrl}/emergency-requests'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request),
          );

          if (response.statusCode == 201) {
            _showSuccessDialog('Emergency request submitted successfully!');
            _clearForm();
            await _loadOfflineDataCount();
            return;
          } else {
            throw Exception('Server error: ${response.statusCode}');
          }
        } catch (e) {
          // If online submission fails, store offline
          await OfflineStorageService.storeEmergencyRequestOffline(request);
          _showOfflineSuccessDialog();
          _clearForm();
          await _loadOfflineDataCount();
        }
      } else {
        // Store offline
        await OfflineStorageService.storeEmergencyRequestOffline(request);
        _showOfflineSuccessDialog();
        _clearForm();
        await _loadOfflineDataCount();
      }
    } catch (e) {
      _showErrorDialog('Error submitting emergency request: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Request Submitted'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showOfflineSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.cloud_off, color: Colors.orange),
            SizedBox(width: 8),
            Text('Saved Offline'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your emergency request has been saved offline and will be submitted automatically when internet connection is available.'),
            SizedBox(height: 10),
            Text('Offline requests: $_offlineDataCount'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _manualSync() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await SyncService.manualSync();
      
      if (result['isOnline'] == true) {
        if (result['totalSynced'] > 0) {
          _showSuccessDialog('Synced ${result['totalSynced']} items successfully!');
        } else if (result['totalFailed'] > 0) {
          _showErrorDialog('Failed to sync ${result['totalFailed']} items. Will retry later.');
        } else {
          _showSuccessDialog('No offline data to sync.');
        }
      } else {
        _showErrorDialog('No internet connection available for sync.');
      }
      
      await _loadOfflineDataCount();
      await _checkConnectivity();
    } catch (e) {
      _showErrorDialog('Sync failed: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _contactController.clear();
    _emergencyContactController.clear();
    _locationController.clear();
    _selectedRequestType = 'HEALTH';
    _selectedPriority = 'MEDIUM';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Request'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          // Offline indicator
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isOnline ? Icons.wifi : Icons.wifi_off,
                  color: _isOnline ? Colors.green : Colors.red,
                  size: 20,
                ),
                if (_offlineDataCount > 0) ...[
                  SizedBox(width: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$_offlineDataCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Sync button
          if (_offlineDataCount > 0)
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: _manualSync,
              tooltip: 'Sync offline data',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Request Type Selection
              Text(
                'Emergency Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRequestType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRequestType = newValue!;
                      });
                    },
                    items: _requestTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type['value'],
                        child: Row(
                          children: [
                            Text(type['icon'], style: TextStyle(fontSize: 20)),
                            SizedBox(width: 10),
                            Text(type['label']),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Priority Selection
              Text(
                'Priority Level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedPriority,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPriority = newValue!;
                      });
                    },
                    items: _priorities.map((priority) {
                      return DropdownMenuItem<String>(
                        value: priority['value'],
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: priority['color'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(priority['label']),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Emergency Title',
                  hintText: 'Brief description of your emergency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title for your emergency';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Detailed Description',
                  hintText: 'Provide detailed information about your emergency',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a detailed description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Contact Information
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Your Contact Number',
                  hintText: '+91-9876543210',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _emergencyContactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact Number',
                  hintText: '+91-9876543211',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.emergency),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter emergency contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location (Optional)',
                  hintText: 'Where is the emergency occurring?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitEmergencyRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Submit Emergency Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),

              // Information Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.red[700]),
                        SizedBox(width: 8),
                        Text(
                          'Important Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Your emergency request will be processed immediately\n'
                      '• For urgent medical emergencies, contact warden directly\n'
                      '• Request will be saved offline if no internet connection\n'
                      '• You will be notified once action is taken',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 14,
                      ),
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

// Environment class is imported from core/config/environment.dart
