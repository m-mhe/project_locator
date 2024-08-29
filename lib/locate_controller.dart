import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateController extends GetxController {
  Position? userPosition;
  List<LatLng> myLocations = [];

  Future<void> locateUser() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      bool locationEnable = await Geolocator.isLocationServiceEnabled();
      if (locationEnable) {
        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          timeLimit: Duration(seconds: 10),
        )).listen((p) {
          userPosition = p;
          myLocations.add(LatLng(p.latitude, p.longitude));
          update();
        });
      } else {
        await Geolocator.openLocationSettings();
        locateUser();
      }
    } else {
      await Geolocator.requestPermission();
      locateUser();
    }
  }
}
