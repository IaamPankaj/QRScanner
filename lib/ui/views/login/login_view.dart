import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qrapp/router.gr.dart';
import 'package:qrapp/ui/views/login/login_view_model.dart';
import '../../../globals.dart';
import '../../widgets/styled_text_field.dart';
import '../base_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  DatabaseReference ref = FirebaseDatabase.instance.ref("saved_user");
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xfff7f6fb),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: FormBuilder(
                    key: _fbKey,
                    child: SingleChildScrollView(
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
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/illustration-2.png',
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Registration',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Add your phone number. we'll send you a verification code so we know you're real",
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
                                StyledTextField(
                                  keyboardType: TextInputType.number,
                                  name: 'number',
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (val) {
                                    if (val!.length < 10) {
                                      return "Please enter valid number";
                                    }
                                  },
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '(+91)',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_fbKey.currentState!
                                          .saveAndValidate()) {
                                        var val = await ref
                                            .orderByChild('number')
                                            .equalTo(_fbKey
                                                .currentState!.value['number'])
                                            .once();

                                        if (!val.snapshot.exists) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "User not register",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }

                                        Map<dynamic, dynamic> map = Globals()
                                            .convertMap(val.snapshot.value);
                                        map.forEach((key, value) {
                                          Globals.sharedPreferences.setString(
                                              "adminId", value["admin_id"]);
                                          Globals.sharedPreferences
                                              .setString("name", value["name"]);
                                          Globals.sharedPreferences
                                              .setString("code", value["code"]);
                                        });

                                        EasyLoading.show(
                                            indicator:
                                                const CircularProgressIndicator());
                                        await FirebaseAuth.instance
                                            .verifyPhoneNumber(
                                              timeout:
                                                  const Duration(seconds: 60),
                                              phoneNumber:
                                                  '+91${_fbKey.currentState!.value['number']}',
                                              verificationCompleted:
                                                  (PhoneAuthCredential
                                                      credential) {},
                                              verificationFailed:
                                                  (FirebaseAuthException e) {
                                                print(e);
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) {
                                                context.navigateTo(OtpView(
                                                    verificationId:
                                                        verificationId));
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (String verificationId) {},
                                            )
                                            .whenComplete(
                                                () => EasyLoading.dismiss())
                                            .catchError((error, stackTrace) =>
                                                {EasyLoading.dismiss()});
                                      }
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
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text(
                                        'Send',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
