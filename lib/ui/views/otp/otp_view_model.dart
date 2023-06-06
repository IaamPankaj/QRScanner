import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';

@lazySingleton
class OtpViewModel extends BaseViewModel {
  String code = '';
  bool isCodeCompatible = false;

  authenticate(value, BuildContext context) async {
    EasyLoading.show(indicator: const CircularProgressIndicator());
    await FirebaseAuth.instance
        .verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: '+91${value['number']}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        )
        .whenComplete(() => EasyLoading.dismiss())
        .catchError((error, stackTrace) => {EasyLoading.dismiss()});
  }

  resendVerification(value) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${value['number']}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }
}
