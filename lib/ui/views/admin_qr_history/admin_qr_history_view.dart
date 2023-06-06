import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qrapp/core/models/qrRequest.dart';
import 'package:qrapp/router.gr.dart' as r;
import 'package:qrapp/ui/views/admin_qr_history/admin_qr_history_view_model.dart';
import 'package:qrapp/ui/views/base_view.dart';

import '../../../globals.dart';
import '../admin_qr/adminqr_view.dart';

class AdminQrHistoryView extends StatelessWidget {
  AdminQrHistoryView({super.key});

  DatabaseReference ref = FirebaseDatabase.instance.ref("admin_qr");
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminQrHistoryViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Qr Management"),
            actions: [
              TextButton(
                onPressed: () {
                  context.navigateTo(r.AdminQrView());
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: StreamBuilder(
            stream:
                ref.orderByChild('auth').equalTo(auth.currentUser?.uid).onValue,
            builder: (context, snapshot) {
              if (snapshot.data?.snapshot.value == null) {
                return const SizedBox();
              }
              Map<dynamic, dynamic> map =
                  Globals().convertMap(snapshot.data?.snapshot.value);
              List<QRRequest> list = [];
              map.forEach((key, value) {
                value['id'] = key;
                list.add(QRRequest.fromJson(value));
              });

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var value = list[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (ctx) {
                            ref.child(value.id!).remove();
                            print(value.id);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                      child: ListTile(
                        title: Text(list[index].location.toString()),
                        subtitle: Text(list[index].locationCode.toString()),
                        trailing: GestureDetector(
                            onTap: () {
                              String reqData =
                                  "${value.location!},${value.locationCode!},${value.lat!},${value.long!},${value.auth!}";

                              YYNoticeDialog(context, reqData, model);
                            },
                            child: const Icon(Icons.download)),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
