class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? baseCountryCode;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.baseCountryCode,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'baseCountryCode': baseCountryCode,
        'createdAt': createdAt.toIso8601String(),
      };
}
