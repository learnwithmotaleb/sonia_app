import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveLocation extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;


   const LiveLocation({
    super.key,
     required this.latitude,
     required this.longitude, required this.title,
  });

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  Completer<GoogleMapController> _completer = Completer();



  @override
  Widget build(BuildContext context) {
    final Marker _marker = Marker(
      markerId: MarkerId("22"),
      position: LatLng(widget.latitude, widget.longitude), // Example: Dhaka
      infoWindow: InfoWindow(title: widget.title, snippet: widget.title),
    );
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.4546
      ),
        onMapCreated: (GoogleMapController controller){
            _completer.complete(controller);
        },
        markers: {_marker},
      ),
    );
  }
}
