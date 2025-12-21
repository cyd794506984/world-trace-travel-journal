import '../models/goal.dart';
import '../models/trip.dart';

class GoalProgress {
  final GoalModel goal;
  final int currentValue;
  final double progress;

  const GoalProgress({
    required this.goal,
    required this.currentValue,
    required this.progress,
  });
}

class GlobalStats {
  final int totalTrips;
  final int totalCountries;
  final int totalTravelDays;
  final Map<int, int> travelDaysByYear;
  final int? topYear;
  final int? topYearDays;

  const GlobalStats({
    required this.totalTrips,
    required this.totalCountries,
    required this.totalTravelDays,
    required this.travelDaysByYear,
    required this.topYear,
    required this.topYearDays,
  });

  bool get hasTrips => totalTrips > 0;
}

class StatsService {
  /// Compute total days per country from a list of trips.
  static Map<String, int> computeDaysByCountry(List<TripModel> trips) {
    final out = <String, int>{};
    for (final t in trips) {
      out[t.countryIsoCode] = (out[t.countryIsoCode] ?? 0) + t.days;
    }
    return out;
  }

  static StatsHighlights computeHighlights(List<TripModel> trips) {
    if (trips.isEmpty) {
      return const StatsHighlights(
        averageDaysPerTrip: 0,
        longestTrip: null,
        longestTripDays: 0,
        mostRecentTrip: null,
      );
    }

    final totalDays = trips.fold<int>(0, (sum, trip) => sum + trip.days);
    final avg = totalDays / trips.length;

    TripModel? longest;
    for (final trip in trips) {
      if (longest == null || trip.days > longest.days) {
        longest = trip;
      }
    }

    TripModel? mostRecent = trips.first;
    for (final trip in trips.skip(1)) {
      if (trip.startDate.isAfter(mostRecent!.startDate)) {
        mostRecent = trip;
      }
    }

    return StatsHighlights(
      averageDaysPerTrip: avg,
      longestTrip: longest,
      longestTripDays: longest?.days ?? 0,
      mostRecentTrip: mostRecent,
    );
  }

  static GoalProgress computeGoalProgress(
    GoalModel goal,
    List<TripModel> trips,
  ) {
    if (goal.type != GoalModel.typeCountriesPerYear) {
      return GoalProgress(goal: goal, currentValue: 0, progress: 0);
    }

    final year = goal.year;
    final relevantTrips = trips.where((trip) {
      final startYear = trip.startDate.year;
      final endYear = trip.endDate.year;
      return startYear <= year && endYear >= year;
    });

    final uniqueCountries = relevantTrips
        .map((trip) => trip.countryIsoCode.toUpperCase())
        .toSet();

    final currentValue = uniqueCountries.length;
    final progress = goal.targetValue <= 0
        ? 0.0
        : (currentValue / goal.targetValue).clamp(0.0, 1.0);

    return GoalProgress(
      goal: goal,
      currentValue: currentValue,
      progress: progress,
    );
  }

  /// Compute basic summary stats: totalCountries, totalDays, lastTripDate
  static Map<String, dynamic> computeSummary(List<TripModel> trips) {
    final days = computeDaysByCountry(trips);
    final totalCountries = days.keys.length;
    final totalDays = days.values.fold<int>(0, (p, e) => p + e);
    final lastTrip = trips.isNotEmpty ? trips.reduce((a, b) => a.startDate.isAfter(b.startDate) ? a : b).startDate : null;
    return {'totalCountries': totalCountries, 'totalDays': totalDays, 'lastTrip': lastTrip};
  }

  /// Aggregate high-level metrics across all trips.
  static GlobalStats computeGlobalStats(List<TripModel> trips) {
    final totalTrips = trips.length;
    final uniqueCountries = trips.map((t) => t.countryIsoCode.toUpperCase()).toSet();
    final totalTravelDays = trips.fold<int>(0, (sum, trip) => sum + trip.days);
    final travelDaysByYear = <int, int>{};

    for (final trip in trips) {
      _accumulateDaysByYear(trip, travelDaysByYear);
    }

    int? topYear;
    int? topYearDays;
    if (travelDaysByYear.isNotEmpty) {
      final ranked = travelDaysByYear.entries.toList()
        ..sort((a, b) {
          final cmp = b.value.compareTo(a.value);
          if (cmp != 0) return cmp;
          return a.key.compareTo(b.key);
        });
      topYear = ranked.first.key;
      topYearDays = ranked.first.value;
    }

    return GlobalStats(
      totalTrips: totalTrips,
      totalCountries: uniqueCountries.length,
      totalTravelDays: totalTravelDays,
      travelDaysByYear: travelDaysByYear,
      topYear: topYear,
      topYearDays: topYearDays,
    );
  }

  static void _accumulateDaysByYear(
    TripModel trip,
    Map<int, int> travelDaysByYear,
  ) {
    DateTime cursorStart = DateTime(trip.startDate.year, trip.startDate.month, trip.startDate.day);
    final DateTime tripEnd = DateTime(trip.endDate.year, trip.endDate.month, trip.endDate.day);

    while (!cursorStart.isAfter(tripEnd)) {
      final year = cursorStart.year;
      final yearEnd = DateTime(year, 12, 31);
      final DateTime segmentEnd = tripEnd.isBefore(yearEnd) ? tripEnd : yearEnd;
      final int segmentDays = segmentEnd.difference(cursorStart).inDays + 1;
      travelDaysByYear[year] = (travelDaysByYear[year] ?? 0) + segmentDays;
      cursorStart = DateTime(year + 1, 1, 1);
    }
  }
}

class StatsHighlights {
  final double averageDaysPerTrip;
  final TripModel? longestTrip;
  final int? longestTripDays;
  final TripModel? mostRecentTrip;

  const StatsHighlights({
    required this.averageDaysPerTrip,
    required this.longestTrip,
    required this.longestTripDays,
    required this.mostRecentTrip,
  });
}
