class GoalModel {
  static const String typeCountriesPerYear = 'countries_per_year';

  final String id;
  final String userId;
  final String title;
  final String type;
  final int targetValue;
  final int year;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GoalModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.type,
    required this.targetValue,
    required this.year,
    required this.createdAt,
    required this.updatedAt,
  });

  GoalModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? type,
    int? targetValue,
    int? year,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GoalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      year: year ?? this.year,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'type': type,
        'targetValue': targetValue,
        'year': year,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      targetValue: map['targetValue'] as int,
      year: map['year'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
