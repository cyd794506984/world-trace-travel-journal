import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/achievement.dart';
import '../models/trip.dart';
import '../repositories/trip_repository.dart';
import '../services/achievements_service.dart';
import '../services/auth_service.dart';
import '../services/stats_service.dart';
import '../widgets/glass_panel.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Future<_AchievementsPayload?>? _future;
  String? _userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = Provider.of<AuthService>(context);
    final newUserId = auth.currentUser?.id;
    if (newUserId != _userId) {
      _userId = newUserId;
      final l10n = AppLocalizations.of(context)!;
      _future = _loadAchievements(newUserId, l10n);
    }
  }

  Future<_AchievementsPayload?> _loadAchievements(
    String? userId,
    AppLocalizations l10n,
  ) async {
    if (userId == null) return null;
    final repo = context.read<TripRepository>();
    final trips = await repo.getTrips(userId);
    final stats = StatsService.computeGlobalStats(trips);
    final achievements = AchievementsService.computeAchievements(trips, stats, l10n);
    return _AchievementsPayload(trips: trips, stats: stats, achievements: achievements);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.drawer_achievements)),
      body: _future == null
          ? _CenteredMessage(message: l10n.achievements_sign_in_prompt)
          : FutureBuilder<_AchievementsPayload?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _CenteredMessage(message: l10n.generic_error('${snapshot.error}'));
                }
                final payload = snapshot.data;
                if (payload == null) {
                  return _CenteredMessage(message: l10n.achievements_sign_in_prompt);
                }
                final sorted = payload.achievements.toList()
                  ..sort((a, b) {
                    if (a.unlocked == b.unlocked) {
                      return a.title.compareTo(b.title);
                    }
                    return a.unlocked ? -1 : 1;
                  });

                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: sorted.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final achievement = sorted[index];
                    return _AchievementTile(achievement: achievement);
                  },
                );
              },
            ),
    );
  }
}

class _AchievementsPayload {
  final List<TripModel> trips;
  final GlobalStats stats;
  final List<Achievement> achievements;

  _AchievementsPayload({
    required this.trips,
    required this.stats,
    required this.achievements,
  });
}

class _AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const _AchievementTile({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final unlocked = achievement.unlocked;
    final icon = _iconForAchievement(achievement.id);

    final content = GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked
                  ? colorScheme.primary.withValues(alpha: 0.18)
                  : colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
            ),
            child: Icon(
              icon,
              color: unlocked ? colorScheme.primary : colorScheme.onSurfaceVariant,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: unlocked
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  achievement.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: unlocked
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            unlocked ? Icons.check_circle : Icons.lock_outline,
            color: unlocked ? colorScheme.primary : colorScheme.outline,
          ),
        ],
      ),
    );

    return AnimatedOpacity(
      opacity: unlocked ? 1.0 : 0.55,
      duration: const Duration(milliseconds: 250),
      child: content,
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final String message;
  const _CenteredMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

IconData _iconForAchievement(String id) {
  switch (id) {
    case 'first_trip':
      return Icons.rocket_launch_outlined;
    case 'five_trips':
      return Icons.flight_takeoff;
    case 'ten_trips':
      return Icons.public;
    case 'five_countries':
      return Icons.flag_circle_outlined;
    case 'ten_countries':
      return Icons.travel_explore;
    case 'thirty_days_one_year':
      return Icons.calendar_month;
    case 'hundred_days_total':
      return Icons.av_timer;
    default:
      return Icons.star_outline;
  }
}
