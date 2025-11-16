import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Part8 extends StatefulWidget {
  const Part8({super.key});

  @override
  State<Part8> createState() => _Part8State();
}

class _Part8State extends State<Part8> {
  Completer<GoogleMapController> _completer = Completer();
  List<Marker> _markerList = [];

  List<Marker> _list = const [
    // Marker(
    //   markerId: MarkerId("1"),
    //   position: LatLng(22.3569, 91.7832),
    //   infoWindow: InfoWindow(title: "Chattogram", snippet: "Capital of Chattogram division"),
    // ),
    // Marker(
    //   markerId: MarkerId("2"),
    //   position: LatLng(24.3636, 88.6241),
    //   infoWindow: InfoWindow(title: "Rajshahi", snippet: "Rajshahi is a division of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("3"),
    //   position: LatLng(23.8103, 90.4125),
    //   infoWindow: InfoWindow(title: "Dhaka", snippet: "Dhaka is the capital of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("4"),
    //   position: LatLng(22.8456, 89.5403),
    //   infoWindow: InfoWindow(title: "Khulna", snippet: "Khulna is a division of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("5"),
    //   position: LatLng(22.7010, 90.3535),
    //   infoWindow: InfoWindow(title: "Barishal", snippet: "Barishal is a division of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("6"),
    //   position: LatLng(24.8949, 91.8687),
    //   infoWindow: InfoWindow(title: "Sylhet", snippet: "Sylhet is a division of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("7"),
    //   position: LatLng(25.7558, 89.2440),
    //   infoWindow: InfoWindow(title: "Rangpur", snippet: "Rangpur is a division of Bangladesh"),
    // ),
    // Marker(
    //   markerId: MarkerId("8"),
    //   position: LatLng(24.7471, 90.4203),
    //   infoWindow: InfoWindow(title: "Mymensingh", snippet: "Mymensingh is a division of Bangladesh"),
    // ),
  ];

  LatLngBounds _calculateBounds(List<Marker> markers) {
    final latitudes = markers.map((m) => m.position.latitude);
    final longitudes = markers.map((m) => m.position.longitude);

    return LatLngBounds(
      southwest: LatLng(
        latitudes.reduce((a, b) => a < b ? a : b),
        longitudes.reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        latitudes.reduce((a, b) => a > b ? a : b),
        longitudes.reduce((a, b) => a > b ? a : b),
      ),
    );
  }

  var x;
  var y;

  LatLng? _selectedLatLng;

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
    _markerList.addAll(_list);
    // Optional default location
    _selectedLatLng = const LatLng(23.8103, 90.4125); // Dhaka
    fetchLocation();
    getCurrentLocation().then((value)async{

      List<Placemark> placemarks = await placemarkFromCoordinates(value!.latitude, value!.longitude);

      final place = placemarks.first;
      print('${place.street}, ${place.locality}, ${place.country}');
      address = '${place.street}, ${place.locality}, ${place.country}';

      setState(() {

      });
    });
    super.initState();
  }

  Future<void> getLatLongFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        print('Latitude: $latitude, Longitude: $longitude');

        setState(() {
          _selectedLatLng = LatLng(latitude, longitude);
          _markerList.add(
            Marker(
              markerId: const MarkerId("search_location"),
              position: _selectedLatLng!,
              infoWindow: InfoWindow(
                title: address,
                snippet: "District is $address",
              ),
            ),
          );
        });

        final GoogleMapController controller = await _completer.future;
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(_selectedLatLng!, 10),
        );
      } else {
        print('No location found for this address.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  TextEditingController searchController = new TextEditingController();

  //All Country names
  static const List<String> countries = <String>[
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo (Congo-Brazzaville)',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic (Czechia)',
    'Democratic Republic of the Congo',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini (fmr. "Swaziland")',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar (formerly Burma)',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Korea',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine State',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States of America',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];
  static const List<String> districts = <String>[
    // Dhaka Division
    'Dhaka',
    "Dohar",
    "Keraniganj",
    "Nawabganj",
    "Dhamrai",
    "Savar",
    "Saturia",
    "Doulotpur",
    'Gazipur',
    "Gazipur Sadar",
    "Kaliakair",
    "Kapasia",
    "Sreepur",
    'Narayanganj',
    "Narayanganj Sadar",
    "Bandar",
    "Sonargaon",
    "Rupganj",
    "Araihazar",
    'Tangail',
    "Tangail Sadar",
    "Basail",
    "Bhuapur",
    "Delduar",
    "Dhanbari",
    "Gopalpur",
    "Ghatail",
    "Kalihati",
    "Madhupur",
    "Mirzapur",
    "Nagarpur",
    "Sakhipur",
    'Kishoreganj',
    "Kishoreganj Sadar",
    "Bajitpur",
    "Austagram",
    "Bhairab",
    "Hossainpur",
    "Katiadi",
    "Karimganj",
    "Kuliarchar",
    "Mithamain",
    "Nikli",
    "Pakundia",
    "Tarail",
    'Manikganj',
    "Manikganj Sadar",
    "Saturia",
    "Singair",
    "Shibalaya",
    "Harirampur",
    "Ghior",
    'Narsingdi',
    'Faridpur',
    'Rajbari',
    'Gopalganj',
    'Shariatpur',
    'Madaripur',
    'Munshiganj',
    "Narsingdi Sadar",
    "Palash",
    "Shibpur",
    "Belabo",
    "Monohardi",
    "Raipura",
    "Faridpur Sadar",
    "Bhanga",
    "Charbhadrasan",
    "Boalmari",
    "Alfadanga",
    "Madhukhali",
    "Nagarkanda",
    "Rajbari Sadar",
    "Baliakandi",
    "Pangsha",
    "Kalukhali",
    "Gopalganj Sadar",
    "Kotalipara",
    "Muksudpur",
    "Tungipara",
    "Shariatpur Sadar",
    "Bhedarganj",
    "Naria",
    "Zajira",
    "Gosairhat",
    "Madaripur Sadar",
    "Kalkini",
    "Shibchar",
    "Rajoir",
    "Munshiganj Sadar",
    "Sirajdikhan",
    "Tongibari",
    "Gazaria",
    "Louhajang",
    // Chattogram Division
    'Chattogram',
    "Pahartali",
    "Double Mooring",
    "Halishahar",
    "Chandgaon",
    "Kotwali",
    "Panchlaish",
    "Mirsharai",
    "Raozan",
    "Sitakunda",
    "Sandwip",
    "Rangunia",
    "Boalkhali",
    "Karnaphuli",
    'Cox\'s Bazar',
    "Cox’s Bazar Sadar",
    "Ukhia",
    "Teknaf",
    "Kutubdia",
    "Pekua",
    "Chakaria",
    'Bandarban',
    "Bandarban Sadar"
    "Thanchi",
    "Lama",
    "Rowangchhari",
    "Alikadam",
    "Naikhongchhari",
    'Rangamati',
    "Rangamati Sadar",
    "Kawkhali",
    "Rajasthali",
    "Kaptai",
    "Jurachhari",
    "Langadu",
    "Baghaichhari",
    "Belaichhari",
    "Naniarchar",
    'Khagrachari',
    "Khagrachari Sadar",
    "Dighinala",
    "Lakshmichhari",
    "Manikchhari",
    "Panchhari",
    "Ramgarh",
    "Guimara",
    "Jumpti",
    "Ramgarh",
    "Dighinala",
    'Brahmanbaria',
    "Brahmanbaria Sadar",
    "Ashuganj",
    "Kasba",
    "Akhaura",
    "Bancharampur",
    "Nasirnagar",
    "Bijoynagar",
    'Cumilla',
    "Comilla Sadar Dakshin",
    "Comilla Sadar Uttar",
    "Barura",
   "Laksam",
    "Daudkandi",
    "Debidwar",
    "Homna",
    "Meghna",
    "Muradnagar",
    "Titas",
    "Chandina",
    "Meghna",
    'Chandpur',
    "Chandpur Sadar",
    "Haziganj",
    "Kachua",
    "Shahrasti",
    "Faridgonj",
    "Haimchar",
    'Noakhali',
    "Noakhali Sadar",
    "Hatiya",
    "Chatkhil",
    "Kabirhat",
    "Companiganj",
    "Sonaimuri",
    "Hatiya",
    "Kabirhat",
    'Feni',
    "Fulgazi",
    "Daganbhuiyan",
    "Chhagalnaiya",
    "Feni Sadar",
    'Lakshmipur',
    "Lakshmipur Sadar",
    "Raipur",
    "Ramganj",

    // Rajshahi Division
    'Rajshahi',
    'Natore',
    'Naogaon',
    'Chapainawabganj',
    'Pabna',
    'Sirajganj',
    'Bogura',
    'Joypurhat',

    // Khulna Division
    'Khulna',
    'Jessore',
    'Bagerhat',
    'Satkhira',
    'Magura',
    'Jhenaidah',
    'Narail',
    'Kushtia',
    'Chuadanga',
    'Meherpur',

    // Barishal Division
    'Barishal',
    'Pirojpur',
    'Patuakhali',
    'Jhalokathi',
    'Bhola',
    'Barguna',

    // Sylhet Division
    'Sylhet',
    'Moulvibazar',
    'Sunamganj',
    'Habiganj',

    // Rangpur Division
    'Rangpur',
    'Dinajpur',
    'Thakurgaon',
    'Panchagarh',
    'Nilphamari',
    'Kurigram',
    'Gaibandha',
    'Lalmonirhat',

    // Mymensingh Division
    'Mymensingh',
    'Jamalpur',
    'Netrokona',
    'Sherpur',
  ];

  var selectedText = "";
  var address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target:
                  _selectedLatLng ??
                  const LatLng(23.8103, 90.4125), // fallback to Dhaka
              zoom: 6.5,
            ),
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            trafficEnabled: true,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            liteModeEnabled: false,


            markers: Set.of(_markerList),
            onMapCreated: (GoogleMapController controller) async {
              _completer.complete(controller);
              await Future.delayed(const Duration(milliseconds: 300));
              final bounds = _calculateBounds(_markerList);
              controller.animateCamera(
                CameraUpdate.newLatLngBounds(bounds, 80),
              );
            },
          ),

          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return districts.where((String option) {
                      return option.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      );
                    });
                  },
                  onSelected: (String selection) {
                    print('Selected: $selection');
                    selectedText = selection.toString();
                    setState(() {
                      getLatLongFromAddress(selectedText);
                    });
                  },
                  fieldViewBuilder: (
                    context,
                    controller,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.location_on_sharp),
                        hintText: "Find Location",
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await getCurrentLocation().then((value) async {

          setState(() {
            _markerList.add(
              Marker(
                markerId: const MarkerId("search_location"),
                position: LatLng(value!.latitude, value!.longitude)!,
                infoWindow: InfoWindow(
                  title: "Current Location",
                  snippet: "real time update Locations",
                ),
              ),
            );
          });

          final GoogleMapController controller =  await _completer.future;
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(value!.latitude, value!.longitude), 10),
          );
        });
        fetchLocation();


      },child: Icon(Icons.location_searching),),
    );
  }
}
