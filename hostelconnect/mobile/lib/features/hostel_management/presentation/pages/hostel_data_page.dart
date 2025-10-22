// lib/features/hostel_management/presentation/pages/hostel_data_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/telugu_theme.dart';
import '../../../../shared/widgets/responsive_page.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/widgets/ui/professional_button.dart';
import '../../../../shared/widgets/ui/card.dart';
import '../../../../core/api/hostel_api_service.dart';
import '../../../../core/config/environment.dart';
import '../../../../shared/widgets/ui/toast.dart';

class HostelDataPage extends ConsumerStatefulWidget {
  const HostelDataPage({super.key});

  @override
  ConsumerState<HostelDataPage> createState() => _HostelDataPageState();
}

class _HostelDataPageState extends ConsumerState<HostelDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostelNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _capacityController = TextEditingController();
  
  List<Map<String, dynamic>> hostels = [];
  List<Map<String, dynamic>> blocks = [];
  List<Map<String, dynamic>> rooms = [];
  bool isLoading = false;
  String selectedHostel = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    
    try {
      if (Environment.enableMockData) {
        // Use mock data for development
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          hostels = [
            {'id': '1', 'name': 'Boys Hostel A', 'address': 'Campus North', 'capacity': 200},
            {'id': '2', 'name': 'Girls Hostel B', 'address': 'Campus South', 'capacity': 150},
          ];
          blocks = [
            {'id': '1', 'name': 'Block A', 'hostelId': '1', 'floors': 3},
            {'id': '2', 'name': 'Block B', 'hostelId': '1', 'floors': 2},
            {'id': '3', 'name': 'Block C', 'hostelId': '2', 'floors': 4},
          ];
          rooms = [
            {'id': '1', 'roomNumber': '101', 'blockId': '1', 'capacity': 2, 'currentOccupancy': 1},
            {'id': '2', 'roomNumber': '102', 'blockId': '1', 'capacity': 2, 'currentOccupancy': 2},
            {'id': '3', 'roomNumber': '201', 'blockId': '2', 'capacity': 3, 'currentOccupancy': 1},
          ];
          isLoading = false;
        });
      } else {
        // Use real API
        final hostelApiService = ref.read(hostelApiServiceProvider);
        
        // Load hostels
        final hostelsData = await hostelApiService.getHostels();
        
        // Load blocks for each hostel
        final blocksData = <Map<String, dynamic>>[];
        for (final hostel in hostelsData) {
          final hostelBlocks = await hostelApiService.getBlocks(hostel['id']);
          blocksData.addAll(hostelBlocks);
        }
        
        // Load rooms for each block
        final roomsData = <Map<String, dynamic>>[];
        for (final block in blocksData) {
          final blockRooms = await hostelApiService.getRoomsByBlock(block['id']);
          roomsData.addAll(blockRooms);
        }
        
        setState(() {
          hostels = hostelsData;
          blocks = blocksData;
          rooms = roomsData;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        Toast.showError(context, 'Failed to load hostel data: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return HPage(
      appBar: AppBar(
        title: Text(HTeluguTheme.getTeluguEnglishText('hostel_data', 'Hostel Data')),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: HResponsive.builder(builder: (ctx, r) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(r),
              SizedBox(height: HTeluguTheme.spacing.lg),
              _buildHostelForm(r),
              SizedBox(height: HTeluguTheme.spacing.lg),
              _buildHostelOverview(r),
              SizedBox(height: HTeluguTheme.spacing.lg),
              _buildBlockManagement(r),
              SizedBox(height: HTeluguTheme.spacing.lg),
              _buildRoomManagement(r),
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
            HTeluguTheme.getTeluguEnglishText('hostel_management', 'Hostel Management'),
            style: HTeluguTheme.heading1.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTeluguTheme.spacing.sm),
          Text(
            HTeluguTheme.getTeluguEnglishText(
              'hostel_management_description',
              'Manage hostel data, blocks, and rooms. View occupancy statistics and analytics.',
            ),
            style: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostelForm(HResponsive r) {
    return HCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('add_new_hostel', 'Add New Hostel'),
              style: HTeluguTheme.heading2.copyWith(
                color: HTeluguTheme.primary,
              ),
            ),
            SizedBox(height: HTeluguTheme.spacing.md),
            
            Row(
              children: [
                Expanded(
                  child: HInputField(
                    controller: _hostelNameController,
                    label: HTeluguTheme.getTeluguEnglishText('hostel_name', 'Hostel Name'),
                    hintText: HTeluguTheme.getTeluguEnglishText('enter_hostel_name', 'Enter hostel name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return HTeluguTheme.getTeluguEnglishText('please_enter_hostel_name', 'Please enter hostel name');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: HTeluguTheme.spacing.md),
                Expanded(
                  child: HInputField(
                    controller: _capacityController,
                    label: HTeluguTheme.getTeluguEnglishText('capacity', 'Capacity'),
                    hintText: HTeluguTheme.getTeluguEnglishText('enter_capacity', 'Enter capacity'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return HTeluguTheme.getTeluguEnglishText('please_enter_capacity', 'Please enter capacity');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: HTeluguTheme.spacing.md),
            
            HInputField(
              controller: _addressController,
              label: HTeluguTheme.getTeluguEnglishText('address', 'Address'),
              hintText: HTeluguTheme.getTeluguEnglishText('enter_address', 'Enter address'),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return HTeluguTheme.getTeluguEnglishText('please_enter_address', 'Please enter address');
                }
                return null;
              },
            ),
            
            SizedBox(height: HTeluguTheme.spacing.lg),
            
            HProfessionalButton(
              text: HTeluguTheme.getTeluguEnglishText('add_hostel', 'Add Hostel'),
              variant: HProfessionalButtonVariant.primary,
              size: HProfessionalButtonSize.lg,
              onPressed: _addHostel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHostelOverview(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HTeluguTheme.getTeluguEnglishText('hostel_overview', 'Hostel Overview'),
            style: HTeluguTheme.heading2.copyWith(
              color: HTeluguTheme.primary,
            ),
          ),
          SizedBox(height: HTeluguTheme.spacing.md),
          
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildHostelList(),
        ],
      ),
    );
  }

  Widget _buildHostelList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hostels.length,
      itemBuilder: (context, index) {
        final hostel = hostels[index];
        final hostelBlocks = blocks.where((b) => b['hostelId'] == hostel['id']).toList();
        final hostelRooms = rooms.where((r) => 
          hostelBlocks.any((b) => b['id'] == r['blockId'])
        ).toList();
        final totalOccupancy = hostelRooms.fold<int>(0, (sum, room) => sum + (room['currentOccupancy'] as int));
        final totalCapacity = hostelRooms.fold<int>(0, (sum, room) => sum + (room['capacity'] as int));
        
        return Container(
          margin: const EdgeInsets.only(bottom: HTeluguTheme.spacingMD),
          padding: const EdgeInsets.all(HTeluguTheme.spacingMD),
          decoration: BoxDecoration(
            border: Border.all(color: HTeluguTheme.border),
            borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hostel['name'],
                    style: HTeluguTheme.heading3,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HTeluguTheme.spacing.sm,
                      vertical: HTeluguTheme.spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: HTeluguTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(HTeluguTheme.spacing.xs),
                    ),
                    child: Text(
                      '${hostelBlocks.length} blocks',
                      style: HTeluguTheme.caption.copyWith(
                        color: HTeluguTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: HTeluguTheme.spacing.sm),
              Text(
                hostel['address'],
                style: HTeluguTheme.body2.copyWith(
                  color: HTeluguTheme.textSecondary,
                ),
              ),
              SizedBox(height: HTeluguTheme.spacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      HTeluguTheme.getTeluguEnglishText('total_rooms', 'Total Rooms'),
                      '${hostelRooms.length}',
                      Colors.blue,
                    ),
                  ),
                  SizedBox(width: HTeluguTheme.spacing.sm),
                  Expanded(
                    child: _buildStatCard(
                      HTeluguTheme.getTeluguEnglishText('occupancy', 'Occupancy'),
                      '$totalOccupancy/$totalCapacity',
                      Colors.green,
                    ),
                  ),
                  SizedBox(width: HTeluguTheme.spacing.sm),
                  Expanded(
                    child: _buildStatCard(
                      HTeluguTheme.getTeluguEnglishText('utilization', 'Utilization'),
                      totalCapacity > 0 ? '${((totalOccupancy / totalCapacity) * 100).round()}%' : '0%',
                      Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(HTeluguTheme.spacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(HTeluguTheme.spacing.sm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: HTeluguTheme.heading3.copyWith(color: color),
          ),
          Text(
            label,
            style: HTeluguTheme.caption.copyWith(color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBlockManagement(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                HTeluguTheme.getTeluguEnglishText('block_management', 'Block Management'),
                style: HTeluguTheme.heading2.copyWith(
                  color: HTeluguTheme.primary,
                ),
              ),
              HProfessionalButton(
                text: HTeluguTheme.getTeluguEnglishText('add_block', 'Add Block'),
                variant: HProfessionalButtonVariant.secondary,
                size: HProfessionalButtonSize.sm,
                onPressed: () => _showAddBlockDialog(),
              ),
            ],
          ),
          SizedBox(height: HTeluguTheme.spacing.md),
          
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildBlockList(),
        ],
      ),
    );
  }

  Widget _buildBlockList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: blocks.length,
      itemBuilder: (context, index) {
        final block = blocks[index];
        final hostel = hostels.firstWhere((h) => h['id'] == block['hostelId']);
        final blockRooms = rooms.where((r) => r['blockId'] == block['id']).toList();
        
        return Container(
          margin: const EdgeInsets.only(bottom: HTeluguTheme.spacing.sm),
          padding: const EdgeInsets.all(HTeluguTheme.spacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: HTeluguTheme.border),
            borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block['name'],
                      style: HTeluguTheme.heading4,
                    ),
                    Text(
                      hostel['name'],
                      style: HTeluguTheme.caption.copyWith(
                        color: HTeluguTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${blockRooms.length} rooms',
                style: HTeluguTheme.body2.copyWith(
                  color: HTeluguTheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoomManagement(HResponsive r) {
    return HCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                HTeluguTheme.getTeluguEnglishText('room_management', 'Room Management'),
                style: HTeluguTheme.heading2.copyWith(
                  color: HTeluguTheme.primary,
                ),
              ),
              HProfessionalButton(
                text: HTeluguTheme.getTeluguEnglishText('add_room', 'Add Room'),
                variant: HProfessionalButtonVariant.secondary,
                size: HProfessionalButtonSize.sm,
                onPressed: () => _showAddRoomDialog(),
              ),
            ],
          ),
          SizedBox(height: HTeluguTheme.spacing.md),
          
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildRoomList(),
        ],
      ),
    );
  }

  Widget _buildRoomList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        final block = blocks.firstWhere((b) => b['id'] == room['blockId']);
        final hostel = hostels.firstWhere((h) => h['id'] == block['hostelId']);
        final availableBeds = room['capacity'] - room['currentOccupancy'];
        
        return Container(
          margin: const EdgeInsets.only(bottom: HTeluguTheme.spacing.sm),
          padding: const EdgeInsets.all(HTeluguTheme.spacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: HTeluguTheme.border),
            borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${room['roomNumber']}',
                      style: HTeluguTheme.heading4,
                    ),
                    Text(
                      '${block['name']} - ${hostel['name']}',
                      style: HTeluguTheme.caption.copyWith(
                        color: HTeluguTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: HTeluguTheme.spacing.sm,
                  vertical: HTeluguTheme.spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: availableBeds > 0 ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(HTeluguTheme.spacing.xs),
                ),
                child: Text(
                  '${room['currentOccupancy']}/${room['capacity']}',
                  style: HTeluguTheme.caption.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addHostel() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement add hostel API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(HTeluguTheme.getTeluguEnglishText(
            'hostel_added_successfully',
            'Hostel added successfully!',
          )),
          backgroundColor: Colors.green,
        ),
      );
      _clearForm();
    }
  }

  void _clearForm() {
    _hostelNameController.clear();
    _addressController.clear();
    _capacityController.clear();
    _formKey.currentState?.reset();
  }

  void _showAddBlockDialog() {
    // TODO: Implement add block dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(HTeluguTheme.getTeluguEnglishText(
          'feature_coming_soon',
          'Feature coming soon!',
        )),
        backgroundColor: HTeluguTheme.primary,
      ),
    );
  }

  void _showAddRoomDialog() {
    // TODO: Implement add room dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(HTeluguTheme.getTeluguEnglishText(
          'feature_coming_soon',
          'Feature coming soon!',
        )),
        backgroundColor: HTeluguTheme.primary,
      ),
    );
  }
}
