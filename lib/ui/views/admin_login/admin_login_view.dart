import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qrapp/core/qr_app_icons.dart';
import 'package:qrapp/core/svg_icon.dart';
import 'package:qrapp/globals.dart';
import 'package:qrapp/locator.dart';
import 'package:qrapp/router.gr.dart';
import 'package:qrapp/ui/views/admin_login/admin_login_viewmodel.dart';
import 'package:qrapp/ui/views/login/login_view_model.dart';
import '../../widgets/styled_text_field.dart';
import '../base_view.dart';

class AdminLoginScreenView extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  AdminLoginScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<AdminLoginScreenViewModel>(
        builder: (context, model, child) => Listener(
              onPointerDown: (e) {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color(0xfff7f6fb),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 32),
                    child: FormBuilder(
                      key: _fbKey,
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
                          Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                StyledTextField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Enter email address';
                                    }

                                    if (RegExp(RegexConst.email)
                                        .hasMatch(value)) {
                                      return model.toggleEmailValidation(true);
                                    } else {
                                      return "Email address is not valid  ";
                                    }
                                  },
                                  hintText: 'Enter email address',
                                  name: 'email',
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                StyledTextField(
                                  obscureText: true,
                                  suffixIcon: const SvgIcon(
                                    QrappIcons.eye1,
                                    color: Colors.red,
                                    size: 17,
                                  ),
                                  validator: (val) {
                                    if (val == null) {
                                      return 'Enter password.';
                                    }

                                    if (val.length < 8) {
                                      return "Password should be at least 8 characters";
                                    }

                                    return null;
                                  },
                                  hintText: 'Enter Password',
                                  name: 'password',
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
                                        EasyLoading.show(
                                            indicator:
                                                const CircularProgressIndicator());
                                        auth
                                            .signInWithEmailAndPassword(
                                                email: _fbKey.currentState
                                                    ?.value['email'],
                                                password: _fbKey.currentState
                                                    ?.value['password'])
                                            .then((value) async {
                                              if (value.user != null) {
                                                DatabaseEvent event = await ref
                                                    .child(value.user!.uid)
                                                    .once();

                                                var data = Globals().convertMap(
                                                    event.snapshot.value);

                                                if (data['isProfileAdded'] ==
                                                    false) {
                                                  AutoRouter.of(context)
                                                      .replaceAll([
                                                    ProfileView(isBottom: false)
                                                  ]);
                                                } else {
                                                  AutoRouter.of(context)
                                                      .replaceAll([
                                                    DashboardView(role: 'admin')
                                                  ]);
                                                }
                                              }
                                            })
                                            .whenComplete(
                                                () => EasyLoading.dismiss())
                                            .catchError((error, stackTrace)
                                                // ignore: invalid_return_type_for_catch_error
                                                {
                                              EasyLoading.dismiss();
                                            });
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
                                        'Submit',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FittedBox(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text(
                                  "Dont't have account ?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.navigateTo(const AdminSignUpView());
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.purple, fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
