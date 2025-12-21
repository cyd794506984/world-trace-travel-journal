import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/trip.dart';
import '../models/step.dart';
import '../repositories/step_repository.dart';
import '../repositories/trip_repository.dart';
import '../screens/step_detail_screen.dart';
import '../screens/step_edit_screen.dart';
import '../screens/trip_story_screen.dart';
import '../screens/upgrade_screen.dart';
import '../services/plan_service.dart';
import '../utils/flag_utils.dart';
import '../utils/photo_viewer_utils.dart';

class TripDetailScreen extends StatefulWidget {
  final TripModel trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  late Future<List<StepModel>> _stepsFuture;
  final MapController _mapController = MapController();
  LatLngBounds? _lastFitBounds;

  @override
  void initState() {
    super.initState();
    _refreshSteps();
  }

  void _refreshSteps() {
    if (!mounted) return;
    final repo = Provider.of<StepRepository>(context, listen: false);
    setState(() {
      _stepsFuture = repo.getStepsForTrip(widget.trip.id.toString());
    });
  }

  List<String> _buildTripMedia(List<StepModel> steps) {
    final sortedSteps = [...steps]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final media = <String>[];
    for (final step in sortedSteps) {
      if (step.mediaPaths.isEmpty) continue;
      for (final path in step.mediaPaths) {
        final trimmed = path.trim();
        if (trimmed.isEmpty) continue;
        media.add(trimmed);
      }
    }
    return media;
  }

  Future<void> _handleAddStepPressed(List<StepModel> currentSteps) async {
    final plan = PlanService.instance;
    final canAdd = plan.canAddStepForTrip(widget.trip, currentSteps.length);

    if (canAdd) {
      final changed = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => StepEditScreen(
            trip: widget.trip,
          ),
        ),
      );
      if (changed == true && mounted) {
        _refreshSteps();
      }
      return;
    }

    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final maxSteps = plan.maxStepsPerTripForCurrentPlan();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          maxSteps > 0
              ? l10n.plan_limit_steps_reached_message(maxSteps)
              : l10n.plan_limit_steps_reached_generic,
        ),
      ),
    );

    final upgraded = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const UpgradeScreen(),
      ),
    );

    if (upgraded == true && mounted) {
      _refreshSteps();
    }
  }

  Widget _buildTripHeader(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final trip = widget.trip;
    final locale = l10n.localeName;

    final startDate = DateFormat.yMMMMd(locale).format(trip.startDate.toLocal());
    final endDate = DateFormat.yMMMMd(locale).format(trip.endDate.toLocal());
    final dateRangeText = '$startDate - $endDate';

    final int days = trip.days;
    final countryName = isoCountryCodeToName(trip.countryIsoCode);
    final countryFlag = isoCountryCodeToEmoji(trip.countryIsoCode);
    final notes = trip.notes?.trim();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.colorScheme.surface.withValues(alpha: 0.6),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateRangeText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (countryFlag.isNotEmpty)
                Text(
                  countryFlag,
                  style: const TextStyle(fontSize: 20),
                ),
              if (countryFlag.isNotEmpty) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  countryName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (days > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    l10n.trip_detail_days_chip(days),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (notes != null && notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              notes,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepTimeline(List<StepModel> steps, AppLocalizations l10n) {
    final theme = Theme.of(context);

    if (steps.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: Text(
          l10n.trip_detail_empty_steps_message,
        ),
      );
    }

    final sortedSteps = [...steps]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final stepsByDay = <DateTime, List<StepModel>>{};
    for (final step in sortedSteps) {
      final ts = step.timestamp;
      final dayKey = DateTime(ts.year, ts.month, ts.day);
      stepsByDay.putIfAbsent(dayKey, () => []).add(step);
    }

    final dayKeys = stepsByDay.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    final children = <Widget>[];
    for (final day in dayKeys) {
      final daySteps = stepsByDay[day]!;
      final headerDate = DateFormat.yMMMMEEEEd(l10n.localeName).format(day);
      final stepCountText = l10n.trip_detail_day_header_steps(daySteps.length);

      children.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  headerDate,
                  style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                stepCountText,
                style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      );

      for (final step in daySteps) {
        children.add(_buildStepCard(context, step, l10n));
        children.add(const Divider(height: 1));
      }
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 28),
      children: children,
    );
  }

  Widget? _buildTripGallery(List<StepModel> steps, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final tripMedia = _buildTripMedia(steps);
    final crossAxisCount = MediaQuery.of(context).size.width > 900 ? 4 : 3;

    if (tripMedia.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trip_detail_section_photos_trip,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              l10n.gallery_empty_message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.trip_detail_section_photos_trip,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 4 / 3,
          ),
          itemCount: tripMedia.length,
          itemBuilder: (context, index) {
            final path = tripMedia[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildGalleryImage(path),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => openPhotoViewer(
                        context,
                        tripMedia,
                        index,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget? _buildStepsMap(List<StepModel> steps) {
    final geoSteps = steps
        .where((step) => step.latitude != null && step.longitude != null)
        .toList();

    if (geoSteps.isEmpty) return null;

    final theme = Theme.of(context);

    final markers = geoSteps.map((step) {
      final point = LatLng(step.latitude!, step.longitude!);
      return Marker(
        point: point,
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.place, color: Colors.white, size: 20),
        ),
      );
    }).toList();

    final bounds = LatLngBounds.fromPoints(
      markers.map((marker) => marker.point).toList(),
    );
    _fitMapToBounds(bounds);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 250,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: bounds.center,
            initialZoom: geoSteps.length == 1 ? 10 : 4,
            minZoom: 2,
            maxZoom: 16,
            backgroundColor: theme.colorScheme.surface,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.drag |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://server.arcgisonline.com/ArcGIS/rest/services/'
                  'World_Street_Map/MapServer/tile/{z}/{y}/{x}',
              userAgentPackageName: 'com.example.world_trace',
              maxZoom: 19,
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  void _fitMapToBounds(LatLngBounds bounds) {
    if (!_hasBoundsChanged(bounds)) return;

    _lastFitBounds = bounds;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(36),
        ),
      );
    });
  }

  bool _hasBoundsChanged(LatLngBounds newBounds) {
    if (_lastFitBounds == null) return true;
    final last = _lastFitBounds!;
    return last.northEast.latitude != newBounds.northEast.latitude ||
        last.northEast.longitude != newBounds.northEast.longitude ||
        last.southWest.latitude != newBounds.southWest.latitude ||
        last.southWest.longitude != newBounds.southWest.longitude;
  }

  Future<void> _openStepDetail(StepModel step) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StepDetailScreen(
          trip: widget.trip,
          step: step,
        ),
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context,
    StepModel step,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final timeStr = DateFormat('HH:mm').format(step.timestamp);
    final placeName = step.placeName?.trim();
    final flag = isoCountryCodeToEmoji(widget.trip.countryIsoCode);

    final placeWithFlag = placeName != null && placeName.isNotEmpty
        ? '$placeName${flag.isNotEmpty ? ' $flag' : ''}'
        : null;

    final titleText =
        placeWithFlag != null ? '$timeStr - $placeWithFlag' : timeStr;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openStepDetail(step),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.radio_button_checked,
                    size: 18, color: colorScheme.primary),
                const SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 24,
                  color: colorScheme.primary.withValues(alpha: 0.25),
                ),
              ],
            ),
            title: Text(
              titleText,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.text,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (step.mediaPaths.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildMediaRow(step),
                ],
              ],
            ),
            trailing: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
              onSelected: (value) {
                if (value == 'edit') {
                  _editStep(step);
                } else if (value == 'delete') {
                  _deleteStep(step);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'edit', child: Text(l10n.step_menu_edit)),
                PopupMenuItem(value: 'delete', child: Text(l10n.step_menu_delete)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaRow(StepModel step) {
    final paths = step.mediaPaths;
    if (paths.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: paths.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final path = paths[index];
          return GestureDetector(
            onTap: () => openPhotoViewer(context, paths, index),
            child: _buildThumbnail(path),
          );
        },
      ),
    );
  }

  Widget _buildThumbnail(String path) {
    final placeholder = Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image_not_supported, size: 24),
    );

    if (kIsWeb) {
      // Su web non abbiamo File locale: mostra solo placeholder
      return placeholder;
    }

    try {
      final file = File(path);
      if (!file.existsSync()) return placeholder;

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          file,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => placeholder,
        ),
      );
    } catch (_) {
      return placeholder;
    }
  }

  Widget _buildGalleryImage(String path) {
    final placeholder = Container(
      color: Colors.grey.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: const Icon(Icons.photo, size: 28),
    );

    if (kIsWeb) {
      return placeholder;
    }

    try {
      final file = File(path);
      if (!file.existsSync()) return placeholder;

      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => placeholder,
      );
    } catch (_) {
      return placeholder;
    }
  }

  Future<void> _editStep(StepModel step) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => StepEditScreen(
          trip: widget.trip,
          existingStep: step,
        ),
      ),
    );
    if (changed == true && mounted) {
      _refreshSteps();
    }
  }

  Future<void> _deleteStep(StepModel step) async {
    final repo = Provider.of<StepRepository>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          title: Text(l10n.step_delete_confirm_title),
          content: Text(
            l10n.step_delete_confirm_body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.btn_cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.btn_delete),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await repo.deleteStep(step.id);
    if (!mounted) return;
    _refreshSteps();
  }

  Future<void> _confirmDeleteTrip() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final deletedMsg = l10n.trip_deleted;
    final tripId = widget.trip.id;
    if (tripId == null) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.trip_delete_missing_id_error)),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          title: Text(l10n.trip_delete_confirm_title),
          content: Text(
            l10n.trip_delete_confirm_body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.btn_cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.btn_delete),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    if (!mounted) return;
    final repo = Provider.of<TripRepository>(context, listen: false);
    await repo.deleteTripWithSteps(tripId.toString());
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text(deletedMsg)),
    );
    navigator.pop(true);
  }

  Future<void> _openTripStory() async {
    final repo = Provider.of<StepRepository>(context, listen: false);
    try {
      final steps = await repo.getStepsForTrip(widget.trip.id.toString());
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TripStoryScreen(
            trip: widget.trip,
            steps: steps,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.trip_story_open_failed('$error')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final fallbackTitle = widget.trip.title ?? isoCountryCodeToName(widget.trip.countryIsoCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(fallbackTitle),
        actions: [
          IconButton(
            tooltip: l10n.trip_story_title,
            icon: const Icon(Icons.auto_stories_outlined),
            onPressed: _openTripStory,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'deleteTrip') {
                _confirmDeleteTrip();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'deleteTrip',
                child: Text(l10n.trip_menu_delete),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTripHeader(context, l10n),
              Expanded(
                child: FutureBuilder<List<StepModel>>(
                  future: _stepsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(l10n.generic_error('${snapshot.error}')),
                      );
                    }

                    final steps = snapshot.data ?? [];
                    final mapSection = _buildStepsMap(steps);
                    final gallerySection = _buildTripGallery(steps, l10n);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (mapSection != null) ...[
                          mapSection,
                          const SizedBox(height: 24),
                        ],
                        if (gallerySection != null) ...[
                          gallerySection,
                          const SizedBox(height: 24),
                        ],
                        Text(
                          l10n.trip_detail_section_timeline,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: _buildStepTimeline(steps, l10n),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FutureBuilder<List<StepModel>>(
        future: _stepsFuture,
        builder: (context, snapshot) {
          final steps = snapshot.data ?? [];
          final plan = PlanService.instance;
          final canAdd = plan.canAddStepForTrip(widget.trip, steps.length);

          return FloatingActionButton(
            onPressed: () => _handleAddStepPressed(steps),
            tooltip: canAdd
                ? l10n.fab_add_step_tooltip
                : l10n.fab_add_step_upgrade_tooltip,
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: const StadiumBorder(),
            child: const Icon(Icons.add, size: 30),
          );
        },
      ),
    );
  }
}

