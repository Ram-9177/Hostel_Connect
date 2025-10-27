// lib/features/schedule/presentation/pages/schedule_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  int _selectedDayIndex = DateTime.now().weekday - 1; // Monday = 0

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  // Mock schedule data - replace with actual API
  final Map<String, List<ClassItem>> _scheduleData = {
    'Monday': [
      ClassItem(
        subject: 'Data Structures',
        instructor: 'Dr. Smith',
        room: 'Room 301',
        startTime: '09:00 AM',
        endTime: '10:30 AM',
        color: const Color(0xFF3B82F6),
      ),
      ClassItem(
        subject: 'Operating Systems',
        instructor: 'Prof. Johnson',
        room: 'Lab 201',
        startTime: '11:00 AM',
        endTime: '12:30 PM',
        color: const Color(0xFF8B5CF6),
      ),
      ClassItem(
        subject: 'Database Systems',
        instructor: 'Dr. Williams',
        room: 'Room 305',
        startTime: '02:00 PM',
        endTime: '03:30 PM',
        color: const Color(0xFF10B981),
      ),
    ],
    'Tuesday': [
      ClassItem(
        subject: 'Computer Networks',
        instructor: 'Dr. Brown',
        room: 'Lab 103',
        startTime: '09:00 AM',
        endTime: '10:30 AM',
        color: const Color(0xFFEC4899),
      ),
      ClassItem(
        subject: 'Software Engineering',
        instructor: 'Prof. Davis',
        room: 'Room 402',
        startTime: '11:00 AM',
        endTime: '12:30 PM',
        color: const Color(0xFFF59E0B),
      ),
      ClassItem(
        subject: 'Web Technologies',
        instructor: 'Dr. Miller',
        room: 'Lab 204',
        startTime: '02:00 PM',
        endTime: '03:30 PM',
        color: const Color(0xFF06B6D4),
      ),
      ClassItem(
        subject: 'Algorithms Lab',
        instructor: 'Prof. Wilson',
        room: 'Lab 301',
        startTime: '04:00 PM',
        endTime: '05:30 PM',
        color: const Color(0xFF8B5CF6),
      ),
    ],
    'Wednesday': [
      ClassItem(
        subject: 'Machine Learning',
        instructor: 'Dr. Moore',
        room: 'Room 501',
        startTime: '09:00 AM',
        endTime: '10:30 AM',
        color: const Color(0xFFEF4444),
      ),
      ClassItem(
        subject: 'Data Structures',
        instructor: 'Dr. Smith',
        room: 'Room 301',
        startTime: '11:00 AM',
        endTime: '12:30 PM',
        color: const Color(0xFF3B82F6),
      ),
      ClassItem(
        subject: 'Cloud Computing',
        instructor: 'Prof. Taylor',
        room: 'Lab 401',
        startTime: '02:00 PM',
        endTime: '03:30 PM',
        color: const Color(0xFF14B8A6),
      ),
    ],
    'Thursday': [
      ClassItem(
        subject: 'Artificial Intelligence',
        instructor: 'Dr. Anderson',
        room: 'Room 403',
        startTime: '09:00 AM',
        endTime: '10:30 AM',
        color: const Color(0xFF8B5CF6),
      ),
      ClassItem(
        subject: 'Computer Networks',
        instructor: 'Dr. Brown',
        room: 'Lab 103',
        startTime: '11:00 AM',
        endTime: '12:30 PM',
        color: const Color(0xFFEC4899),
      ),
      ClassItem(
        subject: 'Operating Systems Lab',
        instructor: 'Prof. Johnson',
        room: 'Lab 201',
        startTime: '02:00 PM',
        endTime: '03:30 PM',
        color: const Color(0xFF8B5CF6),
      ),
      ClassItem(
        subject: 'Seminar',
        instructor: 'Various',
        room: 'Auditorium',
        startTime: '04:00 PM',
        endTime: '05:00 PM',
        color: const Color(0xFF64748B),
      ),
    ],
    'Friday': [
      ClassItem(
        subject: 'Database Systems',
        instructor: 'Dr. Williams',
        room: 'Room 305',
        startTime: '09:00 AM',
        endTime: '10:30 AM',
        color: const Color(0xFF10B981),
      ),
      ClassItem(
        subject: 'Software Engineering',
        instructor: 'Prof. Davis',
        room: 'Room 402',
        startTime: '11:00 AM',
        endTime: '12:30 PM',
        color: const Color(0xFFF59E0B),
      ),
      ClassItem(
        subject: 'Project Work',
        instructor: 'Mentors',
        room: 'Lab 501',
        startTime: '02:00 PM',
        endTime: '04:00 PM',
        color: const Color(0xFF06B6D4),
      ),
    ],
    'Saturday': [
      ClassItem(
        subject: 'Guest Lecture',
        instructor: 'Industry Expert',
        room: 'Auditorium',
        startTime: '10:00 AM',
        endTime: '12:00 PM',
        color: const Color(0xFF64748B),
      ),
      ClassItem(
        subject: 'Sports',
        instructor: 'Coach',
        room: 'Ground',
        startTime: '03:00 PM',
        endTime: '05:00 PM',
        color: const Color(0xFF10B981),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final selectedDay = _days[_selectedDayIndex];
    final classes = _scheduleData[selectedDay] ?? [];
    final totalClasses = _scheduleData.values.expand((x) => x).length;
    final totalHours = totalClasses * 1.5; // Assuming 1.5 hours per class

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Stats Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard('$totalClasses', 'Total Classes', Icons.book),
                    _buildStatCard('${totalHours.toInt()}h', 'Hours/Week', Icons.access_time),
                    _buildStatCard('${_days.length}', 'Days', Icons.calendar_today),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Day Navigator
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedDayIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDayIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                            )
                          : null,
                      color: isSelected ? null : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _days[index].substring(0, 3),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Class List
          Expanded(
            child: classes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'No classes scheduled',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      final classItem = classes[index];
                      return _buildClassCard(classItem);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(ClassItem classItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Color Bar
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: classItem.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            classItem.subject,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: classItem.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${classItem.startTime} - ${classItem.endTime}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: classItem.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          classItem.instructor,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.room, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          classItem.room,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassItem {
  final String subject;
  final String instructor;
  final String room;
  final String startTime;
  final String endTime;
  final Color color;

  ClassItem({
    required this.subject,
    required this.instructor,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}
