import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qrapp/core/models/users.dart';
import 'package:qrapp/router.gr.dart';
import 'package:qrapp/ui/views/admin_home/admin_home_view_model.dart';
import 'package:qrapp/ui/views/base_view.dart';

import '../../../globals.dart';

class AdminHomeView extends StatelessWidget {
  AdminHomeView({super.key});
  final jsonEncoder = const JsonEncoder();

  DatabaseReference ref = FirebaseDatabase.instance.ref("saved_user");
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminHomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('User managment'),
          actions: [
            TextButton(
              onPressed: () {
                context.navigateTo(ManageUserView());
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
              stream: ref
                  .orderByChild('admin_id')
                  .equalTo(auth.currentUser?.uid)
                  .onValue,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data?.snapshot.value == null) {
                  return const SizedBox();
                }
                Map<dynamic, dynamic> map =
                    Globals().convertMap(snapshot.data?.snapshot.value ?? {});
                List<Users> user = [];
                map.forEach((key, value) {
                  user.add(Users.fromJson(value));
                });
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.data.length,
                  itemBuilder: (context, index) {
                    var item = [];
                    if (snapshot.data?.snapshot.value != null) {
                      item = user
                          .where((e) => e.role == model.data[index]["role"])
                          .toList();
                    }

                    return ExpansionTile(
                        title: Text(model.data[index]["value"]),
                        children: [
                          ...item.map(
                            (e) => Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (ctx) {},
                                        backgroundColor:
                                            const Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ),
                                      SlidableAction(
                                        onPressed: (ctx) {
                                          ref.child(e.userId!).remove();
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ]),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                        e?.name?.toString().split(" ")[0][0] ??
                                            ''),
                                  ),
                                  title: Text(e.name!),
                                  subtitle: Text(e.code ?? "0"),
                                )),
                          )
                        ]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
