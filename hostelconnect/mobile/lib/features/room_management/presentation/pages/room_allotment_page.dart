// lib/features/room_management/presentation/pages/room_allotment_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/telugu_theme.dart';
import '../../../../shared/widgets/responsive_page.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/widgets/ui/professional_button.dart';
import '../../../../shared/widgets/ui/card.dart';
import '../../../../shared/widgets/ui/input_field.dart';
import '../../../../shared/widgets/ui/dropdown.dart';

class RoomAllotmentPage extends ConsumerStatefulWidget {
  const RoomAllotmentPage({super.key});

  @override
  ConsumerState<RoomAllotmentPage> createState() => _RoomAllotmentPageState();
}

class _RoomAllotmentPageState extends ConsumerState<RoomAllotmentPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStudent;
  String? selectedRoom;
  int? selectedBedNumber;
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> rooms = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    // TODO: Load students and rooms from API
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      students = [
        {'id': '1', 'name': 'John Doe', 'studentId': 'STU001'},
        {'id': '2', 'name': 'Jane Smith', 'studentId': 'STU002'},
        {'id': '3', 'name': 'Mike Johnson', 'studentId': 'STU003'},
      ];
      rooms = [
        {'id': '1', 'roomNumber': '101', 'blockName': 'Block A', 'availableBeds': 2},
        {'id': '2', 'roomNumber': '102', 'blockName': 'Block A', 'availableBeds': 1},
        {'id': '3', 'roomNumber': '201', 'blockName': 'Block B', 'availableBeds': 3},
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HPage(
      appBar: AppBar(
        title: Text(HTeluguTheme.getTeluguEnglishText('room_allotment', 'Room Allotment')),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: HResponsive.builder(builder: (ctx, r) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(r),
              SizedBox(height: HTokens.lg),
              _buildAllotmentForm(r),
              SizedBox(height: HTokens.lg),
              _buildRoomMap(r),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTeluguTheme.getTeluguEnglishText('room_allotment', 'Room Allotment'),
            style: HTeluguTheme.heading1.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTokens.sm),
          Text(
            HTeluguTheme.getTeluguEnglishText(
              'room_allotment_description',
              'Manage room assignments for students. Assign rooms and bed numbers to unassigned students.',
            ),
            style: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllotmentForm(HResponsive r) {
    return HCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('assign_room', 'Assign Room'),
              style: HTeluguTheme.heading2.copyWith(
                color: HTeluguTheme.primary,
              ),
            ),
            SizedBox(height: HTokens.md),
            
            // Student Selection
            HInputField(
              label: HTeluguTheme.getTeluguEnglishText('select_student', 'Select Student'),
              hintText: HTeluguTheme.getTeluguEnglishText('choose_student', 'Choose a student'),
              readOnly: true,
              onTap: () => _showStudentPicker(),
              controller: TextEditingController(
                text: selectedStudent != null 
                  ? students.firstWhere((s) => s['id'] == selectedStudent)['name']
                  : null,
              ),
              validator: (value) {
                if (selectedStudent == null) {
                  return HTeluguTheme.getTeluguEnglishText('please_select_student', 'Please select a student');
                }
                return null;
              },
            ),
            
            SizedBox(height: HTokens.md),
            
            // Room Selection
            HInputField(
              label: HTeluguTheme.getTeluguEnglishText('select_room', 'Select Room'),
              hintText: HTeluguTheme.getTeluguEnglishText('choose_room', 'Choose a room'),
              readOnly: true,
              onTap: () => _showRoomPicker(),
              controller: TextEditingController(
                text: selectedRoom != null 
                  ? rooms.firstWhere((r) => r['id'] == selectedRoom)['roomNumber']
                  : null,
              ),
              validator: (value) {
                if (selectedRoom == null) {
                  return HTeluguTheme.getTeluguEnglishText('please_select_room', 'Please select a room');
                }
                return null;
              },
            ),
            
            SizedBox(height: HTokens.md),
            
            // Bed Number Selection
            HInputField(
              label: HTeluguTheme.getTeluguEnglishText('bed_number', 'Bed Number'),
              hintText: HTeluguTheme.getTeluguEnglishText('enter_bed_number', 'Enter bed number'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  selectedBedNumber = int.tryParse(value);
                });
              },
            ),
            
            SizedBox(height: HTokens.lg),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: HProfessionalButton(
                    text: HTeluguTheme.getTeluguEnglishText('assign_room', 'Assign Room'),
                    variant: HProfessionalButtonVariant.primary,
                    size: HProfessionalButtonSize.lg,
                    onPressed: _assignRoom,
                  ),
                ),
                SizedBox(width: HTokens.md),
                Expanded(
                  child: HProfessionalButton(
                    text: HTeluguTheme.getTeluguEnglishText('clear_form', 'Clear Form'),
                    variant: HProfessionalButtonVariant.secondary,
                    size: HProfessionalButtonSize.lg,
                    onPressed: _clearForm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomMap(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTeluguTheme.getTeluguEnglishText('room_map', 'Room Map'),
            style: HTeluguTheme.heading2.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTokens.md),
          
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildRoomGrid(),
        ],
      ),
    );
  }

  Widget _buildRoomGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: HTokens.sm,
        mainAxisSpacing: HTokens.sm,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        final isSelected = selectedRoom == room['id'];
        final availableBeds = room['availableBeds'] as int;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedRoom = room['id'];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? HTeluguTheme.primary.withOpacity(0.1) : Colors.white,
              border: Border.all(
                color: isSelected ? HTeluguTheme.primary : HTeluguTheme.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(HTokens.sm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  room['roomNumber'],
                  style: HTeluguTheme.heading3.copyWith(
                    color: isSelected ? HTeluguTheme.primary : HTeluguTheme.textPrimary,
                  ),
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  room['blockName'],
                  style: HTeluguTheme.caption.copyWith(
                    color: HTeluguTheme.textSecondary,
                  ),
                ),
                SizedBox(height: HTokens.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HTokens.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: availableBeds > 0 ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(HTokens.xs),
                  ),
                  child: Text(
                    '$availableBeds beds',
                    style: HTeluguTheme.caption.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStudentPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(HTokens.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('select_student', 'Select Student'),
              style: HTeluguTheme.heading3,
            ),
            SizedBox(height: HTokens.md),
            ...students.map((student) => ListTile(
              title: Text(student['name']),
              subtitle: Text(student['studentId']),
              onTap: () {
                setState(() {
                  selectedStudent = student['id'];
                });
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showRoomPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(HTokens.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('select_room', 'Select Room'),
              style: HTeluguTheme.heading3,
            ),
            SizedBox(height: HTokens.md),
            ...rooms.map((room) => ListTile(
              title: Text('Room ${room['roomNumber']}'),
              subtitle: Text('${room['blockName']} - ${room['availableBeds']} beds available'),
              onTap: () {
                setState(() {
                  selectedRoom = room['id'];
                });
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _assignRoom() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement room assignment API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(HTeluguTheme.getTeluguEnglishText(
            'room_assigned_successfully',
            'Room assigned successfully!',
          )),
          backgroundColor: Colors.green,
        ),
      );
      _clearForm();
    }
  }

  void _clearForm() {
    setState(() {
      selectedStudent = null;
      selectedRoom = null;
      selectedBedNumber = null;
    });
    _formKey.currentState?.reset();
  }
}
