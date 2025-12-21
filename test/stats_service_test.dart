import 'package:flutter_test/flutter_test.dart';
import 'package:world_trace/models/trip.dart';
import 'package:world_trace/services/stats_service.dart';

void main() {
  test('computeDaysByCountry aggregates correctly', () {
    final trips = [
      TripModel(userId: 'u', countryIsoCode: 'JP', startDate: DateTime(2020,1,1), endDate: DateTime(2020,1,3)), // 3
      TripModel(userId: 'u', countryIsoCode: 'US', startDate: DateTime(2021,5,1), endDate: DateTime(2021,5,1)), //1
      TripModel(userId: 'u', countryIsoCode: 'JP', startDate: DateTime(2022,2,1), endDate: DateTime(2022,2,2)), //2
    ];
    final map = StatsService.computeDaysByCountry(trips);
    expect(map['JP'], 5);
    expect(map['US'], 1);
  });

  test('computeSummary returns totals and lastTrip', () {
    final trips = [
      TripModel(userId: 'u', countryIsoCode: 'A', startDate: DateTime(2020,1,1), endDate: DateTime(2020,1,2)),
      TripModel(userId: 'u', countryIsoCode: 'B', startDate: DateTime(2021,1,1), endDate: DateTime(2021,1,1)),
    ];
    final s = StatsService.computeSummary(trips);
    expect(s['totalCountries'], 2);
    expect(s['totalDays'], 3);
    expect(s['lastTrip'], isA<DateTime>());
  });

  test('computeGlobalStats splits days per year', () {
    final trips = [
      TripModel(
        userId: 'u',
        countryIsoCode: 'IT',
        startDate: DateTime(2022, 12, 28),
        endDate: DateTime(2023, 1, 3),
      ),
      TripModel(
        userId: 'u',
        countryIsoCode: 'FR',
        startDate: DateTime(2023, 6, 1),
        endDate: DateTime(2023, 6, 5),
      ),
    ];

    final stats = StatsService.computeGlobalStats(trips);

    expect(stats.totalTrips, 2);
    expect(stats.totalCountries, 2);
    expect(stats.totalTravelDays, 12);
    expect(stats.travelDaysByYear[2022], 4);
    expect(stats.travelDaysByYear[2023], 8);
    expect(stats.topYear, 2023);
    expect(stats.topYearDays, 8);
  });
}
