import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrapp/globals.dart';
import 'package:qrapp/ui/views/dashboard/dashboard_view.dart';
import 'package:qrapp/ui/views/root/root_view_model.dart';
import 'package:qrapp/ui/views/welcome/welcome_view.dart';
import '../base_view.dart';
import 'package:location/location.dart';

import '../profile/profile_view.dart';
import '../welcome/flash_screen.dart';

// ignore: must_be_immutable
class RoorApp extends StatelessWidget {
  RoorApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  @override
  Widget build(BuildContext context) {
    return BaseView<RootViewModel>(
      onModelReady: (model) async {
        await getLocation();
        if (auth.currentUser?.uid != null) {
          ref.child(auth.currentUser!.uid).onValue.listen((event) {
            Future.delayed(const Duration(milliseconds: 1300))
                .then((value) => model.getCurrentUser(event.snapshot.value));
          });
        }
      },
      builder: (context, model, child) => Builder(
        builder: (BuildContext context) {
          if (auth.currentUser?.uid != null) {
            if (Globals.getProfile()) {
              return model.user.userId == null
                  ? const FlashScreen()
                  : DashboardView(
                      role: model.user.role ?? 'user',
                    );
            } else {
              return ProfileView(
                isBottom: false,
              );
            }
          } else {
            return const WelcomeView();
          }
        },
      ),
    );
  }

  Future getLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
