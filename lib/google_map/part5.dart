import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Part5 extends StatefulWidget {
  const Part5({super.key});

  @override
  State<Part5> createState() => _Part5State();
}

class _Part5State extends State<Part5> {

  static final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(22.3569, 91.7832),
      zoom: 5.6
  );

  Completer<GoogleMapController> _completer = Completer();

  List<Marker> _markerList = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(22.3569, 91.7832),
      infoWindow: InfoWindow(title: "Chattogram", snippet: "Capital of Chattogram division"),
    ),

  ];

  var lat;
  var lng;

  @override
  void initState() {
    super.initState();
    _markerList.addAll(_list);

    fetchLocation();
    getCurrentLocation().then((value)async{
      lat = value!.longitude.toString();
      lng = value!.longitude.toString();

      GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
    target: LatLng(lat, lng),
            zoom: 5.5),

      ));
    });
  }

  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
        return null; // permission denied
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  void fetchLocation() async {
    Position? pos = await getCurrentLocation();

    if (pos != null) {
      setState(() {
        lat = pos!.latitude.toString();
        lng = pos!.longitude.toString();
      });
      print("Lat: ${pos.latitude}, Lng: ${pos.longitude}");
    } else {
      print("Permission not granted");
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: 
        [GoogleMap(
        
            initialCameraPosition: _cameraPosition,
          markers: Set.of(_markerList),
          onMapCreated: (GoogleMapController controller){
              _completer.complete(controller);
          },
        ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  OutlinedButton(
                        onPressed: (){
                          getCurrentLocation();
                          fetchLocation();
                        },
                        child: Text("Live Location"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,           // Text/Icon color
                        side: BorderSide(color: Colors.blue),   // Border color and width
                        backgroundColor: Colors.white,          // Background color
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                    Text("Lat: $lat"),
                    Text("Lng: $lng"),


                  ],
                ),
              ),
            ),
          )
      ]
      ) ,

    );
  }
}
