// Meal Notification Settings Page - Configure Daily Meal Reminders
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/config/api_config.dart';

class MealNotificationSettingsPage extends ConsumerStatefulWidget {
  const MealNotificationSettingsPage({super.key});

  @override
  ConsumerState<MealNotificationSettingsPage> createState() =>
      _MealNotificationSettingsPageState();
}

class _MealNotificationSettingsPageState
    extends ConsumerState<MealNotificationSettingsPage> {
  bool _isLoading = true;
  bool _breakfastEnabled = true;
  bool _lunchEnabled = true;
  bool _dinnerEnabled = true;

  TimeOfDay _breakfastTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _lunchTime = const TimeOfDay(hour: 12, minute: 30);
  TimeOfDay _dinnerTime = const TimeOfDay(hour: 18, minute: 0);

  String _breakfastMessage = 'Breakfast is ready! Please visit the mess hall.';
  String _lunchMessage = 'Lunch is being served now.';
  String _dinnerMessage = 'Dinner time! Don\'t miss your meal.';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    try {
      final token = ref.read(authProvider).token;
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/meals/notification-settings'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final settings = json.decode(response.body);
        setState(() {
          _breakfastEnabled = settings['breakfastEnabled'] ?? true;
          _lunchEnabled = settings['lunchEnabled'] ?? true;
          _dinnerEnabled = settings['dinnerEnabled'] ?? true;
          _breakfastMessage = settings['breakfastMessage'] ?? _breakfastMessage;
          _lunchMessage = settings['lunchMessage'] ?? _lunchMessage;
          _dinnerMessage = settings['dinnerMessage'] ?? _dinnerMessage;
        });
      }
    } catch (e) {
      // Use defaults if settings not found
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    try {
      final token = ref.read(authProvider).token;
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/meals/notification-settings'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'breakfastEnabled': _breakfastEnabled,
          'lunchEnabled': _lunchEnabled,
          'dinnerEnabled': _dinnerEnabled,
          'breakfastTime': '${_breakfastTime.hour}:${_breakfastTime.minute}',
          'lunchTime': '${_lunchTime.hour}:${_lunchTime.minute}',
          'dinnerTime': '${_dinnerTime.hour}:${_dinnerTime.minute}',
          'breakfastMessage': _breakfastMessage,
          'lunchMessage': _lunchMessage,
          'dinnerMessage': _dinnerMessage,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving settings: $e')),
      );
    }
  }

  Future<void> _sendTestNotification(String mealType) async {
    try {
      final token = ref.read(authProvider).token;
      await http.post(
        Uri.parse('${ApiConfig.baseUrl}/meals/send-test-notification'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'mealType': mealType}),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Test $mealType notification sent!'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Notification Settings'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            onPressed: _saveSettings,
            icon: const Icon(Icons.save),
            tooltip: 'Save Settings',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Info Card
                Card(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Configure automated meal notifications sent to all students daily',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Breakfast Settings
                _buildMealSection(
                  'Breakfast',
                  Icons.free_breakfast,
                  Colors.orange,
                  _breakfastEnabled,
                  _breakfastTime,
                  _breakfastMessage,
                  (value) => setState(() => _breakfastEnabled = value),
                  (time) => setState(() => _breakfastTime = time),
                  (message) => setState(() => _breakfastMessage = message),
                ),
                const SizedBox(height: 24),

                // Lunch Settings
                _buildMealSection(
                  'Lunch',
                  Icons.lunch_dining,
                  Colors.green,
                  _lunchEnabled,
                  _lunchTime,
                  _lunchMessage,
                  (value) => setState(() => _lunchEnabled = value),
                  (time) => setState(() => _lunchTime = time),
                  (message) => setState(() => _lunchMessage = message),
                ),
                const SizedBox(height: 24),

                // Dinner Settings
                _buildMealSection(
                  'Dinner',
                  Icons.dinner_dining,
                  Colors.blue,
                  _dinnerEnabled,
                  _dinnerTime,
                  _dinnerMessage,
                  (value) => setState(() => _dinnerEnabled = value),
                  (time) => setState(() => _dinnerTime = time),
                  (message) => setState(() => _dinnerMessage = message),
                ),
                const SizedBox(height: 24),

                // Cron Schedule Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, color: Colors.grey[700]),
                            const SizedBox(width: 8),
                            const Text(
                              'Automated Schedule',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildScheduleRow(
                            '7:00 AM IST', 'Breakfast Reminder', Colors.orange),
                        _buildScheduleRow(
                            '9:00 AM IST', 'Daily Menu Announcement', Colors.purple),
                        _buildScheduleRow(
                            '6:00 PM IST', 'Dinner Warning (30 min before)', Colors.blue),
                        const SizedBox(height: 12),
                        const Text(
                          'Note: Times are configured via cron jobs in the backend. These notifications run automatically.',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save All Settings',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildMealSection(
    String mealName,
    IconData icon,
    Color color,
    bool enabled,
    TimeOfDay time,
    String message,
    Function(bool) onEnabledChanged,
    Function(TimeOfDay) onTimeChanged,
    Function(String) onMessageChanged,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        enabled ? 'Enabled' : 'Disabled',
                        style: TextStyle(
                          fontSize: 12,
                          color: enabled ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: enabled,
                  onChanged: onEnabledChanged,
                  activeColor: color,
                ),
              ],
            ),
            if (enabled) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              
              // Time Selection
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Notification Time'),
                subtitle: Text(time.format(context)),
                trailing: const Icon(Icons.edit),
                onTap: () async {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (newTime != null) {
                    onTimeChanged(newTime);
                  }
                },
              ),
              const SizedBox(height: 12),
              
              // Message
              TextField(
                controller: TextEditingController(text: message),
                decoration: const InputDecoration(
                  labelText: 'Notification Message',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.message),
                ),
                maxLines: 2,
                onChanged: onMessageChanged,
              ),
              const SizedBox(height: 12),
              
              // Test Button
              OutlinedButton.icon(
                onPressed: () => _sendTestNotification(mealName.toLowerCase()),
                icon: const Icon(Icons.send),
                label: const Text('Send Test Notification'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String time, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            child: Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
