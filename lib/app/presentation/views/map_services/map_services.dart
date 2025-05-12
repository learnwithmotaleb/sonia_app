import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:sonia_app/app/core/constants/info_bd.dart';

class GeoCodingAddress extends StatefulWidget {
  const GeoCodingAddress({super.key});

  @override
  State<GeoCodingAddress> createState() => _GeoCodingAddressState();
}

class _GeoCodingAddressState extends State<GeoCodingAddress> {

  String address ='';
  String latlong = '';






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Text(latlong),
            SizedBox(height: 20,),
            Text(address),

            SizedBox(height: 20,),

            ElevatedButton(
                onPressed: ()async{

                  List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                  List<Placemark> placemarks = await placemarkFromCoordinates(23.805884471025966, 90.40662724843655);

                  setState(() {
                    latlong = "Latitude: ${locations.last.latitude.toString()}\nLongitude: ${locations.last.longitude.toString()}";

                    address = "Country: ${placemarks.last.country.toString()}\n"
                        "Area: ${placemarks.last.administrativeArea.toString()}\n"
                        "CountryCode: ${placemarks.last.isoCountryCode.toString()}\n"
                        "${placemarks.last.locality.toString()}\n"
                        "${placemarks.reversed.last.toString()}\n"
                        "${placemarks.last.subAdministrativeArea.toString()}\n"
                        "${placemarks.last.subLocality.toString()}\n"
                        "${placemarks.last.subThoroughfare.toString()}\n"
                        "${placemarks.last.thoroughfare.toString()}\n"
                        "${placemarks.last.street.toString()}";



                  });
                },
                child: Text("Convert"))


          ],
        ),
      ),

    );
  }
}
