import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Part4 extends StatefulWidget {
  const Part4({super.key});

  @override
  State<Part4> createState() => _Part4State();
}

class _Part4State extends State<Part4> {

  static final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(22.3569, 91.7832),
    zoom: 5.6
  );

  Completer<GoogleMapController> _completer = Completer();




  var result = "Here Result";

  TextEditingController addressToLatLong = TextEditingController();
  TextEditingController latlongTo = TextEditingController();
  TextEditingController longTo = TextEditingController();


  Future<void> convertAddressToLatLng() async {
    List<Location> locations = await locationFromAddress("Dhaka, Bangladesh");

    final location = locations.first;
    print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');
  }


  Future<void> convertLatLngToAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(23.8103, 90.4125);

    final place = placemarks.first;
    print('${place.street}, ${place.locality}, ${place.country}');
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)

                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),

                  child: TextFormField(
                    controller: addressToLatLong,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Address for latlong",

                    ),
                  ),
                ),
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.location_on),
                onPressed: ()async {
                  List<Location> locations = await locationFromAddress(addressToLatLong.text);

                  final location = locations.first;
                  print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');

                  setState(() {

                    result = "Latitude: ${location.latitude}, Longitude: ${location.longitude}";

                  });
                },
                label: Text("Convert Address To LatLong"),),

              SizedBox(height: 20,),


              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),

                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: latlongTo,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Latlong",

                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: TextFormField(
                          controller: longTo,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Latlong",

                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.location_on),
                onPressed: ()async {
                  double lat = double.parse(latlongTo.text);
                  double lan = double.parse(longTo.text);
                  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lan);

                  final place = placemarks.first;
                  print('${place.street}, ${place.locality}, ${place.country}');

                  setState(() {

                    result = "${place.street}, ${place.locality}, ${place.country}";

                  });


                },
                label: Text("Convert LatLong To Address"),),
              SizedBox(height: 20,),
              Container(

                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white54,
                  borderRadius:BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1)
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(result),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
