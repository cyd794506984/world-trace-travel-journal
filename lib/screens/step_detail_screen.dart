import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../models/step.dart';
import '../models/trip.dart';
import '../utils/flag_utils.dart';
import '../utils/photo_viewer_utils.dart';

class StepDetailScreen extends StatelessWidget {
  final TripModel trip;
  final StepModel step;

  const StepDetailScreen({
    super.key,
    required this.trip,
    required this.step,
  });

  String _formatDateTime(BuildContext context) {
    final locale = AppLocalizations.of(context)!.localeName;
    final timestamp = step.timestamp.toLocal();
    final date = DateFormat.yMMMMEEEEd(locale).format(timestamp);
    final time = DateFormat.Hm(locale).format(timestamp);
    return '$date - $time';
  }

  String? _buildPlaceLine() {
    final parts = <String>[];
    final place = step.placeName?.trim();
    if (place != null && place.isNotEmpty) {
      parts.add(place);
    }

    final countryCode = trip.countryIsoCode.trim();
    if (countryCode.isNotEmpty) {
      final countryName = isoCountryCodeToName(countryCode);
      final flag = isoCountryCodeToEmoji(countryCode);
      parts.add(
        flag.isNotEmpty ? '$countryName $flag' : countryName,
      );
    }

    if (parts.isEmpty) return null;
    return parts.join(' - ');
  }

  String _buildShareText(BuildContext context) {
    final buffer = StringBuffer()
      ..writeln(_formatDateTime(context));

    final placeLine = _buildPlaceLine();
    if (placeLine != null) {
      buffer
        ..writeln(placeLine)
        ..writeln();
    }

    final story = step.text.trim();
    if (story.isNotEmpty) {
      buffer.writeln(story);
    }
    return buffer.toString().trim();
  }

  void _handleShare(BuildContext context) {
    final text = _buildShareText(context);
    if (text.isEmpty) return;
    SharePlus.instance.share(ShareParams(text: text));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final placeLine = _buildPlaceLine();
    final photosSection = _buildPhotosSection(context, l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          placeLine ?? DateFormat.Hm(l10n.localeName).format(step.timestamp),
        ),
        actions: [
          IconButton(
            tooltip: l10n.step_detail_action_share,
            icon: const Icon(Icons.ios_share),
            onPressed: () => _handleShare(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(context, l10n),
              const SizedBox(height: 24),
              _buildStorySection(context, l10n),
              if (photosSection != null) ...[
                const SizedBox(height: 24),
                photosSection,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final locale = l10n.localeName;
    final timestamp = step.timestamp.toLocal();
    final date = DateFormat.yMMMMEEEEd(locale).format(timestamp);
    final time = DateFormat.Hm(locale).format(timestamp);
    final locationLine = _buildPlaceLine();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface.withValues(alpha: 0.6),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$date - $time',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (locationLine != null && locationLine.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              locationLine,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStorySection(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final text = step.text.trim();

    if (text.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.step_detail_section_story,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.step_detail_story_empty,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }

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
        Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget? _buildPhotosSection(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final mediaPaths = step.mediaPaths;

    if (mediaPaths.isEmpty) {
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.step_detail_section_photos,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: mediaPaths.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final path = mediaPaths[index];
              return GestureDetector(
                onTap: () => openPhotoViewer(context, mediaPaths, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: kIsWeb
                      ? Container(
                          width: 100,
                          height: 100,
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.photo,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        )
                      : Image.file(
                          File(path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 100,
                            height: 100,
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.3),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.photo,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
