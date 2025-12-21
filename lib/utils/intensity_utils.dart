/// Utilities to map raw day counts into normalized intensity values / levels.
class IntensityUtils {
  /// Given a map of iso -> days and an optional cap, return normalized 0.0-1.0 values.
  static Map<String, double> normalizeByMax(Map<String, int> daysByCountry, {int? cap}) {
    final maxVal = (cap ?? (daysByCountry.values.isEmpty ? 1 : daysByCountry.values.reduce((a, b) => a > b ? a : b))).toDouble();
    final out = <String, double>{};
    for (final e in daysByCountry.entries) {
      out[e.key] = (e.value / (maxVal == 0 ? 1 : maxVal)).clamp(0.0, 1.0);
    }
    return out;
  }

  /// Map normalized 0.0-1.0 to discrete level 0..(levels-1).
  static Map<String, int> toLevels(Map<String, double> normalized, {int levels = 5}) {
    final out = <String, int>{};
    for (final e in normalized.entries) {
      final lvl = (e.value * (levels - 1)).round();
      out[e.key] = lvl.clamp(0, levels - 1);
    }
    return out;
  }
}
