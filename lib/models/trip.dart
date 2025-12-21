class TripModel {
  final int? id;
  final String userId;
  final String countryIsoCode;
  final DateTime startDate;
  final DateTime endDate;
  final String tripType;
  final String? title;
  final String? notes;

  TripModel({
    this.id,
    required this.userId,
    required this.countryIsoCode,
    required this.startDate,
    required this.endDate,
    this.tripType = 'vacation',
    this.title,
    this.notes,
  });

  int get days => endDate.difference(startDate).inDays + 1;

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'countryIsoCode': countryIsoCode,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'tripType': tripType,
        'title': title,
        'notes': notes,
      };

  factory TripModel.fromMap(Map<String, dynamic> m) => TripModel(
        id: m['id'] as int?,
        userId: m['userId'] as String,
        countryIsoCode: m['countryIsoCode'] as String,
        startDate: DateTime.parse(m['startDate'] as String),
        endDate: DateTime.parse(m['endDate'] as String),
        tripType: m['tripType'] as String? ?? 'vacation',
        title: m['title'] as String?,
        notes: m['notes'] as String?,
      );
}
