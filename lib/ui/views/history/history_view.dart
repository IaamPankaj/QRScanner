// ignore_for_file: depend_on_referenced_packages
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qrapp/globals.dart';
import 'package:intl/intl.dart';
import '../../../core/models/history.dart';
import '../../../router.gr.dart';
import '../../widgets/bottom_sheet.dart';
import '../base_view.dart';
import 'history_view_model.dart';

// ignore: must_be_immutable
class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  DatabaseReference ref = FirebaseDatabase.instance.ref("history");
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BaseView<HistroyViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color(0xfff7f6fb),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: StreamBuilder(
            stream: ref
                .orderByChild('user_id')
                .equalTo(auth.currentUser?.uid)
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.data?.snapshot.value == null) {
                return const SizedBox();
              }
              Map<dynamic, dynamic> map =
                  Globals().convertMap(snapshot.data?.snapshot.value);
              List<History> list = [];
              map.forEach((key, value) {
                list.add(History.fromJson(value));
              });
              list.sort((a, b) => DateTime.parse(a.createdAt!)
                  .compareTo(DateTime.parse(b.createdAt!)));
              return ListView.builder(
                itemBuilder: (context, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      onTap: () {
                        YYBottomSheetDialog(context, bottom(list[i]));
                      },
                      trailing: Icon(
                        list[i].status == true
                            ? Icons.check_circle
                            : Icons.cancel,
                        color:
                            list[i].status == true ? Colors.green : Colors.red,
                        size: 28,
                      ),
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Text(list[i].locationCode!),
                      subtitle: Text(DateFormat('yyyy-MM-dd - hh:mm a')
                          .format(DateTime.parse(list[i].createdAt!))),
                    ),
                  );
                },
                itemCount: list.length,
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () async {
            context.navigateTo(ScannerView());
          },
        ),
      ),
    );
  }

  Widget bottom(History history) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bottomTextTile("Location", history.location),
          bottomTextTile("Location Code", history.locationCode),
          bottomTextTile("Latitude", history.lat),
          bottomTextTile("Langtude", history.long),
          bottomTextTile(
              "Status", history.status == true ? "Verify" : "Not Verify"),
          bottomTextTile("Distance", '${history.distance} meter'),
        ],
      ),
    );
  }

  Widget bottomTextTile(key, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '$key: $value',
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
