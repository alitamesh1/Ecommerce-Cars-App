// import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// //import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// //import 'package:location/location.dart';
// //import 'package:location/location.dart';
// import 'package:shop_app/pages/MapScreen.dart';
// import 'package:http/http.dart' as http;

// import 'dart:convert';

// class LocationPage extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   String _privew = '';
//   Set<Marker> markers = {};
//   late GoogleMapController googlecontroller;

//   String human = '';
//   static String humanAddress =
//       'https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY';
//   static String locationApi = 'AIzaSyAywLulqFFWVXrYdUrRpYudaCqBLYpnDIY';
//   String generateLocationImage(double latitude, double longitude) {
//     return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$locationApi';
//   }

//   Future<String> gethumanAdrres(double lat, double long) async {
//     final urllink =
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyAywLulqFFWVXrYdUrRpYudaCqBLYpnDIY';
//     final url =
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyAywLulqFFWVXrYdUrRpYudaCqBLYpnDIY';
//     var resopse = await http.get(Uri.parse(urllink));
//     return json
//         .decode(resopse.body)['results'][0]['formatted_address']
//         .toString();
//   }

//   Future<void> selectPlace() async {
//     final mapselected = await Navigator.push<LatLng>(
//         context,
//         MaterialPageRoute(
//             fullscreenDialog: true, builder: (context) => MapScreen()));

//     if (mapselected == null) {
//       return;
//     }
//     final hhh = gethumanAdrres(mapselected.latitude, mapselected.longitude);
//     setState(() {
//       human = hhh.toString();
//     });
//   }

//   Future<void> getlocation() async {
// //     String htttp='https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
// // &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
// // &markers=color:red%7Clabel:C%7C40.718217,-73.998284
// // &key=YOUR_API_KEY&signature=YOUR_SIGNATURE';
//     // final locData = await Location().getLocation();

//     // final getmapLocation =
//     //     generateLocationImage(locData.latitude!, locData.longitude!);
//     // setState(() {
//     //   _privew = getmapLocation;
//     // });

//     // final gethuman = gethumanAdrres(locData.latitude!, locData.longitude!);
//     // setState(() {
//     //   human = gethuman.toString();
//     // });
//   }
//   double lateded = 0.0, longated = 0.0;
//   getLocatinlast() async {
//     //var dataloc = await Location().getLocation();
//     Position dataloc = await Geolocator.getCurrentPosition();
//     longated = dataloc.longitude.toDouble();
//     lateded = dataloc.latitude.toDouble();
//     var coordinate = Coordinates(lateded, longated);
//     print(dataloc.latitude.toString());
//     print(dataloc.longitude.toString());

//     var adddress = await Geocoder.local
//         .findAddressesFromCoordinates(Coordinates(lateded, longated));
//     var ff = adddress.first;

//     print(ff.countryName.toString());
//     setState(() {
//       human = ' ${ff.subLocality}';
//     });
//   }

//   Future<Position> _determineCurrenLocation() async {
//     bool serviceEnabled;

//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return Future.error('Location Service is Disabled');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error('Location Error Permission');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location Error Permission deniedForever');
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     // location.getLocation(position.altitude!,)

//     return position;
//   }
//   // getCurrentLocation() async {
//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.low);

//   //   var address = await Geocoder.local.findAddressesFromCoordinates(
//   //       Coordinates(position.latitude, position.longitude));
//   //   var first = await address.first;

//   //   print(first.countryName);

//   //   // Position position = await Geolocator(
//   //   //     desiredAccuracy: LocationAccuracy.high);

//   //   // GeoCode geoCode =
//   //   //     GeoCode(apiKey: 'AIzaSyAywLulqFFWVXrYdUrRpYudaCqBLYpnDIY');

//   //   // Coordinates coordinates =
//   //   //     await geoCode.forwardGeocoding(address: 'ghghgjgjgj');

//   //   // final lat = await Location().getLocation();
//   //   // print(lat.altitude);
//   //   // print("==============");

//   //   // print('coor: ${coordinates.latitude}');
//   //   // final revercode = await reverseGeocoding(lat.altitude!, lat.longitude!);

//   //   // setState(() {
//   //   //   // human =
//   //   //   //     '${revercode.streetNumber}, ${revercode.streetAddress},  ${revercode.city} ,${revercode.countryName}';
//   //   // });

//   //   // print(revercode.countryName);
//   // }

//   // Future<Address> reverseGeocoding(double altitude, double longitude) async {
//   //   GeoCode geoCode = GeoCode();
//   //   // Position position = await Geolocator.getCurrentPosition(
//   //   //     desiredAccuracy: LocationAccuracy.high);

//   //   Address address = await geoCode.reverseGeocoding(
//   //       latitude: altitude, longitude: longitude);

//   //   return address;
//   // }

//   String address = '';

// // Future<Coordinates> forwardGeocoding({required String address})=>
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location'),
//       ),
//       body: Column(
//         children: [
//           Container(
//               height: 200,
//               width: double.infinity,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: Colors.grey)),
//               child: GoogleMap(
//                 initialCameraPosition:
//                     CameraPosition(target: LatLng(15.11, 44.114), zoom: 14),
//                 markers: {Marker(markerId: MarkerId('value'))},
//                 mapType: MapType.normal,
//                 // onMapCreated: (GoogleMapController contr) {
//                 //   googlecontroller = contr;
//                 // },
//               )),
//           SizedBox(
//             height: 50,
//           ),
//           ElevatedButton.icon(
//               onPressed: getLocatinlast,
//               icon: Icon(Icons.map),
//               label: Text('Load')),
//           ElevatedButton.icon(
//               onPressed: () async {
//                 var postion = await _determineCurrenLocation();

//                 // googlecontroller.animateCamera(CameraUpdate.newCameraPosition(
//                 //     CameraPosition(
//                 //         target: LatLng(lateded, longated), zoom: 14)));
//                 // markers.clear();
//                 // markers.add(Marker(markerId: MarkerId('New Current Location')));
//               },
//               icon: Icon(Icons.map),
//               label: Text('Current')),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton.icon(
//                   onPressed: getlocation,
//                   icon: Icon(Icons.location_on),
//                   label: Text('Current Location')),
//               TextButton.icon(
//                   onPressed: selectPlace,
//                   icon: Icon(Icons.map),
//                   label: Text('Select')),
//             ],
//           ),
//           Center(
//             child: _privew.isEmpty ? Text('No Data') : Text('$_privew'),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Center(
//             child: human.isEmpty ? Text('No Data') : Text('$human'),
//           )
//         ],
//       ),
//     );
//   }
// }
