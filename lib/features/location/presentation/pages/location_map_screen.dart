import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khosousi_online/core/utils/services/location_service.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
late CameraPosition _initialCameraPosition;
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

      @override
      void initState() {
        super.initState();
 LocationService.getLocationCoords().then((value) {
  // _initialCameraPosition = CameraPosition(
  //         target: _userCurrentLocation, zoom: 15.0, tilt: 0, bearing: 0);
  //     Marker _currentLocationMarker = Marker(
  //         markerId: const MarkerId('userLocation'),
  //         icon: BitmapDescriptor.fromBytes(markerIcon!),
  //         infoWindow: const InfoWindow(title: 'أنت هنا'),
  //         position: _userCurrentLocation);
 });
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(

        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }



  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
