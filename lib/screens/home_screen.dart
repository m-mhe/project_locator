import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_locator/locate_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _googleMapController;

  @override
  void initState() {
    Get.find<LocateController>().locateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add_location_alt_rounded),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          'Locator',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: GetBuilder<LocateController>(builder: (controller) {
          return GoogleMap(
            polylines: <Polyline>{
              Polyline(
                  polylineId: PolylineId("draw"),
                  points: controller.myLocations,
                  color: Colors.orange)
            },
            onCameraIdle: () async {
                await Future.delayed(Duration(seconds: 2));
                _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(controller.userPosition?.latitude ?? 0,
                        controller.userPosition?.longitude ?? 0),
                    19));
            },
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(controller.userPosition?.latitude ?? 22.37,
                  controller.userPosition?.longitude ?? 91.84),
            ),
            markers: <Marker>{
              Marker(
                markerId: MarkerId("LOL"),
                position: LatLng(controller.userPosition?.latitude ?? 22.37,
                    controller.userPosition?.longitude ?? 91.84),
                draggable: false,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                infoWindow: InfoWindow(
                    title: "My current location",
                    snippet:
                        "${controller.userPosition?.latitude ?? 0}, ${controller.userPosition?.longitude ?? 0}"),
              )
            },
          );
        }),
      ),
    );
  }
}
