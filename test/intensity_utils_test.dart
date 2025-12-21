import 'package:flutter_test/flutter_test.dart';
import 'package:world_trace/utils/intensity_utils.dart';

void main() {
  test('normalizeByMax scales correctly', () {
    final map = {'JP': 5, 'US': 10};
    final n = IntensityUtils.normalizeByMax(map.cast<String, int>());
    expect(n['US']! > n['JP']!, true);
    expect(n['US'], 1.0);
  });

  test('toLevels discretizes', () {
    final normalized = {'A': 0.0, 'B': 0.5, 'C': 1.0};
    final levels = IntensityUtils.toLevels(normalized, levels: 5);
    expect(levels['A'], 0);
    expect(levels['B'], 2);
    expect(levels['C'], 4);
  });
}
