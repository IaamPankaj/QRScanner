import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:qrapp/router.gr.dart';
import 'package:qrapp/ui/views/otp/otp_view_model.dart';

import '../../../core/models/users.dart';
import '../../../globals.dart';
import '../base_view.dart';

class OtpView extends StatelessWidget {
  final String verificationId;
  OtpView({super.key, required this.verificationId});

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  @override
  Widget build(BuildContext context) {
    return BaseView<OtpViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xfff7f6fb),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => context.popRoute(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 32,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/illustration-3.png',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Verification',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Enter your OTP code number",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            OTPTextField(
                              length: 6,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 40,
                              style: const TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                model.code = pin;
                                model.isCodeCompatible = true;
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  onVerifySumbit(model, context);
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.purple),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        "Didn't you receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  onVerifySumbit(OtpViewModel model, BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (model.isCodeCompatible) {
      var credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: model.code);
      auth.signInWithCredential(credential).then((UserCredential user) async {
        DatabaseEvent event = await ref.child(auth.currentUser!.uid).once();
        if (event.snapshot.exists) {
          await ref.child(user.user!.uid).update({
            "user_id": user.user!.uid,
          });
          AutoRouter.of(context).replaceAll([DashboardView(role: 'user')]);
        } else {
          await ref.child(user.user!.uid).set(Users(
                  name: Globals.sharedPreferences.getString("name"),
                  userId: user.user!.uid,
                  number: auth.currentUser!.phoneNumber,
                  code: Globals.sharedPreferences.getString("code"),
                  adminId: Globals.sharedPreferences.getString("adminId"),
                  createdAt: DateTime.now().toIso8601String(),
                  isProfileAdded: false,
                  role: 'user')
              .toJson());
          AutoRouter.of(context).replaceAll([ProfileView(isBottom: false)]);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }
}
