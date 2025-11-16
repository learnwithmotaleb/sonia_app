import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sonia_app/google_map/live_location.dart';

class Part6 extends StatefulWidget {
  const Part6({super.key});

  @override
  State<Part6> createState() => _Part6State();
}

class _Part6State extends State<Part6> {

  var x;
  var y;
  var address;

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
      print("Lat: ${pos.latitude}, Lng: ${pos.longitude}");
    } else {
      print("Permission not granted");
    }
  }

  @override
  void initState() {
    fetchLocation();
    getCurrentLocation()..then((value)async{
      x = value!.latitude.toString();
      y = value!.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);

      final place = placemarks.first;
      print('${place.street}, ${place.locality}, ${place.country}');
      address = '${place.street}, ${place.locality}, ${place.country}';

      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
                onPressed: ()async{
                  await getCurrentLocation().then((value){
                    x = value!.latitude.toString();
                    y = value!.longitude.toString();

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LiveLocation(latitude: value.latitude, longitude: value.longitude,title: address,)));
                    setState(() {

                    });
                  });
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
              SizedBox(height: 10,),

              Text("Latitude: $x "),
              Text("Longitude: $y"),
              SizedBox(height: 10,),
              Text("Address: $address")


            ],
          ),
        ),
      ),
    );
  }
}
