import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/trip.dart';
import '../../repositories/trip_repository.dart';
import '../../services/auth_service.dart';

class TripEditScreen extends StatefulWidget {
  final String? countryIso;
  final TripModel? trip;

  const TripEditScreen({super.key, this.countryIso, this.trip});

  @override
  State<TripEditScreen> createState() => _TripEditScreenState();
}

class _TripEditScreenState extends State<TripEditScreen> {
  final _countryCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  DateTime? _start;
  DateTime? _end;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final trip = widget.trip;
    _countryCtrl.text = trip?.countryIsoCode ?? widget.countryIso ?? '';
    _nameCtrl.text = trip?.title ?? '';
    _descriptionCtrl.text = trip?.notes ?? '';
    _start = trip?.startDate;
    _end = trip?.endDate;
  }

  @override
  void dispose() {
    _countryCtrl.dispose();
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEditing = widget.trip != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.trip_edit_title_edit : l10n.trip_edit_title_new,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _saving ? null : () => Navigator.of(context).maybePop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: _saving ? null : _handleSave,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
              child: _saving
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                      ),
                    )
                  : Text(
                      isEditing ? l10n.trip_edit_button_save : l10n.trip_edit_button_create,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: colorScheme.surface.withValues(alpha: 0.6),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTripNameField(theme, l10n),
                  const SizedBox(height: 16),
                  _buildCountryIsoField(theme, l10n),
                  const SizedBox(height: 16),
                  _buildNotesField(theme, l10n),
                  const SizedBox(height: 24),
                  _buildDateButtonsRow(l10n),
                  _buildTripDurationSummary(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripDurationSummary(AppLocalizations l10n) {
    if (_start == null || _end == null) return const SizedBox.shrink();
    final days = _end!.difference(_start!).inDays + 1;
    if (days <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        l10n.trip_editor_date_range_days(days),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
            ),
      ),
    );
  }

  Widget _buildTripNameField(ThemeData theme, AppLocalizations l10n) {
    return TextField(
      controller: _nameCtrl,
      decoration: _glassFieldDecoration(
        theme,
        label: l10n.trip_edit_field_name_label,
      ),
      textCapitalization: TextCapitalization.words,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildCountryIsoField(ThemeData theme, AppLocalizations l10n) {
    return TextField(
      controller: _countryCtrl,
      decoration: _glassFieldDecoration(
        theme,
        label: l10n.trip_edit_field_country_iso_label,
        helper: l10n.trip_edit_field_country_iso_help,
      ),
      textCapitalization: TextCapitalization.characters,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildNotesField(ThemeData theme, AppLocalizations l10n) {
    return TextField(
      controller: _descriptionCtrl,
      decoration: _glassFieldDecoration(
        theme,
        label: l10n.trip_edit_field_notes_label,
      ),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 3,
      maxLines: 6,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildDateButtonsRow(AppLocalizations l10n) {
    final locale = l10n.localeName;
    final buttonStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _saving ? null : () => _selectDate(isStart: true),
            style: buttonStyle,
            icon: const Icon(Icons.calendar_today_outlined, size: 18),
            label: Text(
              _start != null ? DateFormat.yMMMd(locale).format(_start!) : l10n.trip_edit_button_start_date,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _saving ? null : () => _selectDate(isStart: false),
            style: buttonStyle,
            icon: const Icon(Icons.calendar_today_outlined, size: 18),
            label: Text(
              _end != null ? DateFormat.yMMMd(locale).format(_end!) : l10n.trip_edit_button_end_date,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _glassFieldDecoration(
    ThemeData theme, {
    required String label,
    String? helper,
  }) {
    return InputDecoration(
      labelText: label,
      helperText: helper,
      border: InputBorder.none,
      filled: true,
      fillColor: theme.colorScheme.surface.withValues(alpha: 0.4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Future<void> _selectDate({required bool isStart}) async {
    final now = DateTime.now();
    final initialDate = isStart ? (_start ?? now) : (_end ?? _start ?? now);
    final picked = await showDatePicker(context: context, initialDate: initialDate, firstDate: DateTime(1900), lastDate: DateTime(2100));
    if (picked == null) return;
    if (!mounted) return;
    setState(() {
      if (isStart) {
        _start = picked;
      } else {
        _end = picked;
      }
    });
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    final countryIso = _countryCtrl.text.trim().toUpperCase();
    final name = _nameCtrl.text.trim();
    final notes = _descriptionCtrl.text.trim();

    if (countryIso.isEmpty) {
      _showError(l10n.trip_editor_error_country_required);
      return;
    }

    if (name.isEmpty) {
      _showError(l10n.trip_editor_error_name_required);
      return;
    }

    if (_start == null || _end == null) {
      _showError(l10n.trip_editor_error_dates_required);
      return;
    }

    final start = _start!;
    final end = _end!;

    if (end.isBefore(start)) {
      _showError(l10n.trip_editor_error_date_order);
      return;
    }

    final auth = Provider.of<AuthService>(context, listen: false);
    final repo = Provider.of<TripRepository>(context, listen: false);
    final userId = widget.trip?.userId ?? auth.currentUser?.id ?? 'guest';

    final trip = TripModel(
      id: widget.trip?.id,
      userId: userId,
      countryIsoCode: countryIso,
      startDate: start,
      endDate: end,
      tripType: widget.trip?.tripType ?? 'vacation',
      title: name,
      notes: notes.isEmpty ? null : notes,
    );

    setState(() {
      _saving = true;
    });

    try {
      if (widget.trip == null) {
        await repo.addTrip(trip);
      } else {
        await repo.updateTrip(trip);
      }

      if (!mounted) return;
      Navigator.of(context).pop(trip);
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
