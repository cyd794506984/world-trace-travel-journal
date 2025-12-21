import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../repositories/step_repository.dart';
import '../utils/photo_viewer_utils.dart';

class StepEditScreen extends StatefulWidget {
  final TripModel trip;
  final StepModel? existingStep;

  const StepEditScreen({
    super.key,
    required this.trip,
    this.existingStep,
  });

  @override
  State<StepEditScreen> createState() => _StepEditScreenState();
}

class _StepEditScreenState extends State<StepEditScreen> {
  late final TextEditingController _textController;
  late final TextEditingController _placeController;
  late DateTime _selectedTimestamp;
  late List<String> _mediaPaths;
  bool _saving = false;
  final ImagePicker _imagePicker = ImagePicker();

  bool get _isEditing => widget.existingStep != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingStep;
    _textController = TextEditingController(text: existing?.text ?? '');
    _placeController = TextEditingController(text: existing?.placeName ?? '');
    _selectedTimestamp = existing?.timestamp ?? DateTime.now();
    _mediaPaths = List<String>.from(existing?.mediaPaths ?? const []);
    _placeController.addListener(_handlePlaceChanged);
  }

  @override
  void dispose() {
    _placeController.removeListener(_handlePlaceChanged);
    _textController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isEditing = _isEditing;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          isEditing
              ? l10n.step_editor_edit_title
              : l10n.step_editor_add_title,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
        ),
        actions: [
          TextButton(
            onPressed: _saving ? null : _handleSave,
            child: _saving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    isEditing ? l10n.btn_save : l10n.btn_add_step,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight -
                      MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(context, l10n),
                    const SizedBox(height: 24),
                    _buildDiaryTextField(context, l10n),
                    const SizedBox(height: 24),
                    _buildPlaceField(context, l10n),
                    const SizedBox(height: 24),
                    _buildPhotosSection(context, l10n),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final locale = l10n.localeName;
    final date = DateFormat.yMMMMEEEEd(locale).format(_selectedTimestamp);
    final time = DateFormat.Hm(locale).format(_selectedTimestamp);

    final placeText = _placeController.text.trim().isEmpty
        ? null
        : _placeController.text.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: _pickDateTime,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.schedule),
            label: Text(
              l10n.step_editor_field_date_time_label('$date - $time'),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (placeText != null && placeText.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.place, size: 18),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    placeText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                const Icon(Icons.place_outlined, size: 18),
                const SizedBox(width: 4),
                Text(
                  l10n.step_editor_header_add_place_hint,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDiaryTextField(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.step_detail_section_story,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          minLines: 6,
          decoration: InputDecoration(
            hintText: l10n.step_editor_hint_diary,
            border: InputBorder.none,
            filled: true,
            fillColor: theme.colorScheme.surface.withValues(alpha: 0.4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceField(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.step_editor_field_place_label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _placeController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.place_outlined),
            hintText: l10n.step_editor_place_hint,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosSection(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final hasMedia = _mediaPaths.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.step_detail_section_photos,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            if (hasMedia)
              Text(
                l10n.step_editor_photos_selected(_mediaPaths.length),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: _pickImages,
          icon: const Icon(Icons.photo),
          label: Text(l10n.step_editor_button_add_photos),
        ),
        const SizedBox(height: 12),
        if (hasMedia)
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _mediaPaths.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final path = _mediaPaths[index];
                return GestureDetector(
                  onTap: () {
                    openPhotoViewer(context, _mediaPaths, index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: kIsWeb
                        ? const Icon(Icons.photo)
                        : Image.file(
                            File(path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _pickDateTime() async {
    final initial = _selectedTimestamp;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !mounted) return;

    setState(() {
      _selectedTimestamp = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _pickImages() async {
    if (kIsWeb) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.step_media_add_web_unsupported)),
      );
      return;
    }

    try {
      final images = await _imagePicker.pickMultiImage(
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 80,
      );
      if (images.isEmpty) return;

      if (!mounted) return;
      setState(() {
        final existing = _mediaPaths.toSet();
        for (final image in images) {
          if (!existing.contains(image.path)) {
            _mediaPaths.add(image.path);
          }
        }
      });
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.step_editor_error_pick_images)),
      );
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    final description = _textController.text.trim();
    final place = _placeController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.step_editor_error_empty_description)),
      );
      return;
    }

    final tripId = widget.existingStep?.tripId ?? widget.trip.id?.toString();
    if (tripId == null || tripId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.generic_error_saving_step)),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _saving = true);

    try {
      final repo = context.read<StepRepository>();
      final normalizedPlace = place.isEmpty ? null : place;
      final mediaPaths = List<String>.from(_mediaPaths);

      if (_isEditing) {
        final existing = widget.existingStep!;
        final updatedStep = StepModel(
          id: existing.id,
          tripId: existing.tripId,
          timestamp: _selectedTimestamp,
          latitude: existing.latitude,
          longitude: existing.longitude,
          placeName: normalizedPlace,
          text: description,
          mediaPaths: mediaPaths,
        );
        await repo.updateStep(updatedStep);
      } else {
        final newStep = StepModel(
          id: UniqueKey().toString(),
          tripId: tripId,
          timestamp: _selectedTimestamp,
          latitude: null,
          longitude: null,
          placeName: normalizedPlace,
          text: description,
          mediaPaths: mediaPaths,
        );
        await repo.addStep(newStep);
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.generic_error_saving_step)),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  void _handlePlaceChanged() {
    if (!mounted) return;
    setState(() {});
  }
}
