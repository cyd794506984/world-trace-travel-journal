
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppUser {
  final String id;
  final String? email;
  final bool isGuest;

  AppUser({required this.id, this.email, required this.isGuest});
}

class AuthService extends ChangeNotifier {
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool get isGuest => _currentUser?.isGuest ?? true;

  static const _guestIdKey = 'guest_id';

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGuestId = prefs.getString(_guestIdKey);
    if (savedGuestId != null) {
      _currentUser = AppUser(id: savedGuestId, isGuest: true);
    }
    notifyListeners();
  }

  Future<void> signInAsGuest() async {
    final prefs = await SharedPreferences.getInstance();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await prefs.setString(_guestIdKey, id);
    _currentUser = AppUser(id: id, isGuest: true);
    notifyListeners();
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_guestIdKey);
    _currentUser = null;
    notifyListeners();
  }

  // TEMP STUBS for email/Google/Apple – they must NOT touch Firebase now:

  Future<void> signInWithGoogle() async {
    throw UnsupportedError('Google Sign-In is disabled in this build (no Firebase).');
  }

  Future<void> signInWithApple() async {
    throw UnsupportedError('Apple Sign-In is disabled in this build (no Firebase).');
  }

  Future<void> signInWithEmail(String email, String password) async {
    throw UnsupportedError('Email sign-in is disabled in this build (no Firebase).');
  }

  Future<void> signUpWithEmail(String email, String password) async {
    throw UnsupportedError('Email sign-up is disabled in this build (no Firebase).');
  }
}
