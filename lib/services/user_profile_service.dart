import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class UserProfileService {
  UserProfileService._();
  static final UserProfileService instance = UserProfileService._();

  static const String _prefsKeyPrefix = 'user_profile_';

  final ValueNotifier<UserProfile> profileNotifier = ValueNotifier<UserProfile>(UserProfile.empty);

  String? _activeUserId;

  Future<void> ensureLoaded(String userId) async {
    if (_activeUserId == userId) {
      return;
    }
    _activeUserId = userId;
    profileNotifier.value = await _loadFromPrefs(userId);
  }

  Future<UserProfile> _loadFromPrefs(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('$_prefsKeyPrefix$userId');
    if (stored == null) {
      return UserProfile.empty;
    }
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      return UserProfile.fromJson(map);
    } catch (_) {
      return UserProfile.empty;
    }
  }

  Future<void> saveProfile(String userId, UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefsKeyPrefix$userId', jsonEncode(profile.toJson()));
    _activeUserId = userId;
    profileNotifier.value = profile;
  }

  void clearCache() {
    _activeUserId = null;
    profileNotifier.value = UserProfile.empty;
  }
}
