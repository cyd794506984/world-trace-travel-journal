import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../models/trip.dart';
import '../repositories/goal_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/achievements_service.dart';
import '../services/auth_service.dart';
import '../services/plan_service.dart';
import '../services/stats_service.dart';
import 'achievements_screen.dart';
import 'goals_screen.dart';
import 'media_gallery_screen.dart';
import 'upgrade_screen.dart';
import 'year_in_review_screen.dart';

class TravelProfileScreen extends StatefulWidget {
  const TravelProfileScreen({super.key});

  @override
  State<TravelProfileScreen> createState() => _TravelProfileScreenState();
}

class _TravelProfileScreenState extends State<TravelProfileScreen> {
  Future<_ProfileSnapshot>? _profileFuture;
  String? _currentUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = context.read<AuthService>();
    final userId = auth.currentUser?.id;
    if (userId != _currentUserId) {
      _currentUserId = userId;
      if (userId != null) {
        setState(() {
          _profileFuture = _loadProfileData(userId);
        });
      }
    }
  }

  Future<_ProfileSnapshot> _loadProfileData(String userId) async {
    final tripRepo = context.read<TripRepository>();
    final goalRepo = context.read<GoalRepository>();

    final trips = await tripRepo.getTrips(userId);
    final goals = await goalRepo.getAllGoals(userId);
    final stats = StatsService.computeGlobalStats(trips);
    final goalProgress = goals
        .map((goal) => StatsService.computeGoalProgress(goal, trips))
        .toList();

    return _ProfileSnapshot(
      trips: trips,
      stats: stats,
      goalProgress: goalProgress,
    );
  }

  Future<void> _shareProfile(GlobalStats stats) async {
    final l10n = AppLocalizations.of(context)!;
    final text = _buildShareText(stats, l10n);
    await SharePlus.instance.share(ShareParams(text: text));
  }

  String _buildShareText(GlobalStats stats, AppLocalizations l10n) {
    if (!stats.hasTrips) {
      return l10n.profile_share_no_trips;
    }

    final buffer = StringBuffer()
      ..write(
        l10n.profile_share_stats(
          stats.totalTrips,
          stats.totalCountries,
          stats.totalTravelDays,
        ),
      );
    if (stats.topYear != null && stats.topYearDays != null) {
      buffer
        ..write(' ')
        ..write(l10n.profile_share_top_year(stats.topYear!, stats.topYearDays!));
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    final l10n = AppLocalizations.of(context)!;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.drawer_profile)),
        body: Center(child: Text(l10n.profile_sign_in_prompt)),
      );
    }

    final future = _profileFuture;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.drawer_profile)),
      body: future == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<_ProfileSnapshot>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(l10n.generic_error('${snapshot.error}')));
                }
                final data = snapshot.data;
                if (data == null) {
                  return Center(child: Text(l10n.profile_no_data));
                }

                final stats = data.stats;
                final goals = data.goalProgress;
                final topGoals = goals.take(3).toList();
                final achievements = AchievementsService.computeAchievements(data.trips, stats, l10n);
                final unlockedCount =
                  achievements.where((achievement) => achievement.unlocked).length;

                return RefreshIndicator(
                  onRefresh: () async {
                    if (_currentUserId != null) {
                      setState(() {
                        _profileFuture = _loadProfileData(_currentUserId!);
                      });
                    }
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(18),
                    children: [
                      _SummaryCard(stats: stats, l10n: l10n),
                      const SizedBox(height: 18),
                      _AchievementsSection(
                        unlockedCount: unlockedCount,
                        totalCount: achievements.length,
                        l10n: l10n,
                        onSeeAll: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AchievementsScreen(),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const YearInReviewScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.timeline),
                          label: Text(l10n.profile_view_year_button),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _GoalsSection(goals: topGoals, l10n: l10n, onSeeAll: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const GoalsScreen()),
                        );
                      }),
                      const SizedBox(height: 18),
                      _PlanSection(l10n: l10n, onUpgrade: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const UpgradeScreen()),
                        );
                      }),
                      const SizedBox(height: 18),
                      _GalleryShortcutCard(l10n: l10n),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => _shareProfile(stats),
                        icon: const Icon(Icons.share),
                        label: Text(l10n.profile_share_button),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _ProfileSnapshot {
  final List<TripModel> trips;
  final GlobalStats stats;
  final List<GoalProgress> goalProgress;

  _ProfileSnapshot({
    required this.trips,
    required this.stats,
    required this.goalProgress,
  });
}

class _SummaryCard extends StatelessWidget {
  final GlobalStats stats;
  final AppLocalizations l10n;
  const _SummaryCard({required this.stats, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.96),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.profile_travel_summary_title,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatPill(label: l10n.profile_stat_trips, value: stats.totalTrips.toString(), icon: Icons.public),
                _StatPill(label: l10n.profile_stat_countries, value: stats.totalCountries.toString(), icon: Icons.flag),
                _StatPill(label: l10n.profile_stat_days, value: stats.totalTravelDays.toString(), icon: Icons.calendar_month),
              ],
            ),
            const SizedBox(height: 16),
            if (stats.topYear != null && stats.topYearDays != null)
              Text(
                l10n.profile_top_year_text(stats.topYear!, stats.topYearDays!),
                style: theme.textTheme.bodyMedium,
              ),
            if (stats.topYear == null)
              Text(l10n.profile_top_year_empty, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _AchievementsSection extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;
  final AppLocalizations l10n;
  final VoidCallback onSeeAll;

  const _AchievementsSection({
    required this.unlockedCount,
    required this.totalCount,
    required this.l10n,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events_outlined, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  l10n.profile_achievements_title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(onPressed: onSeeAll, child: Text(l10n.profile_see_all)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.profile_achievements_progress(unlockedCount, totalCount),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: totalCount == 0 ? 0 : (unlockedCount / totalCount).clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalsSection extends StatelessWidget {
  final List<GoalProgress> goals;
  final AppLocalizations l10n;
  final VoidCallback onSeeAll;

  const _GoalsSection({required this.goals, required this.l10n, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasGoals = goals.isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(l10n.profile_goals_title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: onSeeAll, child: Text(l10n.profile_goals_manage)),
              ],
            ),
            if (!hasGoals) ...[
              const SizedBox(height: 8),
              Text(l10n.profile_goals_empty, style: theme.textTheme.bodyMedium),
            ] else ...[
              const SizedBox(height: 12),
              ...goals.map((progress) => _GoalMiniCard(progress: progress, l10n: l10n)),
            ],
          ],
        ),
      ),
    );
  }
}

class _GoalMiniCard extends StatelessWidget {
  final GoalProgress progress;
  final AppLocalizations l10n;
  const _GoalMiniCard({required this.progress, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final goal = progress.goal;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      l10n.profile_goal_progress_label(
                        goal.year,
                        progress.currentValue,
                        goal.targetValue,
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Text('${(progress.progress * 100).toStringAsFixed(0)}%', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: progress.progress,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  final VoidCallback onUpgrade;
  final AppLocalizations l10n;
  const _PlanSection({required this.onUpgrade, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final planService = PlanService.instance;
    return ValueListenableBuilder<PlanType>(
      valueListenable: planService.planTypeListenable,
      builder: (context, plan, _) {
        final isPro = plan == PlanType.pro;
        final description = isPro
            ? l10n.profile_plan_current_pro
            : l10n.profile_plan_current_free(planService.maxStepsPerTripForCurrentPlan());

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.profile_plan_section_title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 12),
                if (!isPro)
                  FilledButton(
                    onPressed: onUpgrade,
                    child: Text(l10n.plan_upgrade),
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.workspace_premium, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(l10n.plan_support_thanks),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GalleryShortcutCard extends StatelessWidget {
  final AppLocalizations l10n;

  const _GalleryShortcutCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
          child: Icon(Icons.photo_library_outlined, color: colorScheme.primary),
        ),
        title: Text(
          l10n.gallery_profile_cta,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MediaGalleryScreen()),
          );
        },
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatPill({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
