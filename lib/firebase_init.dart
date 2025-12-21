import 'package:flutter/foundation.dart';

class FirebaseInit {
  static Future<void> init() async {
    // Temporarily disabled: running app in offline/guest mode without Firebase.
    debugPrint('FirebaseInit: skipped (offline mode).');
  }
}
