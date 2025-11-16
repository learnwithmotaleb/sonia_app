import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sonia_app/google_map/assets/map_images.dart';

import 'assets/map_icons.dart';

class Part10 extends StatefulWidget {
  const Part10({super.key});

  @override
  State<Part10> createState() => _Part10State();
}

class _Part10State extends State<Part10> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(22.3569, 91.7832),
    zoom: 5.6,
  );

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  List _iconList = [
    MapIcons.bicycle,
    MapIcons.bycicle,
    MapIcons.bus,
    MapIcons.car,
    MapIcons.location,
    MapIcons.placeholder,
    MapIcons.placeholder2,
    MapIcons.walk,
  ];
  List _imageList = [
    MapImages.img1,
    MapImages.img2,
    MapImages.img3,
    MapImages.img4,
    MapImages.img5,
    MapImages.img6,
    MapImages.img7,
    MapImages.img8,

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

  loadData(){
    
    for(int i=0; i<_latlang.length; i++) {
      _marker.add(
        
        Marker(
            markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latlang[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Text("Success", style: TextStyle(color: Colors.green)),
                          content: Text("Your action was successful!"),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },

                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            _imageList[i],
                            width: 250,
                            height: 150,
                            fit: BoxFit.cover, // 🔄 changed to cover
                          ),
                        ),
                        Positioned(
                          top: 4,
                          bottom: 2,
                          left: 2,
                          right: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _placeTitle[i],
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                _placeSubTitle[i],
                                style: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _latlang[i],
              );
            }



        )

      );
      setState(() {

      });
    }


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: cameraPosition,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 150,
            width: 250,
            offset: 35,
          )
        ],
      ),

    );
  }
}
