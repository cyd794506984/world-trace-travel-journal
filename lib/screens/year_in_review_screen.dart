import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../models/achievement.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../models/year_review.dart';
import '../repositories/step_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/achievements_service.dart';
import '../services/auth_service.dart';
import '../services/stats_service.dart';
import '../services/year_review_service.dart';
import '../utils/country_coords.dart';
import '../utils/flag_utils.dart';
import '../utils/photo_viewer_utils.dart';
import '../widgets/glass_panel.dart';

class YearInReviewScreen extends StatefulWidget {
  const YearInReviewScreen({super.key});

  @override
  State<YearInReviewScreen> createState() => _YearInReviewScreenState();
}

class _YearInReviewScreenState extends State<YearInReviewScreen> {
  Future<_YearReviewPayload?>? _future;
  String? _userId;
  int? _selectedYear;
  final GlobalKey _storyKey = GlobalKey();
  bool _isSharing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = context.read<AuthService>();
    final newUserId = auth.currentUser?.id;
    if (newUserId != _userId) {
      _userId = newUserId;
      final l10n = AppLocalizations.of(context)!;
      _future = _loadData(newUserId, l10n);
    }
  }

  Future<_YearReviewPayload?> _loadData(
    String? userId,
    AppLocalizations l10n,
  ) async {
    if (userId == null) return null;
    final tripRepo = context.read<TripRepository>();
    final stepRepo = context.read<StepRepository>();

    final trips = await tripRepo.getTrips(userId);
    if (trips.isEmpty) {
      return const _YearReviewPayload(
        years: [],
        reviews: {},
        trips: [],
        steps: [],
      );
    }

    final stats = StatsService.computeGlobalStats(trips);
    final achievements = AchievementsService.computeAchievements(trips, stats, l10n);
    final tripIds = trips
        .where((trip) => trip.id != null)
        .map((trip) => trip.id!.toString())
        .toList();
    final steps = await stepRepo.getStepsForTrips(tripIds);

    final years = <int>{};
    for (final trip in trips) {
      final startYear = trip.startDate.year;
      final endYear = trip.endDate.year;
      for (var year = startYear; year <= endYear; year++) {
        years.add(year);
      }
    }
    if (years.isEmpty) {
      years.add(DateTime.now().year);
    }
    final sortedYears = years.toList()..sort();
    final reviews = <int, YearReview>{};
    for (final year in sortedYears) {
      reviews[year] = YearReviewService.computeYearReview(
        year: year,
        trips: trips,
        allSteps: steps,
        allAchievements: achievements,
      );
    }

    _selectedYear ??= sortedYears.last;

    return _YearReviewPayload(
      years: sortedYears,
      reviews: reviews,
      trips: trips,
      steps: steps,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.year_in_review_title),
        actions: [
          IconButton(
            icon: _isSharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.share),
            onPressed: _isSharing ? null : _shareYearStory,
            tooltip: l10n.year_in_review_share_tooltip,
          ),
        ],
      ),
      body: _future == null
          ? _CenteredMessage(l10n.year_in_review_sign_in_prompt)
          : FutureBuilder<_YearReviewPayload?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _CenteredMessage(l10n.generic_error('${snapshot.error}'));
                }
                final payload = snapshot.data;
                if (payload == null || payload.years.isEmpty) {
                  return _CenteredMessage(l10n.year_in_review_no_trips);
                }

                final year = _selectedYear ?? payload.years.last;
                final review = payload.reviews[year];
                if (review == null) {
                  return _CenteredMessage(l10n.year_in_review_no_data_for_year);
                }

                final mapPoints = _computeYearMapPoints(
                  year,
                  payload.trips,
                  payload.steps,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: payload.years
                            .map(
                              (yr) => ChoiceChip(
                                label: Text(yr.toString()),
                                selected: yr == year,
                                onSelected: (_) {
                                  setState(() {
                                    _selectedYear = yr;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      _YearMap(points: mapPoints, year: year, l10n: l10n),
                      const SizedBox(height: 16),
                      RepaintBoundary(
                        key: _storyKey,
                        child: GlassPanel(
                          padding: const EdgeInsets.all(20),
                          child: _YearStoryContent(review: review, l10n: l10n),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _AchievementsList(achievements: review.achievements, l10n: l10n),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> _shareYearStory() async {
    final l10n = AppLocalizations.of(context)!;
    final boundary = _storyKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      _showSnackBar(l10n.year_in_review_render_error);
      return;
    }
    try {
      setState(() => _isSharing = true);
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        _showSnackBar(l10n.year_in_review_encode_error);
        return;
      }
      final bytes = byteData.buffer.asUint8List();
      final year = _selectedYear ?? DateTime.now().year;
      final text = l10n.year_in_review_share_message(year);

      if (kIsWeb) {
        final xFile = XFile.fromData(bytes, mimeType: 'image/png', name: 'year_in_review.png');
        await SharePlus.instance.share(
          ShareParams(
            files: [xFile],
            text: text,
          ),
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = await File('${dir.path}/year_in_review_$year.png').create(recursive: true);
        await file.writeAsBytes(bytes);
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path)],
            text: text,
          ),
        );
      }
    } catch (error) {
      _showSnackBar(l10n.year_in_review_share_failed('$error'));
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _YearReviewPayload {
  final List<int> years;
  final Map<int, YearReview> reviews;
  final List<TripModel> trips;
  final List<StepModel> steps;

  const _YearReviewPayload({
    required this.years,
    required this.reviews,
    required this.trips,
    required this.steps,
  });
}

class _YearStoryContent extends StatelessWidget {
  final YearReview review;
  final AppLocalizations l10n;

  const _YearStoryContent({required this.review, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final longestTripTitle = _tripDisplayName(review.longestTrip);
    final topCountryName = review.topCountryIso == null
        ? '-'
        : isoCountryCodeToName(review.topCountryIso!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.year_in_review_story_title(review.year),
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.year_in_review_story_summary(
            review.totalDays,
            review.tripsCount,
            review.countriesCount,
          ),
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 18),
        _MetricRow(
          icon: Icons.route,
          label: l10n.year_in_review_longest_trip,
          value: review.longestTrip == null
              ? '-'
              : l10n.year_in_review_longest_trip_value(longestTripTitle, review.longestTripDays),
        ),
        const SizedBox(height: 10),
        _MetricRow(
          icon: Icons.flag,
          label: l10n.year_in_review_top_country,
          value: review.topCountryIso == null
              ? '-'
              : l10n.year_in_review_top_country_value(topCountryName, review.topCountryDays),
        ),
        const SizedBox(height: 18),
        _PhotosMosaic(steps: review.highlightSteps, l10n: l10n),
        const SizedBox(height: 18),
        _AchievementsBadges(achievements: review.achievements, l10n: l10n),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            l10n.app_title,
            style: theme.textTheme.labelLarge?.copyWith(
              letterSpacing: 1.4,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  String _tripDisplayName(TripModel? trip) {
    if (trip == null) return '-';
    final title = trip.title?.trim();
    if (title != null && title.isNotEmpty) return title;
    return isoCountryCodeToName(trip.countryIsoCode);
  }
}

class YearMapPoint {
  final String countryIso;
  final LatLng position;
  final DateTime firstVisit;

  const YearMapPoint({
    required this.countryIso,
    required this.position,
    required this.firstVisit,
  });
}

List<YearMapPoint> _computeYearMapPoints(
  int year,
  List<TripModel> trips,
  List<StepModel> steps,
) {
  if (trips.isEmpty) return const [];

  final stepsByTrip = <String, List<StepModel>>{};
  for (final step in steps) {
    stepsByTrip.putIfAbsent(step.tripId, () => []).add(step);
  }

  final yearStart = DateTime(year, 1, 1);
  final yearEnd = DateTime(year, 12, 31);
  final Map<String, YearMapPoint> points = {};

  for (final trip in trips) {
    if (!_tripIntersectsYearLocal(trip, year)) continue;
    final clampedStart = trip.startDate.isAfter(yearStart) ? trip.startDate : yearStart;
    final clampedEnd = trip.endDate.isBefore(yearEnd) ? trip.endDate : yearEnd;
    if (clampedEnd.isBefore(clampedStart)) continue;

    LatLng? position;
    final tripId = trip.id?.toString();
    if (tripId != null) {
      final tripSteps = stepsByTrip[tripId];
      if (tripSteps != null) {
        StepModel? geoStep;
        for (final step in tripSteps) {
          if (step.timestamp.year != year) continue;
          if (step.latitude != null && step.longitude != null) {
            geoStep = step;
            break;
          }
        }
        if (geoStep != null) {
          position = LatLng(geoStep.latitude!, geoStep.longitude!);
        }
      }
    }

    position ??= centroidForCountry(trip.countryIsoCode);
    if (position == null) continue;

    final iso = trip.countryIsoCode.toUpperCase();
    final existing = points[iso];
    if (existing == null || clampedStart.isBefore(existing.firstVisit)) {
      points[iso] = YearMapPoint(
        countryIso: iso,
        position: position,
        firstVisit: clampedStart,
      );
    }
  }

  final ordered = points.values.toList()
    ..sort((a, b) => a.firstVisit.compareTo(b.firstVisit));
  return ordered;
}

bool _tripIntersectsYearLocal(TripModel trip, int year) {
  final startYear = trip.startDate.year;
  final endYear = trip.endDate.year;
  return startYear <= year && endYear >= year;
}

class _YearMap extends StatelessWidget {
  final List<YearMapPoint> points;
  final int year;
  final AppLocalizations l10n;

  const _YearMap({required this.points, required this.year, required this.l10n});

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bounds = LatLngBounds.fromPoints(points.map((p) => p.position).toList());
    final cameraFit = CameraFit.bounds(
      bounds: bounds,
      padding: const EdgeInsets.all(32),
    );

    final markers = points.map((point) {
      final flag = isoCountryCodeToEmoji(point.countryIso);
      return Marker(
        point: point.position,
        width: 32,
        height: 32,
        alignment: Alignment.center,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            flag.isNotEmpty ? flag : point.countryIso,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    }).toList();

    Polyline? polyline;
    if (points.length >= 2) {
      polyline = Polyline(
        points: points.map((p) => p.position).toList(),
        strokeWidth: 3,
        color: colorScheme.secondary.withValues(alpha: 0.9),
      );
    }

    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.year_in_review_map_title(year),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              height: 250,
              child: FlutterMap(
                options: MapOptions(
                  initialCameraFit: cameraFit,
                  minZoom: 1.5,
                  maxZoom: 8,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                    userAgentPackageName: 'com.example.world_trace',
                    maxZoom: 19,
                  ),
                  if (polyline != null)
                    PolylineLayer(polylines: [polyline]),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: colorScheme.primary.withValues(alpha: 0.14),
          child: Icon(icon, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.labelMedium),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoEntry {
  final StepModel step;
  final String path;
  final int index;
  final int totalMedia;

  const _PhotoEntry({
    required this.step,
    required this.path,
    required this.index,
    required this.totalMedia,
  });
}

class _PhotosMosaic extends StatelessWidget {
  final List<StepModel> steps;
  final AppLocalizations l10n;

  const _PhotosMosaic({required this.steps, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final entries = <_PhotoEntry>[];
    for (final step in steps) {
      if (step.mediaPaths.isEmpty) continue;
      entries.add(
        _PhotoEntry(
          step: step,
          path: step.mediaPaths.first,
          index: 0,
          totalMedia: step.mediaPaths.length,
        ),
      );
    }

    if (entries.isEmpty) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withValues(alpha: 0.06),
        ),
        child: Center(
          child: Text(l10n.year_in_review_no_photo_highlights),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 4 / 3,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _PhotoTile(path: entry.path),
              if (entry.totalMedia > 1)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: _PhotoOverlay(count: entry.totalMedia),
                ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => openPhotoViewer(
                    context,
                    entry.step.mediaPaths,
                    entry.index,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final String path;

  const _PhotoTile({required this.path});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _placeholder();
    }
    try {
      final file = File(path);
      if (!file.existsSync()) return _placeholder();
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    } catch (_) {
      return _placeholder();
    }
  }

  Widget _placeholder() {
    return Container(
      color: Colors.white.withValues(alpha: 0.08),
      child: const Icon(Icons.photo, color: Colors.white54),
    );
  }
}

class _PhotoOverlay extends StatelessWidget {
  final int count;

  const _PhotoOverlay({required this.count});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.collections, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              '+${count - 1}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementsBadges extends StatelessWidget {
  final List<Achievement> achievements;
  final AppLocalizations l10n;

  const _AchievementsBadges({required this.achievements, required this.l10n});

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return Text(l10n.year_in_review_no_achievements);
    }
    final unlocked = achievements.where((a) => a.unlocked).toList();
    if (unlocked.isEmpty) {
      return Text(l10n.year_in_review_no_achievements);
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: unlocked
          .map(
            (achievement) => Chip(
              avatar: const Icon(Icons.emoji_events, size: 18),
              label: Text(achievement.title),
            ),
          )
          .toList(),
    );
  }
}

class _AchievementsList extends StatelessWidget {
  final List<Achievement> achievements;
  final AppLocalizations l10n;

  const _AchievementsList({required this.achievements, required this.l10n});

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.year_in_review_unlocked_achievements,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...achievements.where((a) => a.unlocked).map(
              (achievement) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.emoji_events_outlined),
                title: Text(achievement.title),
                subtitle: Text(achievement.description),
              ),
            ),
      ],
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final String message;

  const _CenteredMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
