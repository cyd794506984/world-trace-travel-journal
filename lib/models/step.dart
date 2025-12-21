
class StepModel {
  final String id;
  final String tripId;
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final String? placeName;
  final String text;
  final List<String> mediaPaths;

  StepModel({
    required this.id,
    required this.tripId,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.placeName,
    required this.text,
    required this.mediaPaths,
  });

  factory StepModel.fromMap(Map<String, dynamic> map) {
    double? parseNumToDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString());
    }
    List<String> parseMediaPaths(dynamic value) {
      if (value == null || (value is String && value.trim().isEmpty)) return [];
      if (value is String) {
        return value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      return [];
    }
    return StepModel(
      id: map['id'] as String,
      tripId: map['tripId'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      latitude: parseNumToDouble(map['latitude']),
      longitude: parseNumToDouble(map['longitude']),
      placeName: map['placeName'] as String?,
      text: map['text'] as String,
      mediaPaths: parseMediaPaths(map['mediaPaths']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'placeName': placeName,
      'text': text,
      'mediaPaths': mediaPaths.isEmpty ? '' : mediaPaths.join(','),
    };
  }
}
