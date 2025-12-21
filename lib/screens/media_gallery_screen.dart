import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../repositories/step_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/auth_service.dart';
import '../utils/flag_utils.dart';
import 'trip_detail.dart';

class MediaGalleryScreen extends StatefulWidget {
  const MediaGalleryScreen({super.key});

  @override
  State<MediaGalleryScreen> createState() => _MediaGalleryScreenState();
}

class _MediaGalleryScreenState extends State<MediaGalleryScreen> {
  Future<_GalleryPayload>? _future;
  String? _userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = context.watch<AuthService>();
    final newUserId = auth.currentUser?.id;
    if (newUserId != _userId) {
      _userId = newUserId;
      _future = newUserId == null ? null : _loadPayload(newUserId);
    }
  }

  Future<_GalleryPayload> _loadPayload(String userId) async {
    final tripRepo = context.read<TripRepository>();
    final stepRepo = context.read<StepRepository>();

    final trips = await tripRepo.getTrips(userId);
    if (trips.isEmpty) {
      return const _GalleryPayload(trips: [], coverPaths: {});
    }

    final tripIds = trips
        .where((trip) => trip.id != null)
        .map((trip) => trip.id!.toString())
        .toList();
    final steps = tripIds.isEmpty
        ? <StepModel>[]
        : await stepRepo.getStepsForTrips(tripIds);

    final coverPaths = <String, String>{};
    for (final step in steps) {
      if (step.mediaPaths.isEmpty) continue;
      final key = step.tripId;
      if (coverPaths.containsKey(key)) continue;
      for (final path in step.mediaPaths) {
        if (path.isEmpty) continue;
        coverPaths[key] = path;
        break;
      }
    }

    return _GalleryPayload(trips: trips, coverPaths: coverPaths);
  }

  Future<void> _refreshGallery() async {
    final id = _userId;
    if (id == null) return;
    setState(() {
      _future = _loadPayload(id);
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.gallery_title)),
      body: user == null
          ? Center(child: Text(l10n.profile_sign_in_prompt))
          : _future == null
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder<_GalleryPayload>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(l10n.generic_error('${snapshot.error}')),
                      );
                    }
                    final payload = snapshot.data ??
                        const _GalleryPayload(trips: [], coverPaths: {});
                    if (payload.trips.isEmpty) {
                      return _GalleryEmptyView(
                        onRefresh: _refreshGallery,
                        title: l10n.gallery_empty_title,
                        message: l10n.gallery_empty_message,
                      );
                    }

                    final tripsWithMedia = payload.trips
                        .where((trip) {
                          final cover = payload.coverPaths[_tripKey(trip)];
                          return cover != null && cover.isNotEmpty;
                        })
                        .toList();

                    if (tripsWithMedia.isEmpty) {
                      return _GalleryEmptyView(
                        onRefresh: _refreshGallery,
                        title: l10n.gallery_empty_title,
                        message: l10n.gallery_empty_message,
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refreshGallery,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final maxWidth = constraints.maxWidth;
                          final crossAxisCount = maxWidth >= 1100
                              ? 4
                              : maxWidth >= 800
                                  ? 3
                                  : 2;
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: tripsWithMedia.length,
                            itemBuilder: (context, index) {
                              final trip = tripsWithMedia[index];
                              final coverPath =
                                  payload.coverPaths[_tripKey(trip)];
                              return _TripGalleryCard(
                                trip: trip,
                                coverPath: coverPath,
                                onTap: () => _openTrip(trip),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> _openTrip(TripModel trip) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TripDetailScreen(trip: trip)),
    );
  }

  String _tripKey(TripModel trip) {
    return trip.id?.toString() ?? 'null';
  }
}

class _TripGalleryCard extends StatelessWidget {
  final TripModel trip;
  final String? coverPath;
  final VoidCallback onTap;

  const _TripGalleryCard({
    required this.trip,
    required this.coverPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final title = (trip.title ?? '').trim().isEmpty
        ? isoCountryCodeToName(trip.countryIsoCode)
        : trip.title!.trim();
    final subtitle = '${isoCountryCodeToName(trip.countryIsoCode)} - '
        '${trip.startDate.year}';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: _TripCover(path: coverPath),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.open_in_new, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripCover extends StatelessWidget {
  final String? path;

  const _TripCover({required this.path});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholder = Container(
      color: theme.colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.photo_library_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );

    if (path == null || path!.isEmpty || kIsWeb) {
      return placeholder;
    }

    final file = File(path!);
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

class _GalleryEmptyView extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String title;
  final String message;

  const _GalleryEmptyView({
    required this.onRefresh,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _GalleryPayload {
  final List<TripModel> trips;
  final Map<String, String> coverPaths;

  const _GalleryPayload({required this.trips, required this.coverPaths});
}
