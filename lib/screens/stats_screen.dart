import 'package:flutter/material.dart';
import 'package:world_trace/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_trace/screens/auth_screen.dart';
import 'package:world_trace/screens/trips/trip_edit.dart';
import 'package:world_trace/widgets/glass_panel.dart';
import 'package:world_trace/widgets/stats_card.dart';

import '../models/trip.dart';
import '../repositories/trip_repository.dart';
import '../services/auth_service.dart';
import '../services/stats_service.dart';
import '../utils/flag_utils.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<TripRepository>(context, listen: false);
    final auth = Provider.of<AuthService>(context);
    final userId = auth.currentUser?.id;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.stats_title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: userId == null
            ? _buildSignedOutState(context, l10n)
            : FutureBuilder<List<TripModel>>(
                future: repo.getTrips(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(l10n.generic_error('${snapshot.error}')));
                  }

                  final trips = snapshot.data ?? <TripModel>[];
                  final stats = StatsService.computeGlobalStats(trips);
                  final highlights = StatsService.computeHighlights(trips);
                  final metricCards = _buildMetricCards(stats, l10n);

                  if (!stats.hasTrips) {
                    return _buildEmptyState(context, l10n);
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.stats_highlights_title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        _StatsGrid(cards: metricCards),
                        const SizedBox(height: 24),
                        _HighlightsSection(highlights: highlights, l10n: l10n),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  List<StatsCard> _buildMetricCards(GlobalStats stats, AppLocalizations l10n) {
    return [
      StatsCard(
        title: l10n.stats_metric_trips_logged,
        value: stats.totalTrips.toString(),
        icon: Icons.flight_takeoff,
      ),
      StatsCard(
        title: l10n.stat_countries_visited,
        value: stats.totalCountries.toString(),
        icon: Icons.public,
      ),
      StatsCard(
        title: l10n.stat_days_abroad,
        value: stats.totalTravelDays.toString(),
        icon: Icons.calendar_month,
      ),
      StatsCard(
        title: l10n.stats_metric_travel_heavy_year,
        value: stats.topYear == null || stats.topYearDays == null
            ? l10n.stats_value_not_available
            : l10n.stats_metric_travel_heavy_year_value(stats.topYear!, stats.topYearDays!),
        icon: Icons.bar_chart_rounded,
      ),
    ];
  }

  Widget _buildSignedOutState(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: GlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.insights_outlined, size: 48, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                l10n.stats_sign_in_prompt,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.home_sign_in_prompt,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                  );
                },
                child: Text(l10n.auth_login),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: GlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.explore_off, size: 48, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                l10n.stats_empty_message,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.no_trips_yet,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TripEditScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: Text(l10n.tooltip_add_trip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final List<StatsCard> cards;

  const _StatsGrid({required this.cards});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isWide = maxWidth >= 640;
        final cardWidth = isWide ? (maxWidth - 16) / 2 : maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: cards
              .map(
                (card) => SizedBox(
                  width: cardWidth,
                  child: card,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _HighlightsSection extends StatelessWidget {
  final StatsHighlights highlights;
  final AppLocalizations l10n;

  const _HighlightsSection({required this.highlights, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd(l10n.localeName);

    final items = <_HighlightRow>[];

    items.add(_HighlightRow(
      label: l10n.stats_highlight_average_days,
      value: highlights.averageDaysPerTrip.isNaN || highlights.averageDaysPerTrip == 0
          ? l10n.stats_value_not_available
          : highlights.averageDaysPerTrip.toStringAsFixed(1),
    ));

    if (highlights.longestTrip != null && (highlights.longestTripDays ?? 0) > 0) {
      final trip = highlights.longestTrip!;
      final destination = trip.title?.isNotEmpty == true
          ? trip.title!
          : isoCountryCodeToName(trip.countryIsoCode);
      items.add(_HighlightRow(
        label: l10n.stats_highlight_longest_trip,
        value: l10n.stats_highlight_longest_trip_value(
          highlights.longestTripDays!,
          destination,
        ),
      ));
    }

    if (highlights.mostRecentTrip != null) {
      final trip = highlights.mostRecentTrip!;
      final destination = trip.title?.isNotEmpty == true
          ? trip.title!
          : isoCountryCodeToName(trip.countryIsoCode);
      items.add(_HighlightRow(
        label: l10n.stats_highlight_recent_trip,
        value: l10n.stats_highlight_recent_trip_value(
          destination,
          dateFormat.format(trip.startDate),
        ),
      ));
    }

    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i != 0)
              Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
            items[i],
          ],
        ],
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final String label;
  final String value;

  const _HighlightRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}