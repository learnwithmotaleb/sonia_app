import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Part11 extends StatefulWidget {
  const Part11({super.key});

  @override
  State<Part11> createState() => _Part11State();
}

class _Part11State extends State<Part11> {
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(23.809584130490542, 90.39795374910271), // Center of Dhaka
    zoom: 12,
  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId("dhaka"),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: "Dhaka",
        snippet: "Dhaka is the capital of Bangladesh",
      ),
      position: LatLng(23.809584130490542, 90.39795374910271),
    )
  ];

  final Set<Polygon> _polygon = {
    Polygon(
      polygonId: PolygonId('area_polygon'),
      points: [
        LatLng(23.881361619979852, 90.3953925033889),
        LatLng(23.883241225235935, 90.41224849237327),
        LatLng(23.89971730055738, 90.43756360817126),
        LatLng(23.89971730055738, 90.43756360817126),
        LatLng(23.894185511106482, 90.45762223358142),
        LatLng(23.886651732663, 90.45899552459709),
        LatLng(23.885082140261986, 90.45899552459709),
        LatLng(23.881315040813856, 90.46105546112057),
        LatLng(23.861221991983758, 90.47444504852338),
        LatLng(23.842695951019095, 90.47238511199987),
        LatLng(23.841233667623307, 90.47256432242669),
        LatLng(23.831819426536452, 90.48189157231526),
        LatLng(23.831525220490942, 90.48639438260629),
        LatLng(23.82534673939917, 90.48735927052579),
        LatLng(23.807692315265758, 90.48382134815427),
        LatLng(23.791801281126737, 90.48028342578274),
        LatLng(23.7835607204974, 90.47063454658769),
        LatLng(23.779145919562733, 90.4738508396527),
        LatLng(23.72571596840939, 90.50001026527755),
        LatLng(23.718957014351563, 90.50106494440382),
        LatLng(23.881361619979852, 90.3953925033889),


      ],
      strokeColor: Colors.red,
      strokeWidth: 1,
      fillColor: Colors.grey.withOpacity(0.2),       // Border width
      consumeTapEvents: true,
    )
  };

  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set.of(_marker),
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
