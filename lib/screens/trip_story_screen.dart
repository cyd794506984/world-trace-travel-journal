import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../utils/flag_utils.dart';
import '../utils/photo_viewer_utils.dart';

class TripStoryScreen extends StatefulWidget {
  final TripModel trip;
  final List<StepModel> steps;

  const TripStoryScreen({
    super.key,
    required this.trip,
    required this.steps,
  });

  @override
  State<TripStoryScreen> createState() => _TripStoryScreenState();
}

class _TripStoryScreenState extends State<TripStoryScreen> {
  final GlobalKey _storyKey = GlobalKey();
  bool _isSharing = false;

  List<StepModel> get _geoSteps => widget.steps
      .where((step) => step.latitude != null && step.longitude != null)
      .toList();

  List<String> get _photoPaths => widget.steps
      .expand((step) => step.mediaPaths)
      .where((path) => path.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final widthSuggestion = size.width <= 380 ? size.width - 32 : 360.0;
    final storyWidth = widthSuggestion.clamp(280.0, 420.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trip_story_title),
        actions: [
          IconButton(
            tooltip: l10n.trip_story_share_tooltip,
            onPressed: _isSharing ? null : _shareStoryCard,
            icon: _isSharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Center(
            child: RepaintBoundary(
              key: _storyKey,
              child: Container(
                width: storyWidth.toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.92),
                      Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.35),
                      blurRadius: 24,
                      spreadRadius: 6,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: _buildStoryContent(context, l10n),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoryContent(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final hasGeoSteps = _geoSteps.isNotEmpty;
    final mapSection = hasGeoSteps ? _buildMapSection(theme) : null;

    final children = <Widget>[
      _buildHeader(theme),
      const SizedBox(height: 16),
      _buildTitle(theme),
    ];

    if (mapSection != null) {
      children.addAll([
        const SizedBox(height: 16),
        mapSection,
      ]);
    }

    children.addAll([
      const SizedBox(height: 16),
      _buildPhotosStrip(),
      const SizedBox(height: 16),
      _buildStatsRow(theme, l10n),
      const SizedBox(height: 16),
      Align(
        alignment: Alignment.bottomRight,
        child: Text(
          l10n.app_title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ]);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final trip = widget.trip;
    final flag = isoCountryCodeToEmoji(trip.countryIsoCode);
    final countryName = isoCountryCodeToName(trip.countryIsoCode);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final formatter = DateFormat.yMMMd(localeName);
    final dateRange =
        '${formatter.format(trip.startDate)} - ${formatter.format(trip.endDate)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 42),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateRange,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(ThemeData theme) {
    final title = widget.trip.title?.trim();
    final fallback = isoCountryCodeToName(widget.trip.countryIsoCode);
    return Text(
      title == null || title.isEmpty ? fallback : title,
      style: theme.textTheme.headlineMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        height: 1.1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMapSection(ThemeData theme) {
    final geoSteps = _geoSteps;
    if (geoSteps.isEmpty) {
      return const SizedBox.shrink();
    }

    final markers = geoSteps.map((step) {
      final point = LatLng(step.latitude!, step.longitude!);
      return Marker(
        point: point,
        width: 48,
        height: 48,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.place,
            color: theme.colorScheme.primary,
            size: 26,
          ),
        ),
      );
    }).toList();

    final bounds = LatLngBounds.fromPoints(
      markers.map((marker) => marker.point).toList(),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: bounds.center,
            initialZoom: geoSteps.length == 1 ? 8 : 4,
            minZoom: 2,
            maxZoom: 16,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.worldtrace.app',
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotosStrip() {
    final photos = _photoPaths;
    if (photos.isEmpty) {
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: _photoPlaceholder(),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildPhotoTile(photos.first, cover: true),
            if (photos.length > 1)
              Positioned(
                right: 12,
                bottom: 12,
                child: _PhotoCountBadge(total: photos.length),
              ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => openPhotoViewer(context, photos, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoTile(String path, {bool cover = false}) {
    if (kIsWeb) {
      return _photoPlaceholder();
    }

    try {
      final file = File(path);
      if (!file.existsSync()) return _photoPlaceholder();
      return Image.file(
        file,
        fit: cover ? BoxFit.cover : BoxFit.cover,
        errorBuilder: (_, _, _) => _photoPlaceholder(),
      );
    } catch (_) {
      return _photoPlaceholder();
    }
  }

  Widget _photoPlaceholder() {
    return Container(
      color: Colors.white.withValues(alpha: 0.08),
      child: const Icon(
        Icons.photo,
        color: Colors.white54,
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme, AppLocalizations l10n) {
    final stats = [
      _StoryStat(label: l10n.trip_story_stat_steps, value: widget.steps.length.toString()),
      _StoryStat(label: l10n.trip_story_stat_photos, value: _photoPaths.length.toString()),
      _StoryStat(label: l10n.trip_story_stat_days, value: widget.trip.days.toString()),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats
            .map((stat) => _StatColumn(
                  label: stat.label,
                  value: stat.value,
                ))
            .toList(),
      ),
    );
  }

  Future<void> _shareStoryCard() async {
    final l10n = AppLocalizations.of(context)!;
    final boundary = _storyKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) {
      _showSnackBar(l10n.trip_story_share_render_error);
      return;
    }

    try {
      setState(() => _isSharing = true);
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        _showSnackBar(l10n.trip_story_share_image_error);
        return;
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final countryName = isoCountryCodeToName(widget.trip.countryIsoCode);

      if (kIsWeb) {
        final xFile = XFile.fromData(
          pngBytes,
          mimeType: 'image/png',
          name: 'trip_story.png',
        );
        await SharePlus.instance.share(
          ShareParams(
            files: [xFile],
            text: l10n.trip_story_share_message(countryName),
          ),
        );
      } else {
        final dir = await getTemporaryDirectory();
        final file = await File('${dir.path}/trip_story_${widget.trip.id ?? 'share'}.png')
            .create(recursive: true);
        await file.writeAsBytes(pngBytes);
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path)],
            text: l10n.trip_story_share_message(countryName),
          ),
        );
      }
    } catch (error) {
      _showSnackBar(l10n.trip_story_share_failed('$error'));
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

class _StoryStat {
  final String label;
  final String value;

  const _StoryStat({required this.label, required this.value});
}

class _PhotoCountBadge extends StatelessWidget {
  final int total;

  const _PhotoCountBadge({required this.total});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.collections, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              '+${total - 1}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                letterSpacing: 1.1,
              ),
        ),
      ],
    );
  }
}
