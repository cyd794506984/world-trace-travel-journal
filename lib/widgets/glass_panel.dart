import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double blur;

  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = const BorderRadius.all(Radius.circular(26)),
    this.blur = 20,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final glass = theme.extension<GlassTheme>();
    final bg = glass?.glassBackground ?? theme.colorScheme.surface.withValues(alpha: 0.65);
    final border = glass?.glassBorder ?? theme.colorScheme.onSurface.withValues(alpha: 0.1);
    final shadow = glass?.glassShadow ?? Colors.black.withValues(alpha: 0.2);
    final gradientOpacity = math.max(0.0, math.min(1.0, bg.a * 0.85));

    final resolvedBorder = borderRadius.resolve(Directionality.of(context));
    return ClipRRect(
      borderRadius: resolvedBorder,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bg,
                bg.withValues(alpha: gradientOpacity),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: resolvedBorder,
            border: Border.all(color: border, width: 1),
            boxShadow: [
              BoxShadow(
                color: shadow,
                blurRadius: 34,
                offset: const Offset(0, 18),
                spreadRadius: -6,
              ),
            ],
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
