import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealNotificationEvent {
  final String mealType; // e.g., 'lunch'
  final DateTime date;

  MealNotificationEvent({required this.mealType, required this.date});
}

class MealNotificationController {
  final StreamController<MealNotificationEvent> _controller = StreamController.broadcast();

  Stream<MealNotificationEvent> get stream => _controller.stream;

  void notify(MealNotificationEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() {
    _controller.close();
  }
}

final mealNotificationControllerProvider = Provider<MealNotificationController>((ref) {
  final controller = MealNotificationController();
  ref.onDispose(controller.dispose);
  return controller;
});


