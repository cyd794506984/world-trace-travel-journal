import 'step.dart';
import 'trip.dart';

class OnThisDayMemory {
  final TripModel trip;
  final StepModel step;
  final int year;
  final String countryName;
  final String flagEmoji;
  final String? photoPath;

  const OnThisDayMemory({
    required this.trip,
    required this.step,
    required this.year,
    required this.countryName,
    required this.flagEmoji,
    required this.photoPath,
  });
}
