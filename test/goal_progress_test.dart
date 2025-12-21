import 'package:flutter_test/flutter_test.dart';

double computeCountryProgress(int targetCountries, Set<String> visited) {
  return (visited.length / targetCountries).clamp(0, 1).toDouble();
}

void main() {
  test('country progress calculation', () {
    final visited = {'JP', 'US', 'FR'};
    final p = computeCountryProgress(10, visited);
    expect(p, 0.3);
  });
}
