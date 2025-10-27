// lib/core/models/allocation_action.dart
enum AllocationAction {
  allocate,
  deallocate,
  transfer,
  reserve,
  unreserve,
  maintenance,
}

extension AllocationActionExtension on AllocationAction {
  String get displayName {
    switch (this) {
      case AllocationAction.allocate:
        return 'Allocate';
      case AllocationAction.deallocate:
        return 'Deallocate';
      case AllocationAction.transfer:
        return 'Transfer';
      case AllocationAction.reserve:
        return 'Reserve';
      case AllocationAction.unreserve:
        return 'Unreserve';
      case AllocationAction.maintenance:
        return 'Maintenance';
    }
  }

  String get description {
    switch (this) {
      case AllocationAction.allocate:
        return 'Assign student to bed';
      case AllocationAction.deallocate:
        return 'Remove student from bed';
      case AllocationAction.transfer:
        return 'Move student to different bed';
      case AllocationAction.reserve:
        return 'Reserve bed for future allocation';
      case AllocationAction.unreserve:
        return 'Remove bed reservation';
      case AllocationAction.maintenance:
        return 'Mark bed for maintenance';
    }
  }
}
