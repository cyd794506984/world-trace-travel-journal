import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/geo_service.dart';
import '../theme/app_theme.dart';

typedef CountryTapCallback = void Function(String isoCode);

class WorldMap extends StatefulWidget {
  final List<String> visitedCountries;
  final Map<String, double> intensityByCountry;
  final Map<String, CountryGeometry>? countryGeometries;
  final CountryTapCallback? onCountryTap;
  /// If true, the map ignores drag/zoom/tap (e.g. when embedded in a small hero).
  final bool disableGestures;
  final String? tileUrlTemplate;
  final Color? backgroundColor;
  final double initialZoom;
  final double minZoom;
  final double maxZoom;
  final LatLng initialCenter;
  final LatLngBounds? bounds;
  final bool enforceBounds;

  const WorldMap({
    super.key,
    this.visitedCountries = const [],
    this.intensityByCountry = const {},
    this.countryGeometries,
    this.onCountryTap,
    this.disableGestures = false,
    this.tileUrlTemplate,
    this.backgroundColor,
    this.initialZoom = 1.1,
    this.minZoom = 1.0,
    this.maxZoom = 5.5,
    this.initialCenter = const LatLng(0, 0),
    this.bounds,
    this.enforceBounds = true,
  });

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  static const _defaultGeoAsset = 'assets/geojson/world_simplified.geojson';

  Map<String, CountryGeometry> _countryGeometries = {};
  String? _selectedIso;

  @override
  void initState() {
    super.initState();
    if (widget.countryGeometries != null) {
      _applyGeometries(widget.countryGeometries!, rebuild: false);
    } else {
      _loadDefaultGeometries();
    }
  }

  @override
  void didUpdateWidget(covariant WorldMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryGeometries != null &&
        widget.countryGeometries != oldWidget.countryGeometries) {
      _applyGeometries(widget.countryGeometries!);
    }
  }

  void _applyGeometries(Map<String, CountryGeometry> geometries, {bool rebuild = true}) {
    final cloned = Map<String, CountryGeometry>.from(geometries);
    GeoService.instance.seedGeometries(cloned);
    if (!mounted) return;
    if (rebuild) {
      setState(() {
        _countryGeometries = cloned;
      });
    } else {
      _countryGeometries = cloned;
    }
  }

  Future<void> _loadDefaultGeometries() async {
    final loaded = await GeoService.instance.loadCountryGeometries(_defaultGeoAsset);
    if (!mounted) return;
    _applyGeometries(loaded);
  }

  Color _fillColorFor(String iso, bool isVisited, ColorScheme scheme) {
    if (isVisited) {
      return AppTheme.visitedCountryBase.withValues(alpha: 0.4);
    }
    return scheme.primary.withValues(alpha: 0.08);
  }

  Future<void> _handleTap(LatLng point) async {
    if (_countryGeometries.isEmpty) {
      await _loadDefaultGeometries();
      if (!mounted) return;
    }
    final iso = await GeoService.instance.findCountryIsoAt(point);
    if (!mounted) return;
    final normalized = iso?.toUpperCase();
    setState(() {
      _selectedIso = normalized;
    });
    if (normalized != null) {
      widget.onCountryTap?.call(normalized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visited = widget.visitedCountries.map((iso) => iso.toUpperCase()).toSet();
    final selectedUpper = _selectedIso?.toUpperCase();

    final polygons = <Polygon>[];
    for (final geometry in _countryGeometries.values) {
      final isoUpper = geometry.isoCode.toUpperCase();
      final isVisited = visited.contains(isoUpper);
      final isSelected = selectedUpper != null && selectedUpper == isoUpper;
      final fillColor = _fillColorFor(isoUpper, isVisited, scheme);
        final borderColor = isVisited
          ? AppTheme.visitedCountryBase.withValues(alpha: 0.9)
          : Colors.white.withValues(alpha: isSelected ? 0.95 : 0.75);
        final strokeWidth = isVisited ? 1.3 : (isSelected ? 1.2 : 0.6);
      for (final polygon in geometry.polygons) {
        polygons.add(
          Polygon(
            points: polygon,
            color: fillColor,
            borderColor: borderColor,
            borderStrokeWidth: strokeWidth,
          ),
        );
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.initialCenter,
              initialZoom: widget.initialZoom,
              minZoom: widget.minZoom,
              maxZoom: widget.maxZoom,
              backgroundColor: widget.backgroundColor ?? scheme.surface,
              cameraConstraint: widget.bounds != null && widget.enforceBounds
                  ? CameraConstraint.contain(bounds: widget.bounds!)
                  : const CameraConstraint.unconstrained(),
              interactionOptions: widget.disableGestures
                  ? const InteractionOptions(flags: InteractiveFlag.none)
                  : const InteractionOptions(
                      flags: InteractiveFlag.drag |
                          InteractiveFlag.pinchZoom |
                          InteractiveFlag.doubleTapZoom,
                    ),
              onTap: widget.disableGestures
                  ? null
                  : (tapPosition, latLng) {
                      _handleTap(latLng);
                    },
            ),
            children: [
              TileLayer(
                urlTemplate: widget.tileUrlTemplate ??
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                userAgentPackageName: 'com.example.world_trace',
                maxZoom: 19,
              ),
              PolygonLayer(
                polygons: polygons,
                polygonCulling: false,
              ),
            ],
          ),
          if (selectedUpper != null && _countryGeometries.containsKey(selectedUpper))
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: IgnorePointer(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _countryGeometries[selectedUpper]!.name,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
