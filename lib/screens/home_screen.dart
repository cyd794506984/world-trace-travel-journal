import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../l10n/app_localizations.dart';
import '../models/on_this_day_memory.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../models/user_profile.dart';
import '../repositories/step_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/auth_service.dart';
import '../services/geo_service.dart';
import '../services/on_this_day_service.dart';
import '../services/plan_service.dart';
import '../services/stats_service.dart';
import '../services/user_profile_service.dart';
import '../utils/country_overview_utils.dart';
import '../utils/intensity_utils.dart';
import '../utils/photo_viewer_utils.dart';
import '../widgets/stats_card.dart';
import '../widgets/world_map.dart';
import '../widgets/glass_panel.dart';
import '../widgets/country_overview_sheet.dart';
import 'media_gallery_screen.dart';
import 'trip_detail.dart';
import 'trips/trip_edit.dart';
import 'trips/trips_list.dart';
import 'upgrade_screen.dart';

/// Home: stats in alto + world map.
/// Carica i dati una volta e li ricarica quando torni da Trips / Add trip.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _future;
  final UserProfileService _profileService = UserProfileService.instance;
  String _profileUserId = '';

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = Provider.of<AuthService>(context);
    final userId = auth.currentUser?.id ?? 'guest';
    if (_profileUserId != userId) {
      _profileUserId = userId;
      _profileService.ensureLoaded(userId);
    }
  }

  /// Ricarica trips, daysByCountry e geometrie paesi.
  void _reloadData() {
    final auth = Provider.of<AuthService>(context, listen: false);
    final repo = Provider.of<TripRepository>(context, listen: false);
    final stepRepo = Provider.of<StepRepository>(context, listen: false);
    final userId = auth.currentUser?.id;

    if (userId == null) {
      // Nessun utente: future vuoto, tanto il ramo con FutureBuilder non viene usato.
      _future = Future.value(<dynamic>[]);
      return;
    }

    _future = () async {
      final daysFuture = repo.getDaysByCountry(userId);
      final geometriesFuture = GeoService.instance.loadCountryGeometries(
        'assets/geojson/world_simplified.geojson',
      );
      final trips = await repo.getTrips(userId);
      final tripIds = trips
          .where((trip) => trip.id != null)
          .map((trip) => trip.id!.toString())
          .toList();
      final stepsFuture = tripIds.isEmpty
          ? Future.value(<StepModel>[])
          : stepRepo.getStepsForTrips(tripIds);

      final daysByCountry = await daysFuture;
      final geometries = await geometriesFuture;
      final steps = await stepsFuture;

      return [trips, daysByCountry, geometries, steps];
    }();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final userId = auth.currentUser?.id;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final dateFormatter = DateFormat.yMMMd(localeName);

    return Scaffold(
      drawer: ValueListenableBuilder<UserProfile>(
        valueListenable: _profileService.profileNotifier,
        builder: (context, profile, _) {
          return ValueListenableBuilder<PlanType>(
            valueListenable: PlanService.instance.planTypeListenable,
            builder: (context, plan, _) {
              return _HomeDrawer(
                l10n: l10n,
                user: auth.currentUser,
                profile: profile,
                isPro: plan == PlanType.pro,
                onDestinationSelected: _handleDrawerSelection,
                onUpgradeTap: _openUpgrade,
              );
            },
          );
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050A12), Color(0xFF0A1A2C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: userId == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    l10n.home_sign_in_prompt,
                    textAlign: TextAlign.center,
                  ),
                ),
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
                      return Center(
                        child: Text(
                          l10n.generic_error(snapshot.error ?? ''),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Center(child: Text(l10n.no_trips_yet));
                    }

                    final trips = (snapshot.data![0] as List<TripModel>? ?? <TripModel>[]);
                    final daysByCountry = Map<String, int>.from(snapshot.data![1] as Map? ?? {});
                    final geometries = Map<String, CountryGeometry>.from(snapshot.data![2] as Map? ?? {});
                    final steps =
                        (snapshot.data!.length > 3 ? snapshot.data![3] as List<StepModel>? : null) ?? <StepModel>[];

                    final summary = StatsService.computeSummary(trips);
                    final int totalCountries =
                        summary['totalCountries'] as int? ?? daysByCountry.keys.length;
                    final int totalDays =
                        summary['totalDays'] as int? ?? daysByCountry.values.fold(0, (p, e) => p + e);
                    final DateTime? lastTrip = summary['lastTrip'] as DateTime?;

                    final normalized = IntensityUtils.normalizeByMax(daysByCountry);

                    final memories = OnThisDayService.computeMemories(
                      today: DateTime.now(),
                      trips: trips,
                      steps: steps,
                    );

                    final profile = _profileService.profileNotifier.value;
                    final displayName = profile.fullName ?? _fallbackName(l10n, auth.currentUser);
                    final avatarImage = _avatarImageFromPath(profile.photoPath);
                    final initials = profile.initials ?? _initialsFromName(displayName);
                    final tripsCount = trips.length;
                    final stepsCount = steps.length;

                    final statsRail = _buildStatsRail(
                      l10n: l10n,
                      theme: theme,
                      totalCountries: totalCountries,
                      totalDays: totalDays,
                      lastTrip: lastTrip,
                      dateFormatter: dateFormatter,
                    );

                    final hero = _buildHeroHeader(
                      context,
                      displayName: displayName,
                      avatarImage: avatarImage,
                      initials: initials,
                      tripsCount: tripsCount,
                      totalCountries: totalCountries,
                      stepsCount: stepsCount,
                      daysByCountry: daysByCountry,
                      geometries: geometries,
                      normalized: normalized,
                      trips: trips,
                      steps: steps,
                    );

                    return ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.fromLTRB(
                        16,
                        MediaQuery.of(context).padding.top + 12,
                        16,
                        MediaQuery.of(context).padding.bottom + 24,
                      ),
                      children: [
                        _TopBar(onMenu: () => Scaffold.of(context).openDrawer(), onSettings: () => Navigator.pushNamed(context, '/settings')),
                        const SizedBox(height: 12),
                        hero,
                        const SizedBox(height: 18),
                        statsRail,
                        const SizedBox(height: 18),
                        _buildOnThisDaySection(l10n, memories),
                      ],
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/trips');
          if (!mounted) return;
          _reloadData();
          setState(() {});
        },
        tooltip: l10n.drawer_trips,
        shape: const StadiumBorder(),
        child: const Icon(Icons.map),
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

  void _handleDrawerSelection(String? route) {
    Navigator.of(context).pop();
    if (route == null || route == '/home') {
      return;
    }
    if (route == '/gallery') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MediaGalleryScreen()),
      );
      return;
    }
    Navigator.of(context).pushNamed(route);
  }

  void _openUpgrade() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UpgradeScreen()),
    );
  }

  Widget _buildOnThisDaySection(AppLocalizations l10n, List<OnThisDayMemory> memories) {
    final theme = Theme.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final shortDateFormatter = DateFormat.MMMd(localeName);
    if (memories.isEmpty) {
      return GlassPanel(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.on_this_day_title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.on_this_day_empty,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    final memory = memories.first;
    final date = memory.step.timestamp;
    final dateLabel = shortDateFormatter.format(date);

    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.on_this_day_title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('${memory.flagEmoji} ${memory.countryName}',
                  style: theme.textTheme.titleMedium),
              const Spacer(),
              Text(memory.year.toString(), style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOnThisDayThumbnail(memory, theme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.on_this_day_label(dateLabel),
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      memory.step.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _openTrip(memory.trip),
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.btn_open_trip),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(
    BuildContext context, {
    required String displayName,
    required ImageProvider? avatarImage,
    required String initials,
    required int tripsCount,
    required int totalCountries,
    required int stepsCount,
    required Map<String, int> daysByCountry,
    required Map<String, CountryGeometry> geometries,
    required Map<String, double> normalized,
    required List<TripModel> trips,
    required List<StepModel> steps,
  }) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GlassPanel(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      borderRadius: BorderRadius.circular(32),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.home_welcome_title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white70,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    displayName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          _GlobeHero(
            intensityByCountry: normalized,
            daysByCountry: daysByCountry,
            geometries: geometries,
            onCountryTap: (iso) => _showCountryBottomSheet(context, iso, trips, daysByCountry, steps, geometries),
            disableGestures: false,
            tileUrlTemplate:
                'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
          ),
          const SizedBox(height: 18),
          _ProfileCard(
            initials: initials,
            avatarImage: avatarImage,
            displayName: displayName,
            totalCountries: totalCountries,
            tripsCount: tripsCount,
            stepsCount: stepsCount,
            onAddTrip: _startNewTrip,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRail({
    required AppLocalizations l10n,
    required ThemeData theme,
    required int totalCountries,
    required int totalDays,
    required DateTime? lastTrip,
    required DateFormat dateFormatter,
  }) {
    final cards = [
      StatsCard(
        title: l10n.stat_countries_visited,
        value: '$totalCountries',
        icon: Icons.public,
      ),
      StatsCard(
        title: l10n.stat_days_abroad,
        value: '$totalDays',
        icon: Icons.calendar_today,
      ),
      StatsCard(
        title: l10n.stat_last_trip,
        value: lastTrip == null ? '-' : dateFormatter.format(lastTrip),
        icon: Icons.flight_takeoff,
        valueTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      ),
    ];

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return SizedBox(width: 220, child: cards[index]);
        },
      ),
    );
  }

  Future<void> _openTrip(TripModel trip) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TripDetailScreen(trip: trip)),
    );
    if (!mounted) return;
    _reloadData();
    setState(() {});
  }

  Future<void> _startNewTrip() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const TripEditScreen()),
    );
    if (!mounted) return;
    _reloadData();
    setState(() {});
  }

  Widget _buildOnThisDayThumbnail(OnThisDayMemory memory, ThemeData theme) {
    final paths = memory.step.mediaPaths;
    final previewPath = _resolvePreviewPath(memory, paths);
    final hasPhoto = paths.isNotEmpty && previewPath != null && previewPath.isNotEmpty;
    final initialIndex = hasPhoto
        ? (paths.contains(previewPath) ? paths.indexOf(previewPath) : 0)
        : 0;

    return SizedBox(
      width: 140,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildOnThisDayThumbnailContent(previewPath, theme),
              if (paths.length > 1)
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: _PhotoBadge(count: paths.length),
                ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: hasPhoto
                      ? () {
                          openPhotoViewer(context, paths, initialIndex);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _resolvePreviewPath(OnThisDayMemory memory, List<String> paths) {
    final photoPath = memory.photoPath;
    if (photoPath != null && photoPath.isNotEmpty) {
      return photoPath;
    }
    if (paths.isNotEmpty) {
      return paths.first;
    }
    return null;
  }

  Widget _buildOnThisDayThumbnailContent(String? photoPath, ThemeData theme) {
    final placeholder = Container(
      color: theme.colorScheme.surface.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: const Icon(Icons.flight_takeoff, size: 32),
    );

    if (photoPath == null || photoPath.isEmpty) {
      return placeholder;
    }
    if (kIsWeb) {
      return Container(
        color: theme.colorScheme.surface.withValues(alpha: 0.2),
        alignment: Alignment.center,
        child: const Icon(Icons.photo, size: 32),
      );
    }
    final file = File(photoPath);
    if (!file.existsSync()) {
      return placeholder;
    }
    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}

class _GlobeHero extends StatelessWidget {
  final Map<String, double> intensityByCountry;
  final Map<String, int> daysByCountry;
  final Map<String, CountryGeometry> geometries;
  final ValueChanged<String> onCountryTap;
  final bool disableGestures;
  final String? tileUrlTemplate;

  const _GlobeHero({
    required this.intensityByCountry,
    required this.daysByCountry,
    required this.geometries,
    required this.onCountryTap,
    this.disableGestures = false,
    this.tileUrlTemplate,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  scheme.secondary.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
                stops: const [0.4, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.25),
                  blurRadius: 38,
                  spreadRadius: -10,
                ),
              ],
            ),
          ),
          ClipOval(
              child: ShaderMask(
                shaderCallback: (rect) => const RadialGradient(
                  center: Alignment(0.0, -0.15),
                  radius: 0.9,
                  colors: [Colors.white, Colors.white, Colors.transparent],
                  stops: [0.0, 0.7, 1.0],
                ).createShader(rect),
                blendMode: BlendMode.dstIn,
              child: WorldMap(
                visitedCountries: daysByCountry.keys.toList(),
                intensityByCountry: intensityByCountry,
                countryGeometries: geometries,
                onCountryTap: onCountryTap,
                disableGestures: disableGestures,
                tileUrlTemplate: tileUrlTemplate,
                backgroundColor: Colors.transparent,
                initialZoom: 1.1,
                minZoom: 1.0,
                maxZoom: 4.5,
                bounds: LatLngBounds(const LatLng(-85, -180), const LatLng(85, 180)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String initials;
  final ImageProvider? avatarImage;
  final String displayName;
  final int totalCountries;
  final int tripsCount;
  final int stepsCount;
  final VoidCallback onAddTrip;

  const _ProfileCard({
    required this.initials,
    required this.avatarImage,
    required this.displayName,
    required this.totalCountries,
    required this.tripsCount,
    required this.stepsCount,
    required this.onAddTrip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: avatarImage,
                backgroundColor: scheme.primary.withValues(alpha: 0.12),
                child: avatarImage == null
                    ? Text(
                        initials,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.home_next_trip_prompt,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _CompactStat(label: l10n.profile_stat_countries, value: '$totalCountries'),
              _CompactStat(label: l10n.profile_stat_trips, value: '$tripsCount'),
              _CompactStat(label: l10n.trip_story_stat_steps, value: '$stepsCount'),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_rounded),
                  onPressed: onAddTrip,
                  label: Text(l10n.country_overview_action_add_trip),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => Navigator.pushNamed(context, '/gallery'),
                icon: const Icon(Icons.photo_library_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhotoBadge extends StatelessWidget {
  final int count;

  const _PhotoBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.photo_library, size: 14, color: Colors.white),
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

class _CompactStat extends StatelessWidget {
  final String label;
  final String value;

  const _CompactStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onMenu;
  final VoidCallback onSettings;

  const _TopBar({required this.onMenu, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.white.withValues(alpha: 0.08),
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: onMenu,
          ),
        ),
        Text(
          l10n.app_title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        Material(
          color: Colors.white.withValues(alpha: 0.08),
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: onSettings,
          ),
        ),
      ],
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  final AppLocalizations l10n;
  final AppUser? user;
  final UserProfile profile;
  final bool isPro;
  final ValueChanged<String?> onDestinationSelected;
  final VoidCallback onUpgradeTap;

  const _HomeDrawer({
    required this.l10n,
    required this.user,
    required this.profile,
    required this.isPro,
    required this.onDestinationSelected,
    required this.onUpgradeTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = profile.fullName ?? _fallbackName(l10n, user);
    final email = user?.email;
    final subtitle = email ?? (user?.isGuest ?? true ? l10n.guest_user : user?.id ?? l10n.guest_user);
    final initials = profile.initials ?? _initialsFromName(displayName);
    final avatarImage = _avatarImageFromPath(profile.photoPath);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: GlassPanel(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: avatarImage,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.18),
                      child: avatarImage == null
                          ? Text(
                              initials,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerTile(
                    icon: Icons.dashboard,
                    label: l10n.drawer_home,
                    onTap: () => onDestinationSelected('/home'),
                  ),
                  _DrawerTile(
                    icon: Icons.public,
                    label: l10n.drawer_world_map,
                    onTap: () => onDestinationSelected('/world-map'),
                  ),
                  _DrawerTile(
                    icon: Icons.map,
                    label: l10n.drawer_trips,
                    onTap: () => onDestinationSelected('/trips'),
                  ),
                  _DrawerTile(
                    icon: Icons.insert_chart_outlined,
                    label: l10n.drawer_stats,
                    onTap: () => onDestinationSelected('/stats'),
                  ),
                  _DrawerTile(
                    icon: Icons.photo_library_outlined,
                    label: l10n.gallery_nav_label,
                    onTap: () => onDestinationSelected('/gallery'),
                  ),
                  _DrawerTile(
                    icon: Icons.flag_circle_outlined,
                    label: l10n.drawer_goals,
                    onTap: () => onDestinationSelected('/goals'),
                  ),
                  _DrawerTile(
                    icon: Icons.card_travel,
                    label: l10n.drawer_profile,
                    onTap: () => onDestinationSelected('/profile'),
                  ),
                  _DrawerTile(
                    icon: Icons.emoji_events_outlined,
                    label: l10n.drawer_achievements,
                    onTap: () => onDestinationSelected('/achievements'),
                  ),
                  _DrawerTile(
                    icon: Icons.timeline,
                    label: l10n.year_in_review_title,
                    onTap: () => onDestinationSelected('/year-review'),
                  ),
                  _DrawerTile(
                    icon: Icons.settings_outlined,
                    label: l10n.drawer_account,
                    onTap: () => onDestinationSelected('/settings'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isPro
                      ? null
                      : () {
                          Navigator.of(context).pop();
                          onUpgradeTap();
                        },
                  icon: const Icon(Icons.workspace_premium),
                  label: Text(isPro ? l10n.plan_active : l10n.plan_upgrade),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}

String _fallbackName(AppLocalizations l10n, AppUser? user) {
  if (user == null || user.isGuest) {
    return l10n.guest_user;
  }
  return user.email ?? user.id;
}

String _initialsFromName(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
  if (parts.isEmpty) return 'WT';
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  final first = parts.first[0].toUpperCase();
  final last = parts.last[0].toUpperCase();
  return '$first$last';
}

ImageProvider? _avatarImageFromPath(String? path) {
  if (kIsWeb || path == null || path.isEmpty) {
    return null;
  }
  final file = File(path);
  if (!file.existsSync()) {
    return null;
  }
  return FileImage(file);
}
