// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../constant.dart';

// class Categoryproductsitems extends StatefulWidget {
//   @override
//   _CategoryproductsitemsState createState() => _CategoryproductsitemsState();
// }

// class _CategoryproductsitemsState extends State<Categoryproductsitems> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Stream<QuerySnapshot> _stream =
//       FirebaseFirestore.instance.collection('products').snapshots();
//   final lists = [];

//   getdata() async {
//     CollectionReference collectionReference =
//         FirebaseFirestore.instance.collection('products');
//     QuerySnapshot querySnapshot = await collectionReference.get();
//     List<QueryDocumentSnapshot> trylist = querySnapshot.docs;

//     trylist.forEach((element) {
//       setState(() {
//         lists.add(element.data());
//       });
//     });

//     // res.docs.forEach((element) {
//     //   setState(() {
//     //     lists.add(element.data());
//     //   });
//     // });
//   }

//   @override
//   Future initState() async {
//     // TODO: implement initState
//     super.initState();
//     await getdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('heloo'),
//         ),
//         body: Container(
//           child: Expanded(
//             child: GridView.builder(
//                 itemCount: lists.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     // height: 400,
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Image.network(
//                             lists[index]['image'].to,
//                             width: 150,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Center(
//                           child: Text(lists[index]['name'].toString()),
//                         ),
//                         Center(
//                           child: Text("\$" + lists[index]['price'].toString()),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//         )
//         //  StreamBuilder<QuerySnapshot>(
//         //     stream: _stream,
//         //     builder: (context, snapshot) {
//         //       if (snapshot.connectionState == ConnectionState.waiting) {
//         //         return Center(child: CircularProgressIndicator());
//         //       }

//         //       return Expanded(
//         //         child: GridView.builder(
//         //             itemCount: lists.length,
//         //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         //                 crossAxisCount: 2,
//         //                 mainAxisSpacing: 5,
//         //                 crossAxisSpacing: 5),
//         //             itemBuilder: (context, index) {
//         //               return Container(
//         //                 // height: 400,
//         //                 child: Column(
//         //                   children: [
//         //                     Center(
//         //                       child: Image.network(
//         //                         //snapshot.data!.docs[index]['image'].toString(),
//         //                         lists[index]['image'].toString(),
//         //                         width: 150,
//         //                         height: 100,
//         //                         fit: BoxFit.cover,
//         //                       ),
//         //                     ),
//         //                     Center(
//         //                       child: Text(
//         //                           //  snapshot.data!.docs[index]['name'].toString()

//         //                           lists[index]['name'].toString()),
//         //                     ),
//         //                     Center(
//         //                       child:
//         //                           Text("\$" + lists[index]['price'].toString()),
//         //                     ),
//         //                   ],
//         //                 ),
//         //               );
//         //             }),
//         //       );
//         //     }),
//         );
//   }
// }
