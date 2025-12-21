import 'package:flutter/foundation.dart';

import '../models/trip.dart';

enum PlanType { free, pro }

class PlanService {
  PlanService._();
  static final PlanService instance = PlanService._();

  static const int _freePlanStepLimit = 10;

  final ValueNotifier<PlanType> _planNotifier = ValueNotifier<PlanType>(PlanType.free);

  ValueListenable<PlanType> get planTypeListenable => _planNotifier;

  PlanType currentPlan() => _planNotifier.value;

  bool isFree() => currentPlan() == PlanType.free;

  bool isPro() => currentPlan() == PlanType.pro;

  int maxStepsPerTripForCurrentPlan() {
    return isPro() ? -1 : _freePlanStepLimit;
  }

  bool canAddStepForTrip(TripModel trip, int currentStepCount) {
    assert(trip.id != null, 'Trip id must be available to evaluate plan limits');
    final maxSteps = maxStepsPerTripForCurrentPlan();
    if (maxSteps < 0) return true;
    return currentStepCount < maxSteps;
  }

  Future<void> upgradeToProMock() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _planNotifier.value = PlanType.pro;
  }
}
