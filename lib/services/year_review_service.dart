import '../models/achievement.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../models/year_review.dart';

class YearReviewService {
  static YearReview computeYearReview({
    required int year,
    required List<TripModel> trips,
    required List<StepModel> allSteps,
    required List<Achievement> allAchievements,
  }) {
    final yearTrips = trips.where((trip) => _tripIntersectsYear(trip, year)).toList();
    final countries = <String>{};
    final daysByCountry = <String, int>{};
    int totalDays = 0;
    TripModel? longestTrip;
    int longestTripDays = 0;

    for (final trip in yearTrips) {
      final days = _daysWithinYear(trip, year);
      totalDays += days;
      final countryKey = trip.countryIsoCode.toUpperCase();
      countries.add(countryKey);
      daysByCountry[countryKey] = (daysByCountry[countryKey] ?? 0) + days;
      if (days > longestTripDays) {
        longestTrip = trip;
        longestTripDays = days;
      }
    }

    String? topCountryIso;
    int topCountryDays = 0;
    if (daysByCountry.isNotEmpty) {
      final sorted = daysByCountry.entries.toList()
        ..sort((a, b) {
          final cmp = b.value.compareTo(a.value);
          if (cmp != 0) return cmp;
          return a.key.compareTo(b.key);
        });
      topCountryIso = sorted.first.key;
      topCountryDays = sorted.first.value;
    }

    final yearTripIds = yearTrips
        .where((trip) => trip.id != null)
        .map((trip) => trip.id!.toString())
        .toSet();

    final highlightSteps = allSteps
        .where((step) =>
            yearTripIds.contains(step.tripId) &&
            step.timestamp.year == year &&
            step.mediaPaths.isNotEmpty)
        .take(6)
        .toList();

    final unlockedAchievements =
        allAchievements.where((achievement) => achievement.unlocked).toList();

    return YearReview(
      year: year,
      tripsCount: yearTrips.length,
      countriesCount: countries.length,
      totalDays: totalDays,
      longestTrip: longestTrip,
      longestTripDays: longestTripDays,
      topCountryIso: topCountryIso,
      topCountryDays: topCountryDays,
      achievements: unlockedAchievements,
      highlightSteps: highlightSteps,
    );
  }

  static bool _tripIntersectsYear(TripModel trip, int year) {
    final startYear = trip.startDate.year;
    final endYear = trip.endDate.year;
    return startYear <= year && endYear >= year;
  }

  static int _daysWithinYear(TripModel trip, int year) {
    final yearStart = DateTime(year, 1, 1);
    final yearEnd = DateTime(year, 12, 31);
    final start = trip.startDate.isAfter(yearStart) ? trip.startDate : yearStart;
    final end = trip.endDate.isBefore(yearEnd) ? trip.endDate : yearEnd;
    if (end.isBefore(start)) return 0;
    return end.difference(start).inDays + 1;
  }
}
