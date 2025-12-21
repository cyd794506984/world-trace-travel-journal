import '../models/trip.dart';
import '../services/db_service.dart';

abstract class TripRepository {
  Future<int> addTrip(TripModel trip);
  Future<void> updateTrip(TripModel trip);
  Future<List<TripModel>> getTrips(String userId);
  Future<void> deleteTrip(int id);
  Future<Map<String, int>> getDaysByCountry(String userId);
  Future<void> deleteTripWithSteps(String tripId);
}

class LocalTripRepository implements TripRepository {
  final DbService db;
  LocalTripRepository(this.db);

  @override
  Future<int> addTrip(TripModel trip) async {
    return db.insert('trips', trip.toMap());
  }

  @override
  Future<void> updateTrip(TripModel trip) async {
    if (trip.id == null) {
      throw ArgumentError('Cannot update a trip without an id');
    }
    await db.update('trips', trip.toMap(), 'id = ?', [trip.id]);
  }

  @override
  Future<void> deleteTrip(int id) async {
    await db.delete('trips', 'id = ?', [id]);
  }

  @override
  Future<void> deleteTripWithSteps(String tripId) async {
    await db.deleteStepsForTrip(tripId);
    await db.deleteTrip(tripId);
  }

  @override
  Future<List<TripModel>> getTrips(String userId) async {
    final rows = await db.query('trips', where: 'userId = ?', whereArgs: [userId], orderBy: 'startDate DESC');
    return rows.map((r) => TripModel.fromMap(r)).toList();
  }

  @override
  Future<Map<String, int>> getDaysByCountry(String userId) async {
    final trips = await getTrips(userId);
    final Map<String, int> out = {};
    for (final t in trips) {
      out[t.countryIsoCode] = (out[t.countryIsoCode] ?? 0) + t.days;
    }
    return out;
  }
}
