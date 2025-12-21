import '../l10n/app_localizations.dart';
import '../models/achievement.dart';
import '../models/trip.dart';
import 'stats_service.dart';

class AchievementsService {
  static List<Achievement> computeAchievements(
    List<TripModel> trips,
    GlobalStats stats,
    AppLocalizations l10n,
  ) {
    final hasYearWithThirtyDays = stats.travelDaysByYear.values.any((days) => days >= 30);

    final definitions = <_AchievementDefinition>[
      _AchievementDefinition(
        id: 'first_trip',
        title: l10n.achievement_first_trip_title,
        description: l10n.achievement_first_trip_description,
        unlocked: stats.totalTrips >= 1,
      ),
      _AchievementDefinition(
        id: 'five_trips',
        title: l10n.achievement_five_trips_title,
        description: l10n.achievement_five_trips_description,
        unlocked: stats.totalTrips >= 5,
      ),
      _AchievementDefinition(
        id: 'ten_trips',
        title: l10n.achievement_ten_trips_title,
        description: l10n.achievement_ten_trips_description,
        unlocked: stats.totalTrips >= 10,
      ),
      _AchievementDefinition(
        id: 'five_countries',
        title: l10n.achievement_five_countries_title,
        description: l10n.achievement_five_countries_description,
        unlocked: stats.totalCountries >= 5,
      ),
      _AchievementDefinition(
        id: 'ten_countries',
        title: l10n.achievement_ten_countries_title,
        description: l10n.achievement_ten_countries_description,
        unlocked: stats.totalCountries >= 10,
      ),
      _AchievementDefinition(
        id: 'thirty_days_one_year',
        title: l10n.achievement_thirty_days_title,
        description: l10n.achievement_thirty_days_description,
        unlocked: hasYearWithThirtyDays,
      ),
      _AchievementDefinition(
        id: 'hundred_days_total',
        title: l10n.achievement_hundred_days_title,
        description: l10n.achievement_hundred_days_description,
        unlocked: stats.totalTravelDays >= 100,
      ),
    ];

    return definitions
        .map(
          (def) => Achievement(
            id: def.id,
            title: def.title,
            description: def.description,
            unlocked: def.unlocked,
          ),
        )
        .toList(growable: false);
  }
}

class _AchievementDefinition {
  final String id;
  final String title;
  final String description;
  final bool unlocked;

  const _AchievementDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.unlocked,
  });
}
