import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../utils/country_overview_utils.dart';
import '../utils/flag_utils.dart';
import '../utils/photo_viewer_utils.dart';
import 'glass_panel.dart';

class CountryOverviewSheet extends StatelessWidget {
  final CountryOverviewData data;
  final VoidCallback onViewTrips;
  final VoidCallback? onAddTrip;

  const CountryOverviewSheet({
    super.key,
    required this.data,
    required this.onViewTrips,
    this.onAddTrip,
  });

  bool get _isNeverVisited => data.tripsCount == 0 && data.totalDays == 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final safeBottom = mediaQuery.padding.bottom;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          safeBottom + bottomInset + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            GlassPanel(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(data: data, l10n: l10n),
                  const SizedBox(height: 20),
                  _StatsGrid(data: data),
                  const SizedBox(height: 20),
                  _LastVisitedSection(data: data),
                  if (!data.hasTrips) ...[
                    const SizedBox(height: 12),
                    Text(
                      l10n.country_overview_empty_trips_message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  if (!_isNeverVisited) ...[
                    const SizedBox(height: 20),
                    _GallerySection(data: data),
                  ],
                  const SizedBox(height: 24),
                  _ActionButtons(
                    data: data,
                    onViewTrips: onViewTrips,
                    onAddTrip: onAddTrip,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      child: Text(l10n.country_overview_action_close),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final CountryOverviewData data;
  final AppLocalizations l10n;

  const _Header({required this.data, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final flag = isoCountryCodeToEmoji(data.isoCode);

    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          child: Text(
            flag,
            style: const TextStyle(fontSize: 26),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.displayName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.country_overview_subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.isoCode,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final CountryOverviewData data;

  const _StatsGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stats = [
      _StatEntry(
        icon: Icons.flight_takeoff,
        label: l10n.country_overview_label_trips,
        value: data.tripsCount.toString(),
      ),
      _StatEntry(
        icon: Icons.sunny_snowing,
        label: l10n.country_overview_label_days,
        value: data.totalDays.toString(),
      ),
      _StatEntry(
        icon: Icons.timeline,
        label: l10n.country_overview_label_steps,
        value: data.stepsCount.toString(),
      ),
      _StatEntry(
        icon: Icons.photo_library_outlined,
        label: l10n.country_overview_label_photos,
        value: data.mediaCount.toString(),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;
        final cardWidth = (maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: stats
              .map(
                (entry) => SizedBox(
                  width: cardWidth,
                  child: _StatCard(
                    icon: entry.icon,
                    label: entry.label,
                    value: entry.value,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _StatEntry {
  final IconData icon;
  final String label;
  final String value;

  const _StatEntry({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LastVisitedSection extends StatelessWidget {
  final CountryOverviewData data;

  const _LastVisitedSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final value = data.lastVisitDate != null
        ? DateFormat.yMMMMd(l10n.localeName).format(data.lastVisitDate!)
        : l10n.country_overview_last_visited_never;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.country_overview_label_last_visited,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final CountryOverviewData data;
  final VoidCallback onViewTrips;
  final VoidCallback? onAddTrip;

  const _ActionButtons({
    required this.data,
    required this.onViewTrips,
    required this.onAddTrip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final buttons = <Widget>[];

    if (data.hasTrips) {
      buttons.add(
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onViewTrips,
            child: Text(l10n.country_overview_action_view_trips),
          ),
        ),
      );
    }

    if (onAddTrip != null) {
      buttons.add(
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onAddTrip,
            child: Text(l10n.country_overview_action_add_trip),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < buttons.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          buttons[i],
        ],
      ],
    );
  }
}

class _GallerySection extends StatelessWidget {
  final CountryOverviewData data;

  const _GallerySection({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (data.mediaCount <= 0 || !data.hasPhotos) {
      return _PhotoNotice(
        title: l10n.country_sheet_no_photos_title,
        message: l10n.country_sheet_no_photos_message,
        icon: Icons.photo_library_outlined,
      );
    }

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final path = data.photoPaths[index];
          return _PhotoThumb(
            path: path,
            onTap: () => openPhotoViewer(context, data.photoPaths, index),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemCount: data.photoPaths.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  final String path;
  final VoidCallback onTap;

  const _PhotoThumb({required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(18);

    Widget buildPlaceholder() {
      return Container(
        width: 96,
        decoration: BoxDecoration(
          borderRadius: radius,
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.photo_outlined,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

    if (path.isEmpty || kIsWeb) {
      return buildPlaceholder();
    }

    final file = File(path);
    if (!file.existsSync()) {
      return buildPlaceholder();
    }

    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Ink(
        width: 96,
        decoration: BoxDecoration(borderRadius: radius),
        child: ClipRRect(
          borderRadius: radius,
          child: Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => buildPlaceholder(),
          ),
        ),
      ),
    );
  }
}

class _PhotoNotice extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const _PhotoNotice({
    required this.title,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
