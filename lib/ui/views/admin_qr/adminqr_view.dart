import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrapp/core/models/qrRequest.dart';
import 'package:qrapp/ui/views/admin_qr/adminqr_view_model.dart';
import 'package:qrapp/ui/views/base_view.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../router.gr.dart';
import '../../widgets/notificationMessager.dart';
import '../../widgets/styled_text_field.dart';

// ignore: must_be_immutable
class AdminQrView extends StatelessWidget {
  AdminQrView({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();

  DatabaseReference ref = FirebaseDatabase.instance.ref("admin_qr");

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminQrViewModel>(
      onModelReady: (model) async {
        model.radioChange = '';
        var status = await Permission.storage.status;
        if (status.isDenied) {
          await [
            Permission.storage,
          ].request();
        }
      },
      builder: (context, model, child) => Listener(
        onPointerDown: (down) {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Add QR'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: FormBuilder(
              key: _fbKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StyledTextField(
                      labelText: "Location Name",
                      hintText: "Location Name",
                      name: 'location',
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
                      labelText: "Location Code",
                      hintText: "location Code",
                      name: 'locationCode',
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
                    FormBuilderRadioGroup(
                      onChanged: (value) {
                        model.changeRadio(value);
                      },
                      name: "radio",
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      options: const [
                        FormBuilderFieldOption(
                          value: "current",
                          child: Text("Current Location"),
                        ),
                        FormBuilderFieldOption(
                          value: "enter",
                          child: Text("Enter Location"),
                        )
                      ],
                    ),
                    if (model.radioChange == 'enter') enterLocation(),
                    GestureDetector(
                      onTap: () async {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          if (model.radioChange == 'enter') {
                            context.navigateTo(
                              GoogleMapView(
                                location: LatLng(
                                  double.parse(
                                      _fbKey.currentState?.value['latitude']),
                                  double.parse(
                                      _fbKey.currentState?.value['longitude']),
                                ),
                              ),
                            );
                          } else {
                            var location = await loc.Location().getLocation();

                            context.navigateTo(
                              GoogleMapView(
                                location: LatLng(
                                    location.latitude!, location.longitude!),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Open Map"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var req;
                          if (_fbKey.currentState!.saveAndValidate()) {
                            try {
                              EasyLoading.show(
                                  indicator: const CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                              ));
                              if (model.radioChange == 'enter') {
                                req = QRRequest(
                                  location:
                                      _fbKey.currentState?.value['location'],
                                  locationCode: _fbKey
                                      .currentState?.value['locationCode'],
                                  lat: _fbKey.currentState?.value['latitude'],
                                  long: _fbKey.currentState?.value['longitude'],
                                  auth: auth.currentUser?.uid,
                                );
                              } else {
                                var location =
                                    await loc.Location().getLocation();

                                req = QRRequest(
                                  location:
                                      _fbKey.currentState?.value['location'],
                                  locationCode: _fbKey
                                      .currentState?.value['locationCode'],
                                  lat: location.latitude.toString(),
                                  long: location.longitude.toString(),
                                  auth: auth.currentUser?.uid,
                                );
                              }

                              await ref.push().set(req.toJson());
                              context.popRoute();
                              EasyLoading.dismiss();
                            } catch (e) {
                              print(e);
                            }
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
                            'Create Qr',
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
        ),
      ),
    );
  }
}

enterLocation() {
  return Column(
    children: [
      StyledTextField(
        keyboardType: TextInputType.number,
        labelText: "Location Latitude",
        hintText: "Location Latitude",
        name: 'latitude',
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
      StyledTextField(
        keyboardType: TextInputType.number,
        labelText: "Location Longitude",
        hintText: "Location Longitude",
        name: 'longitude',
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
    ],
  );
}

YYDialog YYNoticeDialog(context, data, model) {
  WidgetsToImageController controller = WidgetsToImageController();

  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width - 100
    ..borderRadius = 10.0
    ..showCallBack = () {}
    ..dismissCallBack = () {}
    ..duration = const Duration(milliseconds: 200)
    ..widget(
      Padding(
        padding: const EdgeInsets.only(top: 21),
        child: Column(
          children: [
            WidgetsToImage(
              controller: controller,
              child: Column(children: [
                QrImage(
                  data: data,
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Cloudstrats",
                  style: TextStyle(color: Colors.purple),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final bytes = await controller.capture();

                    await model.download2(
                        bytes, true, DateTime.now().microsecond.toString());

                    notificationMessager(
                        context: context,
                        title: 'QR image donwlaoded',
                        backgroundColor: Colors.green);
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Downlaod',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    }
    ..show();
}
