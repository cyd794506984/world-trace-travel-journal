import '../models/on_this_day_memory.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../utils/flag_utils.dart';

class OnThisDayService {
  static List<OnThisDayMemory> computeMemories({
    required DateTime today,
    required List<TripModel> trips,
    required List<StepModel> steps,
  }) {
    if (trips.isEmpty || steps.isEmpty) {
      return const [];
    }

    final month = today.month;
    final day = today.day;

    final tripsById = <String, TripModel>{
      for (final trip in trips)
        if (trip.id != null) trip.id!.toString(): trip,
    };

    final seenKeys = <String>{};
    final memories = <OnThisDayMemory>[];

    for (final step in steps) {
      if (step.timestamp.month != month || step.timestamp.day != day) {
        continue;
      }

      final trip = tripsById[step.tripId];
      if (trip == null) {
        continue;
      }

      final year = step.timestamp.year;
      final dedupeKey = '${step.tripId}-$year';
      if (!seenKeys.add(dedupeKey)) {
        continue;
      }

      final memory = OnThisDayMemory(
        trip: trip,
        step: step,
        year: year,
        countryName: isoCountryCodeToName(trip.countryIsoCode),
        flagEmoji: isoCountryCodeToEmoji(trip.countryIsoCode),
        photoPath: step.mediaPaths.isNotEmpty ? step.mediaPaths.first : null,
      );
      memories.add(memory);
    }

    memories.sort((a, b) => b.year.compareTo(a.year));
    return memories;
  }
}
