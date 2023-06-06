// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:haversine_distance/haversine_distance.dart' as Hv;
import 'package:qrapp/ui/views/scanner/scanner_view_model.dart';
import '../../../core/models/history.dart';
import '../../../core/models/qrRequest.dart';
import '../../widgets/notificationMessager.dart';
import '../base_view.dart';

// ignore: must_be_immutable
class ScannerView extends StatelessWidget {
  ScannerView({super.key});

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DatabaseReference ref = FirebaseDatabase.instance.ref("history");
  FirebaseAuth auth = FirebaseAuth.instance;
  Location location = Location();
  Hv.HaversineDistance haversineDistance = Hv.HaversineDistance();

  @override
  Widget build(BuildContext context) {
    return BaseView<ScannerViewModel>(
      onModelReady: (model) async {
        await location.changeSettings(
          accuracy: LocationAccuracy.high,
          interval: 1000,
          distanceFilter: 0,
        );
      },
      onModelClose: (model) {
        controller!.dispose();
      },
      builder: (context, model, child) => Stack(
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: 100,
              color: Colors.grey.shade900.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller!.flipCamera();
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.flip_camera_ios,
                        size: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller!.toggleFlash();
                      model.toggleFlash(await controller!.getFlashStatus());
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        model.flashStatus ? Icons.flash_on : Icons.flash_off,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: (ctr) => _onQRViewCreated(ctr, context),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
      context.popRoute();
    }
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.first.then((scanData) async {
      EasyLoading.show(indicator: const CircularProgressIndicator());
      var coordinate = await location.getLocation();

      var data = scanData.code!.split(',');

      var scan = QRRequest(
        location: data[0],
        locationCode: data[1],
        lat: data[2],
        long: data[3],
        auth: data[4],
      );

      final startCoordinate =
          Hv.Location(double.parse(scan.lat!), double.parse(scan.long!));

      final endCoordinate =
          Hv.Location(coordinate.latitude!, coordinate.longitude!);

      final distance = haversineDistance
          .haversine(startCoordinate, endCoordinate, Hv.Unit.METER)
          .floor();

      var status = false;

      if (distance <= 10) {
        status = true;
      }

      await ref.push().set(History(
            location: scan.location,
            locationCode: scan.locationCode,
            lat: scan.lat,
            long: scan.long,
            status: status,
            auth: scan.auth,
            userId: auth.currentUser!.uid,
            distance: distance.toString(),
            createdAt: DateTime.now().toIso8601String(),
            floor: (coordinate.verticalAccuracy! / 1.4).round().toString(),
          ).toJson());

      if (status) {
        notificationMessager(
            context: context,
            title: 'Location verified',
            backgroundColor: Colors.green);
      } else {
        notificationMessager(
            context: context,
            title: 'Location not verified',
            backgroundColor: Colors.red);
      }
      EasyLoading.dismiss();
      context.popRoute();
    });
  }
}
