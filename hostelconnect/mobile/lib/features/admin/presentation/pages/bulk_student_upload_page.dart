// Bulk Student Upload Page with CSV Processing
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/config/api_config.dart';

class BulkStudentUploadPage extends ConsumerStatefulWidget {
  const BulkStudentUploadPage({super.key});

  @override
  ConsumerState<BulkStudentUploadPage> createState() => _BulkStudentUploadPageState();
}

class _BulkStudentUploadPageState extends ConsumerState<BulkStudentUploadPage> {
  File? _selectedFile;
  bool _isUploading = false;
  Map<String, dynamic>? _uploadResult;

  Future<void> _pickCSVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _uploadResult = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: $e')),
      );
    }
  }

  Future<void> _uploadCSV() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a CSV file first')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final token = ref.read(authProvider).token;
      
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConfig.baseUrl}/students/bulk-upload'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _selectedFile!.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      setState(() => _isUploading = false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() => _uploadResult = result);

        // Support both shapes: {created, errors} or {successCount}
        final created = result['created'] ?? result['successCount'] ?? 0;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload complete! $created students created'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Upload failed: ${response.body}');
      }
    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _downloadTemplate() {
    // Template CSV content (exact headers expected by backend)
    const template = '''Name,Hall Ticket,College code,Number,Hostel Name
John Doe,2024CS001,CSE,9876543210,Hostel A
Jane Smith,2024EC002,ECE,9876543211,Hostel B''';

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Template format shown below. Copy to create your CSV file.'),
        duration: Duration(seconds: 3),
      ),
    );

    // Show template in dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('CSV Template'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Required Columns:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Name (string)'),
              const Text('• Hall Ticket (string, unique)'),
              const Text('• College code (string)'),
              const Text('• Number (string, 10-15 digits)'),
              const Text('• Hostel Name (string, must exist)'),
              const SizedBox(height: 16),
              const Text(
                'Example CSV:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  template,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Student Upload'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Instructions Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      const Text(
                        'How to Upload',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('1. Download the CSV template'),
                  const Text('2. Fill in student details (name, hall ticket, etc.)'),
                  const Text('3. Ensure hostel names match existing hostels'),
                  const Text('4. Upload the CSV file'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _downloadTemplate,
                    icon: const Icon(Icons.download),
                    label: const Text('View Template'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // File Selection Section
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select CSV File',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  if (_selectedFile == null)
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: _pickCSVFile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to select CSV file',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        border: Border.all(color: Colors.green[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.insert_drive_file, color: Colors.green[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedFile!.path.split('/').last,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${(_selectedFile!.lengthSync() / 1024).toStringAsFixed(2)} KB',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _selectedFile = null),
                            icon: const Icon(Icons.close, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedFile == null || _isUploading ? null : _uploadCSV,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isUploading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Upload CSV',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Upload Results
          if (_uploadResult != null) ...[
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green[700]),
                        const SizedBox(width: 8),
                        const Text(
                          'Upload Results',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    _buildResultRow('Successfully Created', '${_uploadResult!['created'] ?? _uploadResult!['successCount'] ?? 0}', Colors.green),
                    if (_uploadResult!['errors'] != null)
                      _buildResultRow('Errors', '${(_uploadResult!['errors'] as List).length}', Colors.red),
                    
                    if (_uploadResult!['errors'] != null && 
                        (_uploadResult!['errors'] as List).isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Error Details:',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var error in _uploadResult!['errors'])
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '• Row ${error['row']}: ${error['error']}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
