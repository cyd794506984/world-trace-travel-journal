import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';

class StepMediaViewerScreen extends StatefulWidget {
  final List<String> mediaPaths;
  final int initialIndex;

  const StepMediaViewerScreen({
    super.key,
    required this.mediaPaths,
    this.initialIndex = 0,
  }) : assert(initialIndex >= 0, 'initialIndex must be non-negative');

  @override
  State<StepMediaViewerScreen> createState() => _StepMediaViewerScreenState();
}

class _StepMediaViewerScreenState extends State<StepMediaViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.mediaPaths.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _shareCurrentImage() async {
    final l10n = AppLocalizations.of(context)!;
    if (_currentIndex < 0 || _currentIndex >= widget.mediaPaths.length) return;
    final path = widget.mediaPaths[_currentIndex];

    if (kIsWeb) {
      _showSnackBar(l10n.step_media_web_unsupported);
      return;
    }

    final file = File(path);
    if (!file.existsSync()) {
      _showSnackBar(l10n.step_media_image_missing);
      return;
    }

    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(path)],
          text: l10n.step_media_share_text,
        ),
      );
    } catch (_) {
      _showSnackBar(l10n.step_media_share_failed);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = widget.mediaPaths.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.step_media_title(_currentIndex + 1, total)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: l10n.step_media_share_tooltip,
            onPressed: _shareCurrentImage,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: total,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          itemBuilder: (context, index) {
            final path = widget.mediaPaths[index];
            return _MediaPage(path: path);
          },
        ),
      ),
    );
  }
}

class _MediaPage extends StatelessWidget {
  final String path;
  const _MediaPage({required this.path});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Widget content;

    if (kIsWeb) {
      content = _placeholder();
    } else {
      final file = File(path);
      if (file.existsSync()) {
        content = InteractiveViewer(
          maxScale: 4,
          child: Center(
            child: Image.file(
              file,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => _placeholder(),
            ),
          ),
        );
      } else {
        content = _placeholder();
      }
    }

    return Stack(
      children: [
        Positioned.fill(child: content),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              l10n.app_title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.broken_image_outlined,
          color: Colors.white70,
          size: 48,
        ),
      ),
    );
  }
}
