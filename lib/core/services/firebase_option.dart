// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCk9Pqg7qYSIqk07KAh9dcgyLJa3qkAmR8',
    appId: '1:806965123208:android:65a6774efd605e24fe273d',
    messagingSenderId: '806965123208',
    projectId: 'qr-app-e6b34',
    databaseURL: 'https://qr-app-e6b34-default-rtdb.firebaseio.com/',
    storageBucket: 'qr-app-e6b34.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrq7gYDF0rBaiVdyXNL70zix5Uz6VmX2o',
    appId: '1:806965123208:ios:ed0ba768265187e5fe273d',
    messagingSenderId: '806965123208',
    projectId: 'qr-app-e6b34',
    databaseURL: 'https://qr-app-e6b34-default-rtdb.firebaseio.com/',
    storageBucket: 'qr-app-e6b34.appspot.com',
    androidClientId:
        '806965123208-kl3kta0hq9upgcqgc6nphplhf8qtvkc1.apps.googleusercontent.com',
    iosClientId:
        '806965123208-bcbkdp7540dlvdbued5v9gcjkl09qu5k.apps.googleusercontent.com',
    iosBundleId: 'com.example.qrapp',
  );
}