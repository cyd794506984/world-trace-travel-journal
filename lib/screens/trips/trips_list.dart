import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/trip.dart';
import '../../repositories/trip_repository.dart';
import '../../services/auth_service.dart';
import '../../utils/flag_utils.dart';
import '../../widgets/glass_panel.dart';
import '../trip_detail.dart';
import 'trip_edit.dart';

class TripsListScreen extends StatefulWidget {
  final String? countryIso;
  const TripsListScreen({super.key, this.countryIso});

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  late Future<List<TripModel>> _future;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _refreshTrips();
      _initialized = true;
    }
  }

  void _refreshTrips() {
    final repo = Provider.of<TripRepository>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);
    final userId = auth.currentUser?.id ?? 'guest';
    setState(() {
      _future = repo.getTrips(userId).then((list) {
        if (widget.countryIso == null) return list;
        return list.where((t) => t.countryIsoCode == widget.countryIso).toList();
      });
    });
  }

  Future<void> _openTripDetail(TripModel trip) async {
    final l10n = AppLocalizations.of(context)!;
    final deleted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => TripDetailScreen(trip: trip),
      ),
    );

    if (deleted == true && mounted) {
      _refreshTrips();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.trip_deleted)),
      );
    }
  }

  Future<void> _confirmDeleteTrip(TripModel trip) async {
    if (trip.id == null) return;
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final deletedMsg = l10n.trip_deleted;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.trip_delete_confirm_title),
          content: Text(l10n.trip_delete_confirm_body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.btn_cancel),
            ),
            ElevatedButton(
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
    await repo.deleteTripWithSteps(trip.id!.toString());
    if (!mounted) return;
    _refreshTrips();
    messenger.showSnackBar(
      SnackBar(content: Text(deletedMsg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trips_title),
        elevation: 0,
      ),
      body: FutureBuilder<List<TripModel>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final trips = snap.data ?? [];
          if (trips.isEmpty) {
            return Center(child: Text(l10n.no_trips_yet));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            itemCount: trips.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final t = trips[i];
              final start = t.startDate.toLocal().toIso8601String().split('T').first;
              final end = t.endDate.toLocal().toIso8601String().split('T').first;
              final countryName = isoCountryCodeToName(t.countryIsoCode);
              final customTitle = t.title?.trim();
              final hasCustomTitle = customTitle?.isNotEmpty == true;
              return GlassPanel(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => _openTripDetail(t),
                    child: Row(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primary.withValues(alpha: 0.15),
                          ),
                          child: Center(
                            child: Text(
                              isoCountryCodeToEmoji(t.countryIsoCode),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                countryName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              if (hasCustomTitle) ...[
                                const SizedBox(height: 4),
                                Text(
                                  customTitle!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 6),
                              Text(
                                '$start - $end',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            l10n.trip_detail_days_chip(t.days),
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
                          onSelected: (value) {
                            if (value == 'open') {
                              _openTripDetail(t);
                            } else if (value == 'delete') {
                              _confirmDeleteTrip(t);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 'open', child: Text(l10n.menu_open_details)),
                            PopupMenuItem(value: 'delete', child: Text(l10n.menu_delete_trip)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TripEditScreen()),
          );
          _refreshTrips();
        },
        tooltip: l10n.tooltip_add_trip,
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
