import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Part1 extends StatefulWidget {
  const Part1({super.key});

  @override
  State<Part1> createState() => _Part1State();
}

class _Part1State extends State<Part1> {
  static final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(25.7558, 89.2440),
    zoom: 14.4746,
  );

  Completer<GoogleMapController> _completer = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        // mapType: MapType.normal,
        // mapToolbarEnabled: true,
        // myLocationButtonEnabled: true,
        // compassEnabled: true,
        // myLocationEnabled: true,
        // zoomControlsEnabled: false,
        //liteModeEnabled: true,
        // myLocationButtonEnabled: true,
        // buildingsEnabled: true,
        //trafficEnabled: true,
        //fortyFiveDegreeImageryEnabled: true,
        indoorViewEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
