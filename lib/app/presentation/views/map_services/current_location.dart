import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurHomePage extends StatefulWidget {
  const GetCurHomePage({super.key});

  @override
  State<GetCurHomePage> createState() => _GetCurHomePageState();
}

class _GetCurHomePageState extends State<GetCurHomePage> {
  final Completer<GoogleMapController> _completer = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(23.852278571860534, 90.41350899121275),
    zoom: 14.46,
  );

  final List<Marker> _marker = [
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(23.852278571860534, 90.41350899121275),
        infoWindow:
        InfoWindow(title: "Hajj camp", snippet: "Motaleb Room Location")),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(23.84936933091486, 90.42492746507943),
        infoWindow: InfoWindow(
            title: "Northearn University Bangladesh",
            snippet: "Parmanent Cumpase")),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(23.864576508310417, 90.39249163809531),
        infoWindow: InfoWindow(title: "It way bd", snippet: "Motaleb office")),
  ];

  void locationAddress() {}

  List<Marker> _list = [];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((e, error) {
      print(e.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
    _marker.addAll(_list);

    loaddata();
  }

  loaddata() {
    getUserCurrentLocation().then((value) async {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(value.latitude, value.longitude);
      setState(() {
        print(value.latitude.toString());
        print(value.longitude.toString());
        print("${placemarks.last.country.toString()}");
      });

      _marker.add(Marker(
          markerId: MarkerId("3"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: placemarks.last.country.toString(),
            snippet:
            "${placemarks.last.country.toString()},${placemarks.last.street.toString()}",
          )));

      GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14.4746,
        ),
      ));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _cameraPosition,
        myLocationButtonEnabled: false,
        markers: Set.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          loaddata();
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
