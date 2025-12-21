import '../models/step.dart';
import '../services/db_service.dart';

class StepRepository {
  final DbService dbService;

  StepRepository(this.dbService);

  Future<List<StepModel>> getStepsForTrip(String tripId) async {
    final rows = await dbService.query(
      'trip_steps',
      where: 'tripId = ?',
      whereArgs: [tripId],
      orderBy: 'timestamp ASC',
    );
    return rows.map((row) => StepModel.fromMap(row)).toList();
  }

  Future<void> addStep(StepModel step) async {
    await dbService.insert('trip_steps', step.toMap());
  }

  Future<void> updateStep(StepModel step) async {
    await dbService.update(
      'trip_steps',
      step.toMap(),
      'id = ?',
      [step.id],
    );
  }

  Future<void> deleteStep(String id) async {
    await dbService.delete(
      'trip_steps',
      'id = ?',
      [id],
    );
  }

  Future<List<StepModel>> getStepsForTrips(List<String> tripIds) async {
    if (tripIds.isEmpty) return [];
    final placeholders = List.filled(tripIds.length, '?').join(', ');
    final rows = await dbService.query(
      'trip_steps',
      where: 'tripId IN ($placeholders)',
      whereArgs: tripIds,
      orderBy: 'timestamp ASC',
    );
    return rows.map((row) => StepModel.fromMap(row)).toList();
  }
}
