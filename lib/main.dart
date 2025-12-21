import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'repositories/goal_repository.dart';
import 'repositories/trip_repository.dart';
import 'repositories/step_repository.dart';
import 'services/db_service.dart';
import 'firebase_init.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.init();
  await DbService.instance.init();
  final authService = AuthService();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => authService),
      Provider<TripRepository>(create: (_) => LocalTripRepository(DbService.instance)),
      Provider<StepRepository>(create: (_) => StepRepository(DbService.instance)),
      Provider<GoalRepository>(create: (_) => GoalRepository(DbService.instance)),
    ],
    child: const WorldTraceApp(),
  ));
}
