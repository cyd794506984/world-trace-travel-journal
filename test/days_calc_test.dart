import 'package:flutter_test/flutter_test.dart';
import 'package:world_trace/models/trip.dart';

void main() {
  test('days calculation includes both start and end day', () {
    final t = TripModel(userId: 'u', countryIsoCode: 'JP', startDate: DateTime(2020,1,1), endDate: DateTime(2020,1,3));
    expect(t.days, 3);
  });
}
