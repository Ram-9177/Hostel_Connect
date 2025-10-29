import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_config.dart';
import 'dart:convert';

class StudentRecordsScreen extends StatefulWidget {
  const StudentRecordsScreen({Key? key}) : super(key: key);

  @override
  State<StudentRecordsScreen> createState() => _StudentRecordsScreenState();
}

class _StudentRecordsScreenState extends State<StudentRecordsScreen> {
  List<StudentRecord> records = [];
  bool isLoading = true;
  String selectedFilter = 'all';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/gate/events'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          records = data.map((e) => StudentRecord.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorSnackBar('Failed to load records');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Error loading records: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  List<StudentRecord> get filteredRecords {
    var filtered = records;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) =>
          record.studentName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          record.studentId.toLowerCase().contains(searchQuery.toLowerCase()) ||
          record.roomNumber.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply event type filter
    if (selectedFilter != 'all') {
      filtered = filtered.where((record) => record.eventType == selectedFilter).toList();
    }

    return filtered;
  }

  String _formatTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return timestamp;
    }
  }

  Color _getEventTypeColor(String eventType) {
    return eventType == 'IN' ? Colors.green : Colors.red;
  }

  IconData _getEventTypeIcon(String eventType) {
    return eventType == 'IN' ? Icons.arrow_downward : Icons.arrow_upward;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'SUCCESS':
        return Colors.green;
      case 'FAILED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Records'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadRecords,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search students, room numbers...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 12),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('all', 'All'),
                      SizedBox(width: 8),
                      _buildFilterChip('IN', 'Entries'),
                      SizedBox(width: 8),
                      _buildFilterChip('OUT', 'Exits'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Records List
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : filteredRecords.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No records found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Try adjusting your search or filters',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredRecords.length,
                        itemBuilder: (context, index) {
                          final record = filteredRecords[index];
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _getEventTypeColor(record.eventType),
                                child: Icon(
                                  _getEventTypeIcon(record.eventType),
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                record.studentName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${record.studentId} • ${record.roomNumber}'),
                                  Text(
                                    _formatTime(record.timestamp),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(record.status).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      record.status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(record.status),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    record.location,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showRecordDetails(record);
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedFilter = value;
        });
      },
      selectedColor: Colors.blue[100],
      checkmarkColor: Colors.blue[700],
    );
  }

  void _showRecordDetails(StudentRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Record Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Student Name', record.studentName),
              _buildDetailRow('Student ID', record.studentId),
              _buildDetailRow('Room Number', record.roomNumber),
              _buildDetailRow('Event Type', record.eventType),
              _buildDetailRow('Timestamp', _formatTime(record.timestamp)),
              _buildDetailRow('Location', record.location),
              _buildDetailRow('Status', record.status),
              if (record.reason != null) _buildDetailRow('Reason', record.reason!),
              if (record.duration != null) _buildDetailRow('Duration', '${record.duration} minutes'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class StudentRecord {
  final String id;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final String eventType;
  final String timestamp;
  final String location;
  final String status;
  final String? reason;
  final int? duration;

  StudentRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.eventType,
    required this.timestamp,
    required this.location,
    required this.status,
    this.reason,
    this.duration,
  });

  factory StudentRecord.fromJson(Map<String, dynamic> json) {
    return StudentRecord(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
      eventType: json['eventType'] ?? '',
      timestamp: json['timestamp'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      reason: json['reason'],
      duration: json['duration'],
    );
  }
}

class Environment {}
