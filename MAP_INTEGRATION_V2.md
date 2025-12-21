# Map Integration — Details (v2)

This file documents the current implementation and how to replace/extend the data and rendering.

Where parsing lives
- `lib/services/geo_service.dart` loads GeoJSON and returns `CountryGeometry` objects with:
  - `iso`: ISO code (A2/A3)
  - `name`: country name
  - `polygons`: List<List<LatLng>> (supports Polygon and MultiPolygon)

Rendering
- `lib/widgets/world_map.dart` expects prepared geometries via the `countryGeometries` parameter (preferred) or will load `assets/geojson/world_simplified.geojson`.
- It maps `visitedCountries` + `intensityByCountry` to discrete color levels (5 levels) and highlights the selected country with a border and transient label.

GeoJSON source
- For production use a simplified Natural Earth world countries layer (TopoJSON or GeoJSON simplified to target ~200-500KB compressed). Keep ISO properties (`ISO_A2` or `iso_a2`).

Performance tips
- Simplify geometries before bundling.
- Consider external vector tiles or server-side tiling for large datasets.

Extensibility notes
- Swap map engine by replacing `WorldMap` widget (API stable: `visitedCountries`, `intensityByCountry`, `onCountryTap`, `countryGeometries`).
- Add caching of parsed geometries if load time is a concern.
