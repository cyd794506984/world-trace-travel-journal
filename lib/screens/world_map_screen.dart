import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../repositories/step_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/auth_service.dart';
import '../services/geo_service.dart';
import '../utils/country_overview_utils.dart';
import '../utils/intensity_utils.dart';
import '../widgets/country_overview_sheet.dart';
import '../widgets/world_map.dart';
import 'trips/trips_list.dart';
import 'trips/trip_edit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WorldMapScreen extends StatefulWidget {
  const WorldMapScreen({super.key});

  @override
  State<WorldMapScreen> createState() => _WorldMapScreenState();
}

class _WorldMapScreenState extends State<WorldMapScreen> {
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  void _reloadData() {
    final auth = Provider.of<AuthService>(context, listen: false);
    final repo = Provider.of<TripRepository>(context, listen: false);
    final stepRepo = Provider.of<StepRepository>(context, listen: false);
    final userId = auth.currentUser?.id;
    if (userId == null) {
      _future = Future.value(<dynamic>[]);
      return;
    }
    _future = () async {
      final daysFuture = repo.getDaysByCountry(userId);
      final geometriesFuture = GeoService.instance
          .loadCountryGeometries('assets/geojson/world_simplified.geojson');
      final trips = await repo.getTrips(userId);
      final tripIds = trips
          .where((trip) => trip.id != null)
          .map((trip) => trip.id!.toString())
          .toList();
      final steps = tripIds.isEmpty
          ? <StepModel>[]
          : await stepRepo.getStepsForTrips(tripIds);

      final daysByCountry = await daysFuture;
      final geometries = await geometriesFuture;

      return [trips, daysByCountry, geometries, steps];
    }();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final userId = auth.currentUser?.id;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.drawer_world_map)),
      body: userId == null
          ? Center(
              child: Text(l10n.world_map_sign_in_prompt),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _reloadData();
                setState(() {});
              },
              child: FutureBuilder<List<dynamic>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(l10n.generic_error('${snapshot.error}')));
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text(l10n.world_map_empty_message));
                  }

                  final trips = (snapshot.data![0] as List<TripModel>? ?? <TripModel>[]);
                  final daysByCountry = Map<String, int>.from(snapshot.data![1] as Map? ?? {});
                  final geometries = Map<String, CountryGeometry>.from(snapshot.data![2] as Map? ?? {});
                  final steps = (snapshot.data!.length > 3
                      ? snapshot.data![3] as List<StepModel>?
                      : null) ??
                    <StepModel>[];
                  final normalized = IntensityUtils.normalizeByMax(daysByCountry);

                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: WorldMap(
                              visitedCountries: daysByCountry.keys.toList(),
                              intensityByCountry: normalized,
                              countryGeometries: geometries,
                              onCountryTap: (iso) {
                                _showCountryBottomSheet(
                                  context,
                                  iso,
                                  trips,
                                  daysByCountry,
                                  steps,
                                  geometries,
                                );
                              },
                              backgroundColor: Colors.black,
                              initialCenter: const LatLng(0, 0),
                              bounds: LatLngBounds(const LatLng(-85, -180), const LatLng(85, 180)),
                              initialZoom: 1.2,
                              minZoom: 1.0,
                              maxZoom: 4.5,
                              enforceBounds: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TripEditScreen()));
          if (!mounted) return;
          _reloadData();
          setState(() {});
        },
        icon: const Icon(Icons.add_location_alt_outlined),
        label: Text(l10n.trip_edit_title_new),
      ),
    );
  }

  void _showCountryBottomSheet(
    BuildContext context,
    String iso,
    List<TripModel> trips,
    Map<String, int> daysByCountry,
    List<StepModel> steps,
    Map<String, CountryGeometry> geometries,
  ) {
    final overview = buildCountryOverviewData(
      isoCode: iso,
      trips: trips,
      steps: steps,
      daysByCountry: daysByCountry,
      geometries: geometries,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return CountryOverviewSheet(
          data: overview,
          onViewTrips: () async {
            Navigator.of(ctx).pop();
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TripsListScreen(countryIso: overview.isoCode),
              ),
            );
            if (!mounted) return;
            _reloadData();
            setState(() {});
          },
          onAddTrip: () async {
            Navigator.of(ctx).pop();
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TripEditScreen(countryIso: overview.isoCode),
              ),
            );
            if (!mounted) return;
            _reloadData();
            setState(() {});
          },
        );
      },
    );
  }
}
