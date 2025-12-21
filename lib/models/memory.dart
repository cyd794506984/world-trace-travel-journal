class MemoryModel {
  final int? id;
  final int tripId;
  final String type; // photo, note
  final String path;
  final String? caption;
  final DateTime createdAt;

  MemoryModel({
    this.id,
    required this.tripId,
    this.type = 'photo',
    required this.path,
    this.caption,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'tripId': tripId,
        'type': type,
        'path': path,
        'caption': caption,
        'createdAt': createdAt.toIso8601String(),
      };
}
