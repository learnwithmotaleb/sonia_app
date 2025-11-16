import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sonia_app/google_map/assets/map_icons.dart';

class Part9 extends StatefulWidget {
  const Part9({super.key});

  @override
  State<Part9> createState() => _Part9State();
}

class _Part9State extends State<Part9> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(22.3569, 91.7832),
    zoom: 5.6,
  );

  Uint8List? uint8list;

  List _imageList = [
    MapIcons.bicycle,
    MapIcons.bycicle,
    MapIcons.bus,
    MapIcons.car,
    MapIcons.location,
    MapIcons.placeholder,
    MapIcons.placeholder2,
    MapIcons.walk,
  ];
  List<Marker> _marker = [];
  List<LatLng> _latlang = [
    LatLng(22.3569, 91.7832),
    LatLng(24.3636, 88.6241),
    LatLng(23.8103, 90.4125),
    LatLng(22.8456, 89.5403),
    LatLng(22.7010, 90.3535),
    LatLng(24.8949, 91.8687),
    LatLng(25.7558, 89.2440),
    LatLng(24.7471, 90.4203),
  ];
  List<String> _placeTitle = [
    "Dhaka",
    "Chattogram",
    "Khulna",
    "Rajshahi",
    "Barishal",
    "Sylhet",
    "Rangpur",
    "Mymensingh"
  ];
  List<String> _placeSubTitle = [
    "The Heart of Bangladesh – Capital, Commerce & Connectivity",
    "Gateway to the Sea – Trade, Hills & Coastal Beauty",
    "Land of the Sundarbans – Forest, Fisheries & Industry",
    "The Silk City – Education, Agriculture & Heritage",
    "Venice of the East – Rivers, Boats & Delta Life",
    "Tea Capital – Hills, Haors & Natural Charm",
    "The Northern Frontier – Simplicity, Nature & Agriculture",
    "Cultural Hub – Education, Tradition & Riverine Beauty",

  ];


  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Uint8List> getByteFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(), // ✅ fixed here
      targetWidth: width,        // ✅ also changed to targetWidth
    );
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!
        .buffer
        .asUint8List();
  }

  loadData() async{
    for (int i = 0; i < _latlang.length; i++) {
      final Uint8List markerIcon = await getByteFromAssets(_imageList[i], 100);
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlang[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(

              title: _placeTitle[i],
          snippet: _placeSubTitle[i]),
        ),
      );
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: cameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
