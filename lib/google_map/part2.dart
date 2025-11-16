import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Part2 extends StatefulWidget {
  const Part2({super.key});

  @override
  State<Part2> createState() => _Part2State();
}

class _Part2State extends State<Part2> {
  Completer<GoogleMapController> _completer = Completer();
  List<Marker> _markerList = [];

  List<Marker> _list = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(22.3569, 91.7832),
      infoWindow: InfoWindow(title: "Chattogram", snippet: "Capital of Chattogram division"),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(24.3636, 88.6241),
      infoWindow: InfoWindow(title: "Rajshahi", snippet: "Rajshahi is a division of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(23.8103, 90.4125),
      infoWindow: InfoWindow(title: "Dhaka", snippet: "Dhaka is the capital of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("4"),
      position: LatLng(22.8456, 89.5403),
      infoWindow: InfoWindow(title: "Khulna", snippet: "Khulna is a division of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("5"),
      position: LatLng(22.7010, 90.3535),
      infoWindow: InfoWindow(title: "Barishal", snippet: "Barishal is a division of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("6"),
      position: LatLng(24.8949, 91.8687),
      infoWindow: InfoWindow(title: "Sylhet", snippet: "Sylhet is a division of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("7"),
      position: LatLng(25.7558, 89.2440),
      infoWindow: InfoWindow(title: "Rangpur", snippet: "Rangpur is a division of Bangladesh"),
    ),
    Marker(
      markerId: MarkerId("8"),
      position: LatLng(24.7471, 90.4203),
      infoWindow: InfoWindow(title: "Mymensingh", snippet: "Mymensingh is a division of Bangladesh"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _markerList.addAll(_list);
  }

  LatLngBounds _calculateBounds(List<Marker> markers) {
    final latitudes = markers.map((m) => m.position.latitude);
    final longitudes = markers.map((m) => m.position.longitude);

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce((a, b) => a < b ? a : b),
          longitudes.reduce((a, b) => a < b ? a : b)),
      northeast: LatLng(latitudes.reduce((a, b) => a > b ? a : b),
          longitudes.reduce((a, b) => a > b ? a : b)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: _markerList[0].position,
          zoom: 6.5,
        ),
        markers: Set.of(_markerList),
        onMapCreated: (GoogleMapController controller) async {
          _completer.complete(controller);
          await Future.delayed(const Duration(milliseconds: 300));
          final bounds = _calculateBounds(_markerList);
          controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
        },
      ),
    );
  }
}
