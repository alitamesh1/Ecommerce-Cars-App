// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shop_app/pages/categoryproducts.dart';
// import 'package:shop_app/pages/homepage.dart';
// import 'package:shop_app/widgets/categoryproductsitems.dart';
// import 'package:shop_app/widgets/navgatorcar.dart';

// import '../constant.dart';

// class Categories extends StatefulWidget {
//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Stream<QuerySnapshot> _stream =
//       FirebaseFirestore.instance.collection('products').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _stream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return Container(
//             decoration: BoxDecoration(),
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             height: 80,
//             child: snapshot.data!.docs.isEmpty
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       final namecat =
//                           snapshot.data!.docs[index]['category'].toString();

//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Categoryproducts(
//                                         catname: namecat,
//                                       )));
//                         },
//                         child: Container(
//                             // height: 40,
//                             margin: EdgeInsets.symmetric(horizontal: 5),
//                             width: 150,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: whitecolor,
//                               border: Border.all(
//                                 width: .2,
//                                 color: blackcolor,
//                               ),
//                             ),
//                             //color: blackcolor,
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Icon(
//                                       Icons.car_rental,
//                                       color: blackcolor,
//                                       size: 27,
//                                     ),
//                                   ],
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     namecat,
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                               ],
//                             )),
//                       );
//                     }),
//           );
//         });
//   }
// }
