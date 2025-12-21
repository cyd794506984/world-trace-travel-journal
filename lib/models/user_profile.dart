class UserProfile {
  static const Object _unset = Object();
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final String? photoPath;

  const UserProfile({this.firstName, this.lastName, this.birthDate, this.photoPath});

  static const UserProfile empty = UserProfile();

  String? get fullName {
    final parts = <String>[
      if (firstName != null && firstName!.trim().isNotEmpty) firstName!.trim(),
      if (lastName != null && lastName!.trim().isNotEmpty) lastName!.trim(),
    ];
    if (parts.isEmpty) return null;
    return parts.join(' ');
  }

  String? get initials {
    final buffer = StringBuffer();
    if (firstName != null && firstName!.trim().isNotEmpty) {
      buffer.write(firstName!.trim()[0].toUpperCase());
    }
    if (lastName != null && lastName!.trim().isNotEmpty) {
      buffer.write(lastName!.trim()[0].toUpperCase());
    }
    final value = buffer.toString();
    return value.isEmpty ? null : value;
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate?.toIso8601String(),
        'photoPath': photoPath,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final birthDateRaw = json['birthDate'];
    DateTime? birthDate;
    if (birthDateRaw is String && birthDateRaw.isNotEmpty) {
      birthDate = DateTime.tryParse(birthDateRaw);
    }
    return UserProfile(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: birthDate,
      photoPath: json['photoPath'] as String?,
    );
  }

  UserProfile copyWith({
    Object? firstName = _unset,
    Object? lastName = _unset,
    Object? birthDate = _unset,
    Object? photoPath = _unset,
  }) {
    return UserProfile(
      firstName: identical(firstName, _unset) ? this.firstName : firstName as String?,
      lastName: identical(lastName, _unset) ? this.lastName : lastName as String?,
      birthDate: identical(birthDate, _unset) ? this.birthDate : birthDate as DateTime?,
      photoPath: identical(photoPath, _unset) ? this.photoPath : photoPath as String?,
    );
  }
}
