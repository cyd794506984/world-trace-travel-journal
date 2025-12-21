import '../models/step.dart';
import '../models/trip.dart';
import '../services/geo_service.dart';
import '../utils/flag_utils.dart';

class CountryOverviewData {
  final String isoCode;
  final String displayName;
  final int tripsCount;
  final int totalDays;
  final int stepsCount;
  final List<String> photoPaths;
  final int mediaCount;
  final bool hasTrips;
  final DateTime? lastVisitDate;

  const CountryOverviewData({
    required this.isoCode,
    required this.displayName,
    required this.tripsCount,
    required this.totalDays,
    required this.stepsCount,
    required this.photoPaths,
    required this.mediaCount,
    required this.hasTrips,
    required this.lastVisitDate,
  });

  bool get hasPhotos => photoPaths.isNotEmpty;
}

CountryOverviewData buildCountryOverviewData({
  required String isoCode,
  required List<TripModel> trips,
  required List<StepModel> steps,
  required Map<String, int> daysByCountry,
  required Map<String, CountryGeometry> geometries,
  int photoLimit = 10,
}) {
  final isoUpper = isoCode.toUpperCase();
  final countryTrips = trips
      .where((trip) => trip.countryIsoCode.toUpperCase() == isoUpper)
      .toList();

  final normalizedDays = <String, int>{
    for (final entry in daysByCountry.entries)
      entry.key.toUpperCase(): entry.value,
  };
  final totalDays = normalizedDays[isoUpper] ??
      countryTrips.fold<int>(0, (prev, trip) => prev + trip.days);

  final tripIdsWithSteps = countryTrips
      .where((trip) => trip.id != null)
      .map((trip) => trip.id!.toString())
      .toSet();
  final relevantSteps = steps
      .where((step) => tripIdsWithSteps.contains(step.tripId))
      .toList()
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  final photos = <String>[];
  int totalMediaCount = 0;
  for (final step in relevantSteps) {
    for (final path in step.mediaPaths) {
      if (path.isEmpty) continue;
      totalMediaCount++;
      photos.add(path);
      if (photos.length >= photoLimit) {
        break;
      }
    }
    if (photos.length >= photoLimit) {
      break;
    }
  }

  final stepsCount = relevantSteps.length;
  DateTime? lastVisitDate;
  if (relevantSteps.isNotEmpty) {
    lastVisitDate = relevantSteps.first.timestamp;
  } else if (countryTrips.isNotEmpty) {
    lastVisitDate = countryTrips
        .map((trip) => trip.endDate)
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

    final geometry = geometries[isoUpper];
    final displayName = (geometry != null && geometry.name.trim().isNotEmpty)
      ? geometry.name
      : isoCountryCodeToName(isoUpper);

  return CountryOverviewData(
    isoCode: isoUpper,
    displayName: displayName,
    tripsCount: countryTrips.length,
    totalDays: totalDays,
    stepsCount: stepsCount,
    photoPaths: photos,
    mediaCount: totalMediaCount,
    hasTrips: countryTrips.isNotEmpty,
    lastVisitDate: lastVisitDate,
  );
}
