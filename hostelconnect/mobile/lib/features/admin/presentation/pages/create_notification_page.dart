// Create Targeted Notification Page for Admin/Warden
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/config/api_config.dart';

class CreateNotificationPage extends ConsumerStatefulWidget {
  const CreateNotificationPage({super.key});

  @override
  ConsumerState<CreateNotificationPage> createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends ConsumerState<CreateNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  
  String _selectedType = 'announcement';
  String _selectedPriority = 'medium';
  String _selectedTargetType = 'all';
  
  String? _selectedHostelId;
  String? _selectedBlockId;
  int? _selectedFloor;
  String? _selectedRoomId;
  
  List<dynamic> _hostels = [];
  List<dynamic> _blocks = [];
  List<dynamic> _rooms = [];
  
  bool _isLoading = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadHostels();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _loadHostels() async {
    setState(() => _isLoading = true);
    try {
      final token = ref.read(authProvider).token;
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/hostels'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _hostels = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading hostels: $e')),
      );
    }
  }

  Future<void> _loadBlocks(String hostelId) async {
    try {
      final token = ref.read(authProvider).token;
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/hostels/$hostelId/blocks'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _blocks = json.decode(response.body);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading blocks: $e')),
      );
    }
  }

  Future<void> _loadRooms(String blockId) async {
    try {
      final token = ref.read(authProvider).token;
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/rooms?blockId=$blockId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _rooms = json.decode(response.body);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading rooms: $e')),
      );
    }
  }

  Future<void> _sendNotification() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final token = ref.read(authProvider).token;
      
      final Map<String, dynamic> payload = {
        'title': _titleController.text,
        'body': _bodyController.text,
        'type': _selectedType,
        'priority': _selectedPriority,
        'targetType': _selectedTargetType,
      };

      // Add conditional fields based on target type
      if (_selectedTargetType == 'hostel' || _selectedTargetType == 'block' || _selectedTargetType == 'floor') {
        payload['hostelId'] = _selectedHostelId;
      }
      if (_selectedTargetType == 'block' || _selectedTargetType == 'floor') {
        payload['blockId'] = _selectedBlockId;
      }
      if (_selectedTargetType == 'floor') {
        payload['floor'] = _selectedFloor;
      }
      if (_selectedTargetType == 'room') {
        payload['roomId'] = _selectedRoomId;
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/notifications/send-targeted'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      setState(() => _isSending = false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final result = json.decode(response.body);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Notification sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.pop(context);
      } else {
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Notification'),
        backgroundColor: Colors.blue[700],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Title Field
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Body Field
                  TextFormField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      labelText: 'Message *',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Type Selection
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'announcement', child: Text('Announcement')),
                      DropdownMenuItem(value: 'notice', child: Text('Notice')),
                      DropdownMenuItem(value: 'system', child: Text('System')),
                      DropdownMenuItem(value: 'meal_intent', child: Text('Meal Intent')),
                      DropdownMenuItem(value: 'gate_pass', child: Text('Gate Pass')),
                    ],
                    onChanged: (value) => setState(() => _selectedType = value!),
                  ),
                  const SizedBox(height: 16),

                  // Priority Selection
                  DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.priority_high),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                      DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
                    ],
                    onChanged: (value) => setState(() => _selectedPriority = value!),
                  ),
                  const SizedBox(height: 24),

                  // Target Type Selection
                  const Text(
                    'Send To',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedTargetType,
                    decoration: const InputDecoration(
                      labelText: 'Target Audience',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.people),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All Students')),
                      DropdownMenuItem(value: 'hostel', child: Text('Specific Hostel')),
                      DropdownMenuItem(value: 'block', child: Text('Specific Block')),
                      DropdownMenuItem(value: 'floor', child: Text('Specific Floor')),
                      DropdownMenuItem(value: 'room', child: Text('Specific Room')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedTargetType = value!;
                        _selectedHostelId = null;
                        _selectedBlockId = null;
                        _selectedFloor = null;
                        _selectedRoomId = null;
                        _blocks = [];
                        _rooms = [];
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Conditional Fields based on Target Type
                  if (_selectedTargetType == 'hostel' || 
                      _selectedTargetType == 'block' || 
                      _selectedTargetType == 'floor') ...[
                    DropdownButtonFormField<String>(
                      value: _selectedHostelId,
                      decoration: const InputDecoration(
                        labelText: 'Select Hostel *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.domain),
                      ),
                      items: _hostels.map((hostel) {
                        return DropdownMenuItem<String>(
                          value: hostel['id'],
                          child: Text(hostel['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedHostelId = value;
                          _selectedBlockId = null;
                          _blocks = [];
                        });
                        if (value != null) {
                          _loadBlocks(value);
                        }
                      },
                      validator: (value) {
                        if (value == null) return 'Please select a hostel';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_selectedTargetType == 'block' || _selectedTargetType == 'floor') ...[
                    DropdownButtonFormField<String>(
                      value: _selectedBlockId,
                      decoration: const InputDecoration(
                        labelText: 'Select Block *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.apartment),
                      ),
                      items: _blocks.map((block) {
                        return DropdownMenuItem<String>(
                          value: block['id'],
                          child: Text(block['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBlockId = value;
                          _selectedRoomId = null;
                          _rooms = [];
                        });
                        if (value != null) {
                          _loadRooms(value);
                        }
                      },
                      validator: (value) {
                        if (value == null) return 'Please select a block';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_selectedTargetType == 'floor') ...[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Floor Number *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.layers),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _selectedFloor = int.tryParse(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter floor number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_selectedTargetType == 'room') ...[
                    DropdownButtonFormField<String>(
                      value: _selectedRoomId,
                      decoration: const InputDecoration(
                        labelText: 'Select Room *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.meeting_room),
                      ),
                      items: _rooms.map((room) {
                        return DropdownMenuItem<String>(
                          value: room['id'],
                          child: Text('Room ${room['roomNumber']}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedRoomId = value);
                      },
                      validator: (value) {
                        if (value == null) return 'Please select a room';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],

                  const SizedBox(height: 24),

                  // Send Button
                  ElevatedButton(
                    onPressed: _isSending ? null : _sendNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send Notification',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
