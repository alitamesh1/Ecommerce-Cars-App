// //import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// //import 'package:location/location.dart';
// //import 'package:location_platform_interface/location_platform_interface.dart';
// //import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

// class MapScreen extends StatefulWidget {
//   //Placemark? placemark;

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   LatLng _pickimage = LatLng(4.1, 4);
//   // late GoogleMapController googleMapController;
//   // final position123 = Geolocator.getCurrentPosition();
//   // Set<Marker> markers = {};

//   void selctedlocation(LatLng postion) async {
//     setState(() {
//       _pickimage = postion;
//     });
//   }
//   // Future<void> gethumanlocation(Position position)async{
//   //   String street=Geolocator.
//   // }

//   // etCurrent() async {
//   //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   // }

//   //Location location;
//   // Future<Position> _determineCurrenLocation() async {
//   //   bool serviceEnabled;

//   //   LocationPermission permission;
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();

//   //   if (!serviceEnabled) {
//   //     return Future.error('Location Service is Disabled');
//   //   }

//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();

//   //     if (permission == LocationPermission.denied) {
//   //       return Future.error('Location Error Permission');
//   //     }
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error('Location Error Permission deniedForever');
//   //   }

//   //   Position position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high);
//   //   // location.getLocation(position.altitude!,)

//   //   return position;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//         actions: [
//           IconButton(
//               onPressed: _pickimage == null
//                   ? null
//                   : () {
//                       // Navigator.of(context).pop(_pickimage);
//                     },
//               icon: Icon(Icons.check_box))
//         ],
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(15.3432, 44.199),
//           zoom: 16,
//         ),
//         // zoomControlsEnabled: false,
//         // onMapCreated: (GoogleMapController contrroler) {
//         //   googleMapController = contrroler;
//         // },
//         mapType: MapType.hybrid,
//         onTap: selctedlocation,
//         markers: {Marker(markerId: MarkerId('M1'), position: _pickimage)},
//         //markers: markers,
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     //Position position = await _determineCurrenLocation();

//       //     googleMapController
//       //         .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       //       target: LatLng(position.altitude, position.longitude),
//       //     )));
//       //     markers.clear();
//       //     markers.add(const Marker(markerId: MarkerId('New Current Location')));
//       //   },
//       //   child: Text('Current Location'),
//       // ),
//     );
//   }
// }
