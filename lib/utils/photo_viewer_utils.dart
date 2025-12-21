import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/step_media_viewer_screen.dart';

void openPhotoViewer(
  BuildContext context,
  List<String> paths,
  int initialIndex,
) {
  if (paths.isEmpty || kIsWeb) {
    if (kIsWeb) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.photo_viewer_web_unsupported),
        ),
      );
    }
    return;
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => StepMediaViewerScreen(
        mediaPaths: paths,
        initialIndex: initialIndex.clamp(0, paths.length - 1),
      ),
    ),
  );
}
