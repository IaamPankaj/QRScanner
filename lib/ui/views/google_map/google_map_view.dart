// ignore_for_file: prefer_collection_literals

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../base_view.dart';
import 'google_map_view_model.dart';

class GoogleMapView extends StatelessWidget {
  GoogleMapView({super.key, required this.location});

  final LatLng location;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return BaseView<GoogleMapViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              markers: model.markers,
              onTap: (locationData) {
                model.setMarker(Marker(
                  markerId: const MarkerId("google maps"),
                  position:
                      LatLng(locationData.latitude, locationData.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(0.0),
                  infoWindow: const InfoWindow(
                    title: 'title',
                    snippet: 'address',
                  ),
                ));
              },
              initialCameraPosition: model.kGooglePlex,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);

                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(location.latitude, location.longitude),
                  zoom: 14.4746,
                )));

                model.setMarker(Marker(
                  markerId: const MarkerId("first_location"),
                  position: LatLng(location.latitude, location.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(0.0),
                  infoWindow: const InfoWindow(
                    title: 'title',
                    snippet: 'address',
                  ),
                ));
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      context.popRoute();
                    },
                    icon: const Icon(Icons.arrow_back))),
          ],
        ),
      ),
    );
  }
}
