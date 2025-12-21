class AppUserModel {
  final String id;
  final String? email;
  final bool isGuest;
  AppUserModel({required this.id, this.email, this.isGuest = false});
}
