import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Toggle fonts off during widget tests to avoid AssetManifest lookup.
  static bool useGoogleFonts = true;
  static const Color _seed = Color(0xFF0CA7F6);
  static const Color _secondarySeed = Color(0xFF19D1A3);
  static const Color _tertiarySeed = Color(0xFF0C2035);
  static const Color visitedCountryBase = Color(0xFF36C0FF);

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    secondary: _secondarySeed,
    brightness: Brightness.light,
    tertiary: _tertiarySeed,
  ).copyWith(
    surface: const Color(0xFFFDFEFF),
    surfaceContainerHighest: Colors.white.withValues(alpha: 0.92),
    onPrimary: Colors.white,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    secondary: _secondarySeed,
    tertiary: _tertiarySeed,
    brightness: Brightness.dark,
  ).copyWith(
    surface: const Color(0xFF0C1524),
    surfaceContainerHighest: const Color(0xFF111B2E),
    onPrimary: Colors.white,
  );

  static ThemeData light() {
    final glass = GlassTheme(
      glassBackground: Colors.white.withValues(alpha: 0.65),
      glassBorder: Colors.white.withValues(alpha: 0.28),
      glassShadow: Colors.black.withValues(alpha: 0.08),
    );
    return _baseTheme(lightScheme, const Color(0xFFF0F4FF), glass, isDark: false);
  }

  static ThemeData dark() {
    final glass = GlassTheme(
      glassBackground: Colors.white.withValues(alpha: 0.10),
      glassBorder: Colors.white.withValues(alpha: 0.18),
      glassShadow: Colors.black.withValues(alpha: 0.55),
    );
    return _baseTheme(darkScheme, const Color(0xFF050A12), glass, isDark: true);
  }

  static ThemeData _baseTheme(
    ColorScheme scheme,
    Color scaffold,
    GlassTheme glassTheme, {
    required bool isDark,
  }) {
    final textColor = scheme.onSurface;
    final TextTheme baseTextTheme = _safeTextTheme(scheme.brightness);
    final fontFamily = _safeFontFamily();
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          letterSpacing: 0.2,
          color: textColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerHighest,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.55)),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const StadiumBorder(),
        elevation: 6,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      textTheme: _textTheme(textColor, baseTextTheme),
      extensions: <ThemeExtension<dynamic>>[glassTheme],
      drawerTheme: DrawerThemeData(
        backgroundColor: scaffold.withValues(alpha: isDark ? 0.8 : 0.7),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  static TextTheme _textTheme(Color baseColor, TextTheme base) {
    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 34,
        color: baseColor,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 24,
        color: baseColor,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 20,
        color: baseColor,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 18,
        color: baseColor,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: baseColor,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: baseColor.withValues(alpha: 0.82),
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 16,
        color: baseColor.withValues(alpha: 0.92),
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 14,
        color: baseColor,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: baseColor.withValues(alpha: 0.8),
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: baseColor.withValues(alpha: 0.8),
      ),
    );
  }

  static TextTheme _safeTextTheme(Brightness brightness) {
    if (!useGoogleFonts) {
      return ThemeData(brightness: brightness).textTheme;
    }
    try {
      return GoogleFonts.manropeTextTheme();
    } catch (_) {
      return ThemeData(brightness: brightness).textTheme;
    }
  }

  static String? _safeFontFamily() {
    if (!useGoogleFonts) return null;
    try {
      return GoogleFonts.manrope().fontFamily;
    } catch (_) {
      return null;
    }
  }
}

class GlassTheme extends ThemeExtension<GlassTheme> {
  final Color glassBackground;
  final Color glassBorder;
  final Color glassShadow;

  const GlassTheme({
    required this.glassBackground,
    required this.glassBorder,
    required this.glassShadow,
  });

  @override
  GlassTheme copyWith({
    Color? glassBackground,
    Color? glassBorder,
    Color? glassShadow,
  }) {
    return GlassTheme(
      glassBackground: glassBackground ?? this.glassBackground,
      glassBorder: glassBorder ?? this.glassBorder,
      glassShadow: glassShadow ?? this.glassShadow,
    );
  }

  @override
  GlassTheme lerp(ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) {
      return this;
    }
    return GlassTheme(
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t) ?? glassBackground,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t) ?? glassBorder,
      glassShadow: Color.lerp(glassShadow, other.glassShadow, t) ?? glassShadow,
    );
  }
}
