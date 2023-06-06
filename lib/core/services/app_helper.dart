import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrapp/globals.dart';

abstract class AppHelper {
  static firstRunCheck() async {
    const String hasRunBeforePrefKey = 'localStorage.hasRunBefore';
    final bool hasRunBefore =
        Globals.sharedPreferences.getBool(hasRunBeforePrefKey) ?? false;
    if (hasRunBefore) {
      return;
    }
    await Globals.sharedPreferences.setBool(hasRunBeforePrefKey, true);

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
