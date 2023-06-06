import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qrapp/globals.dart';
import 'package:qrapp/ui/views/admin_signup/admin_signup_viewmodel.dart';
import 'package:qrapp/ui/views/base_view.dart';
import 'package:qrapp/ui/widgets/styled_text_field.dart';

import '../../../core/models/users.dart';
import '../../../router.gr.dart';

class AdminSignUpView extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  @override
  Widget build(BuildContext context) {
    return BaseView<AdminSignUpViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FormBuilder(
              key: _fbKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 10),
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
                    Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          StyledTextField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Enter first name';
                                }
                                return null;
                              },
                              hintText: 'First Name ',
                              name: 'first_name'),
                          const SizedBox(
                            height: 10,
                          ),
                          StyledTextField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Enter Last name';
                                }
                                return null;
                              },
                              hintText: 'Last Name ',
                              name: 'last_name'),
                          const SizedBox(
                            height: 10,
                          ),
                          StyledTextField(
                            validator: (value) {
                              if (value == null) {
                                return 'Enter email address';
                              }

                              if (RegExp(RegexConst.email).hasMatch(value)) {
                                return model.toggleEmailValidation(true);
                              } else {
                                return "Email address is not valid  ";
                              }
                            },
                            hintText: 'Enter email address',
                            name: 'email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StyledTextField(
                            obscureText: true,
                            validator: (val) {
                              if (val == null) {
                                return 'Create password.';
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
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  EasyLoading.show(
                                      indicator:
                                          const CircularProgressIndicator());
                                  UserCredential user = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: _fbKey
                                              .currentState!.value['email'],
                                          password: _fbKey
                                              .currentState!.value['password']);
                                  if (user.user?.uid != null) {
                                    await ref
                                        .child(user.user!.uid)
                                        .set(Users(
                                                name: _fbKey.currentState!
                                                        .value['first_name'] +
                                                    " " +
                                                    _fbKey.currentState!
                                                        .value['last_name'],
                                                userId: user.user!.uid,
                                                email: user.user!.email,
                                                code: '',
                                                role: "admin",
                                                createdAt: DateTime.now()
                                                    .toIso8601String(),
                                                isProfileAdded: false)
                                            .toJson())
                                        .whenComplete(
                                            () => EasyLoading.dismiss())
                                        .catchError((error, stackTrace) =>
                                            // ignore: invalid_return_type_for_catch_error
                                            {EasyLoading.dismiss()});

                                    // ignore: use_build_context_synchronously
                                    AutoRouter.of(context).replaceAll(
                                        [ProfileView(isBottom: false)]);
                                  }
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
                                    borderRadius: BorderRadius.circular(24.0),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
