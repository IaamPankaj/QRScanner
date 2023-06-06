import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qrapp/core/models/users.dart';
import 'package:qrapp/globals.dart';
import 'package:qrapp/ui/views/mange_user/manage_user_view_model.dart';

import '../../widgets/styled_text_field.dart';
import '../base_view.dart';

class ManageUserView extends StatelessWidget {
  ManageUserView({super.key});

  static final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>(
      debugLabel: DateTime.now().millisecond.toString());

  final FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref("saved_user");
  @override
  Widget build(BuildContext context) {
    return BaseView<ManageUserViewModel>(
      onModelReady: (model) {
        model.roleToggle = '';
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Manage User'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: FormBuilder(
              key: _fbKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StyledTextField(
                      labelText: "Name",
                      hintText: "Name",
                      name: 'name',
                      validator: (text) {
                        if (text == null) {
                          return 'Required';
                        }
                        if (text == '') {
                          return 'Required';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    StyledTextField(
                      keyboardType: TextInputType.number,
                      labelText: "Code",
                      hintText: "Code",
                      name: 'code',
                      maxLines: 1,
                      validator: (text) {
                        if (text == null) {
                          return 'Required';
                        }
                        if (text == '') {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FormBuilderDropdown(
                      name: "role",
                      items: [
                        DropdownMenuItem(
                          onTap: () {
                            model.roleToggleModifier('admin');
                          },
                          value: "admin",
                          child: const Text('Admin'),
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            model.roleToggleModifier('user');
                          },
                          value: "user",
                          child: const Text('User'),
                        ),
                      ],
                      decoration: InputDecoration(
                          counter: const SizedBox(),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (model.roleToggle == 'admin')
                      StyledTextField(
                        keyboardType: TextInputType.text,
                        labelText: "Email",
                        hintText: "Email",
                        name: 'email',
                        validator: (value) {
                          if (value == null) {
                            return 'Enter valid email address';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                    if (model.roleToggle == 'user')
                      StyledTextField(
                        keyboardType: TextInputType.phone,
                        labelText: "Number",
                        hintText: "Number",
                        name: 'number',
                        maxLength: 10,
                        validator: (value) {
                          if (value == null) {
                            return 'Enter phone number';
                          }
                        },
                        maxLines: 10,
                      ),
                    if (model.roleToggle != '')
                      const SizedBox(
                        height: 15,
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_fbKey.currentState!.saveAndValidate()) {
                            var val = await ref
                                .orderByChild(model.roleToggle == "admin"
                                    ? "email"
                                    : 'number')
                                .equalTo(model.roleToggle == "admin"
                                    ? _fbKey.currentState!.value["email"]
                                    : _fbKey.currentState!.value['number'])
                                .once();

                            if (val.snapshot.exists) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "User already exist!!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            EasyLoading.show(
                                indicator: const CircularProgressIndicator());
                            var value = _fbKey.currentState!.value;
                            Users users = Users(
                              name: value["name"],
                              code: value["code"],
                              email: value["email"],
                              number: value["number"],
                              role: value["role"],
                              isProfileAdded: false,
                              adminId: auth.currentUser!.uid,
                              userId: Globals().generateRandomString(10),
                            );

                            await ref
                                .child(users.userId!)
                                .set(users.toJson())
                                .whenComplete(() => context
                                    .popRoute()
                                    .whenComplete(() => EasyLoading.dismiss()));
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Add User',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
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
