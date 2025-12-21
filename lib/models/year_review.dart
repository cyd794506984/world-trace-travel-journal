import 'achievement.dart';
import 'step.dart';
import 'trip.dart';

class YearReview {
  final int year;
  final int tripsCount;
  final int countriesCount;
  final int totalDays;
  final TripModel? longestTrip;
  final int longestTripDays;
  final String? topCountryIso;
  final int topCountryDays;
  final List<Achievement> achievements;
  final List<StepModel> highlightSteps;

  const YearReview({
    required this.year,
    required this.tripsCount,
    required this.countriesCount,
    required this.totalDays,
    required this.longestTrip,
    required this.longestTripDays,
    required this.topCountryIso,
    required this.topCountryDays,
    required this.achievements,
    required this.highlightSteps,
  });
}
