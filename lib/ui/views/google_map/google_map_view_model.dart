import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';

@lazySingleton
class GoogleMapViewModel extends BaseViewModel {
  Set<Marker> markers = <Marker>{};

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  setMarker(marker) {
    markers.add(marker);
    notifyListeners();
  }
}
