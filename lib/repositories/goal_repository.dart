import '../models/goal.dart';
import '../services/db_service.dart';

class GoalRepository {
  GoalRepository(this._dbService);

  final DbService _dbService;
  static const String _tableName = 'goals';

  Future<List<GoalModel>> getAllGoals(String userId) async {
    final rows = await _dbService.query(
      _tableName,
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return rows.map(GoalModel.fromMap).toList();
  }

  Future<void> addGoal(GoalModel goal) async {
    await _dbService.insert(_tableName, goal.toMap());
  }

  Future<void> updateGoal(GoalModel goal) async {
    await _dbService.update(
      _tableName,
      goal.toMap(),
      'id = ?',
      [goal.id],
    );
  }

  Future<void> deleteGoal(String id) async {
    await _dbService.delete(
      _tableName,
      'id = ?',
      [id],
    );
  }
}
