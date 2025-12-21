import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latlong2/latlong.dart';

class CountryGeometry {
  final String isoCode;
  final String name;
  final List<List<LatLng>> polygons;

  CountryGeometry({required this.isoCode, required this.name, required this.polygons});
}

class GeoService {
  GeoService._();
  static final instance = GeoService._();

  final Map<String, CountryGeometry> _cachedGeometries = {};
  String? _cachedAssetPath;

  /// Load a GeoJSON file and return a map of ISO -> CountryGeometry.
  /// Caches the last asset so repeated calls do not re-parse the JSON.
  Future<Map<String, CountryGeometry>> loadCountryGeometries(String assetPath) async {
    if (_cachedGeometries.isNotEmpty && _cachedAssetPath == assetPath) {
      return _cachedGeometries;
    }

    final data = await rootBundle.loadString(assetPath);
    final json = jsonDecode(data) as Map<String, dynamic>;
    final features = (json['features'] as List<dynamic>?) ?? [];
    final Map<String, CountryGeometry> out = {};

    for (final f in features) {
      final props = (f['properties'] ?? {}) as Map<String, dynamic>;
      final geom = (f['geometry'] ?? {}) as Map<String, dynamic>;
      final name = (props['NAME'] ?? props['name'] ?? '') as String;
      String? iso = (props['ISO_A2'] ?? props['iso_a2'] ?? props['ISO'] ?? props['ISO_A3'] ?? props['iso_a3'] ?? props['ISO_A2']) as String?;
      iso ??= (props['adm0_a3'] ?? props['iso3']) as String?;
      if (iso == null) continue;
      iso = iso.toUpperCase();

      final geometryType = geom['type'] as String?;
      final coords = geom['coordinates'];
      final List<List<LatLng>> polygons = [];

      if (geometryType == 'Polygon') {
        final rings = coords as List<dynamic>;
        for (final ring in rings) {
          final pts = <LatLng>[];
          for (final p in (ring as List<dynamic>)) {
            final lon = (p[0] as num).toDouble();
            final lat = (p[1] as num).toDouble();
            pts.add(LatLng(lat, lon));
          }
          polygons.add(pts);
        }
      } else if (geometryType == 'MultiPolygon') {
        final mpoly = coords as List<dynamic>;
        for (final poly in mpoly) {
          for (final ring in (poly as List<dynamic>)) {
            final pts = <LatLng>[];
            for (final p in (ring as List<dynamic>)) {
              final lon = (p[0] as num).toDouble();
              final lat = (p[1] as num).toDouble();
              pts.add(LatLng(lat, lon));
            }
            polygons.add(pts);
          }
        }
      } else {
        continue;
      }

      if (polygons.isNotEmpty) {
        out[iso] = CountryGeometry(isoCode: iso, name: name, polygons: polygons);
      }
    }

    _cachedGeometries
      ..clear()
      ..addAll(out);
    _cachedAssetPath = assetPath;
    return _cachedGeometries;
  }

  void seedGeometries(Map<String, CountryGeometry> geometries) {
    _cachedGeometries
      ..clear()
      ..addAll(geometries);
    _cachedAssetPath = null;
  }

  Future<String?> findCountryIsoAt(LatLng point) async {
    if (_cachedGeometries.isEmpty) return null;
    for (final geometry in _cachedGeometries.values) {
      if (geometry.contains(point)) {
        return geometry.isoCode;
      }
    }
    return null;
  }
}

extension CountryGeometryHitTest on CountryGeometry {
  bool contains(LatLng point) {
    for (final polygon in polygons) {
      if (_pointInPolygon(point, polygon)) {
        return true;
      }
    }
    return false;
  }
}

bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
  var inside = false;
  final x = point.longitude;
  final y = point.latitude;

  for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    final xi = polygon[i].longitude;
    final yi = polygon[i].latitude;
    final xj = polygon[j].longitude;
    final yj = polygon[j].latitude;

    final intersects = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
    if (intersects) inside = !inside;
  }

  return inside;
}
