// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CAtTryNAv extends StatefulWidget {
//   String categoryname;
//   CAtTryNAv({required this.categoryname});
//   @override
//   _CAtTryNAvState createState() => _CAtTryNAvState();
// }

// class _CAtTryNAvState extends State<CAtTryNAv> {
//   List products = [];

//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('products');

//   getdata() async {
//     var resopnse = await collectionReference.get();

//     resopnse.docs.forEach((element) {
//       setState(() {
//         products.add(element.data());
//       });
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NEw'),
//       ),
//       body: Expanded(
//         child: GridView.builder(
//             itemCount: products.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
//             itemBuilder: (context, index) {
//               return Container(
//                 // height: 400,
//                 child: Column(
//                   children: [
//                     Center(
//                       child: Image.network(
//                         products[index]['image'].toString(),
//                         width: 150,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Center(
//                       child: Text(products[index]['name'].toString()),
//                     ),
//                     Center(
//                       child: Text("\$" + products[index]['price'].toString()),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
