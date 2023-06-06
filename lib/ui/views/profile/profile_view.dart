import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qrapp/core/models/users.dart';
import 'package:qrapp/router.gr.dart';
import 'package:qrapp/ui/views/profile/profile_view_model.dart';

import '../../../globals.dart';
import '../../widgets/styled_text_field.dart';
import '../base_view.dart';

class ProfileView extends StatelessWidget {
  final bool isBottom;
  ProfileView({super.key, required this.isBottom});

  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) async {
        model.user = Users();
        ref.child(auth.currentUser!.uid).onValue.listen((event) {
          model.getCurrentUser(event.snapshot.value);
        });
      },
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff7f6fb),
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        body: model.user.userId == null
            ? const SizedBox()
            : SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: FormBuilder(
                    key: _fbKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              StyledTextField(
                                initialValue: model.user.name,
                                labelText: "Name",
                                hintText: "Enter Name",
                                name: 'name',
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              StyledTextField(
                                labelText: "Mobile",
                                name: 'number',
                                keyboardType: TextInputType.number,
                                initialValue: model.user.number,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              StyledTextField(
                                keyboardType: TextInputType.number,
                                initialValue: model.user.code != ''
                                    ? model.user.code
                                    : null,
                                name: 'code',
                                labelText: "Employee Code",
                                hintText: "Employee Code",
                                maxLines: 1,
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

                                      await ref
                                          .child(auth.currentUser!.uid)
                                          .update({
                                        'name':
                                            _fbKey.currentState!.value['name'],
                                        'code':
                                            _fbKey.currentState!.value['code'],
                                        "isProfileAdded": true
                                      }).whenComplete(
                                              () => EasyLoading.dismiss());
                                      ;
                                      await Globals.setProfile(true);
                                      if (!isBottom) {
                                        // ignore: use_build_context_synchronously

                                        AutoRouter.of(context).replaceAll([
                                          DashboardView(
                                              role: model.user.role ?? 'user')
                                        ]);
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
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        isBottom == true
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await auth.signOut();
                                    if (context.mounted) {
                                      AutoRouter.of(context)
                                          .replaceAll([const WelcomeView()]);
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
                                      'Log Out',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
