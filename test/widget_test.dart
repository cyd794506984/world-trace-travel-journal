import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_trace/app.dart';
import 'package:world_trace/models/goal.dart';
import 'package:world_trace/models/step.dart';
import 'package:world_trace/models/trip.dart';
import 'package:world_trace/repositories/goal_repository.dart';
import 'package:world_trace/repositories/step_repository.dart';
import 'package:world_trace/repositories/trip_repository.dart';
import 'package:world_trace/services/auth_service.dart';
import 'package:world_trace/services/db_service.dart';
import 'package:world_trace/theme/app_theme.dart';

void main() {
  testWidgets('smoke test: app builds', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    AppTheme.useGoogleFonts = false;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
          Provider<TripRepository>(create: (_) => _FakeTripRepository()),
          Provider<StepRepository>(create: (_) => _FakeStepRepository()),
          Provider<GoalRepository>(create: (_) => _FakeGoalRepository()),
        ],
        child: const WorldTraceApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(WorldTraceApp), findsOneWidget);
  });
}

class _FakeTripRepository implements TripRepository {
  @override
  Future<int> addTrip(TripModel trip) async => 0;

  @override
  Future<void> deleteTrip(int id) async {}

  @override
  Future<void> deleteTripWithSteps(String tripId) async {}

  @override
  Future<Map<String, int>> getDaysByCountry(String userId) async => {};

  @override
  Future<List<TripModel>> getTrips(String userId) async => [];

  @override
  Future<void> updateTrip(TripModel trip) async {}
}

class _FakeStepRepository implements StepRepository {
  @override
  DbService get dbService => throw UnimplementedError();

  @override
  Future<void> addStep(StepModel step) async {}

  @override
  Future<void> deleteStep(String id) async {}

  @override
  Future<List<StepModel>> getStepsForTrip(String tripId) async => [];

  @override
  Future<List<StepModel>> getStepsForTrips(List<String> tripIds) async => [];

  @override
  Future<void> updateStep(StepModel step) async {}
}

class _FakeGoalRepository implements GoalRepository {
  @override
  Future<void> addGoal(GoalModel goal) async {}

  @override
  Future<void> deleteGoal(String id) async {}

  @override
  Future<List<GoalModel>> getAllGoals(String userId) async => [];

  @override
  Future<void> updateGoal(GoalModel goal) async {}
}
