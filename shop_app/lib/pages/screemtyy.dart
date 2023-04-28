// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/pages/addToCart.dart';
// import 'package:shop_app/pages/categoryproducts.dart';
// import 'package:shop_app/providers/Cart.dart';
// import 'package:shop_app/widgets/MyDrawer.dart';

// import '../constant.dart';
// import 'detailsPage.dart';

// class Try extends StatefulWidget {
//   @override
//   _TryState createState() => _TryState();
// }

// class _TryState extends State<Try> {
//   Stream<QuerySnapshot> stream =
//       FirebaseFirestore.instance.collection('products').snapshots();
//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('category');
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       drawer: MyDreawer(),
//       appBar: AppBar(
//         actions: [
//           // Row(
//           //   children: [
//           //     IconButton(
//           //         onPressed: () {
//           //           Navigator.push(context,
//           //               MaterialPageRoute(builder: (context) => CartPage()));
//           //         },
//           //         icon: Icon(Icons.shopping_cart)),
//           //     IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
//           //   ],
//           // )
//           PopupMenuButton(
//               itemBuilder: (_) => [
//                     PopupMenuItem(
//                         child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CartPage()));
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text('My Cart'),
//                           Icon(
//                             Icons.shopping_cart,
//                             color: orangecolor,
//                           )
//                         ],
//                       ),
//                     )),
//                     PopupMenuItem(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text('My Favorites'),
//                           Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           )
//                         ],
//                       ),
//                     )
//                   ])
//         ],
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Home',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             Text('Page',
//                 style: TextStyle(
//                   fontSize: 22,
//                 ))
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(10),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     hintText: 'Search...',
//                     border: UnderlineInputBorder(
//                       borderSide: BorderSide(width: .4, color: blackcolor),
//                     ),
//                     suffixIcon: Icon(
//                       Icons.search,
//                       color: blackcolor,
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide:
//                             BorderSide(width: .4, color: Colors.grey[900]!)),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
//               ),
//             ),
//             Text(
//               'Categories..',
//               style: TextStyle(
//                   fontSize: 22, color: blackcolor, fontWeight: FontWeight.bold),
//             ),
//             FutureBuilder<QuerySnapshot>(
//               future: collectionReference.get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 return SizedBox(
//                   height: 210,
//                   child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       padding: EdgeInsets.all(12),
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(
//                           width: 12,
//                         );
//                       },
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         final catname =
//                             snapshot.data!.docs[index]['name'].toString();
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Categoryproducts(
//                                             catname: catname)));
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(40),
//                                 child: Image.network(
//                                   snapshot.data!.docs[index]['imagecat']
//                                       .toString(),
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             Text(snapshot.data!.docs[index]['name'].toString()),
//                           ],
//                         );
//                       }),
//                 );

//                 // return GridView.builder(
//                 //     itemCount: snapshot.data!.docs.length,
//                 //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 //         crossAxisCount: 2,
//                 //         mainAxisSpacing: 5,
//                 //         crossAxisSpacing: 5),
//                 //     itemBuilder: (context, index) {
//                 //       return Container(
//                 //         // height: 400,
//                 //         child: Column(
//                 //           children: [
//                 //             Center(
//                 //               child: Image.network(
//                 //                 snapshot.data!.docs[index]['image'].toString(),
//                 //                 width: 150,
//                 //                 height: 100,
//                 //                 fit: BoxFit.cover,
//                 //               ),
//                 //             ),
//                 //             Center(
//                 //               child: Text(snapshot.data!.docs[index]['name']
//                 //                   .toString()),
//                 //             ),
//                 //             Center(
//                 //               child: Text("\$" +
//                 //                   snapshot.data!.docs[index]['price']
//                 //                       .toString()),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       );
//                 //     });
//               },
//             ),
//             Text(
//               'Products..',
//               style: TextStyle(
//                   fontSize: 22, color: blackcolor, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Divider(
//               height: .4,
//               color: Colors.black,
//             ),
//             StreamBuilder<QuerySnapshot>(
//               stream: stream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }

//                 return Expanded(
//                   child: GridView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 5,
//                           crossAxisSpacing: 5),
//                       itemBuilder: (context, index) {
//                         final namepro =
//                             snapshot.data!.docs[index]['name'].toString();
//                         final pricepro =
//                             snapshot.data!.docs[index]['price'].toString();
//                         final imagepro =
//                             snapshot.data!.docs[index]['image'].toString();
//                         final date = DateTime.now();

//                         return Container(
//                           // height: 400,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Icon(
//                                     Icons.favorite,
//                                     size: 20,
//                                   ),

//                                   GestureDetector(
//                                     onTap: () {
//                                       cart.additem(date.toString(),
//                                           double.parse(pricepro), namepro);
//                                     },
//                                     child: Icon(
//                                       Icons.shopping_cart,
//                                       size: 20,
//                                     ),
//                                   ),
//                                   // IconButton(
//                                   //   onPressed: () {
//                                   //     cart.additem();
//                                   //   },
//                                   //   icon: Icon(
//                                   //     Icons.shopping_cart,
//                                   //     size: 20,
//                                   //   ),
//                                   // )
//                                 ],
//                               ),
//                               Container(
//                                 height: 100,
//                                 width: 100,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => DetailsPage(
//                                                   name: namepro,
//                                                   dateTime: date,
//                                                   price: pricepro,
//                                                   image: imagepro,
//                                                 )));
//                                   },
//                                   child: CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                       snapshot.data!.docs[index]['image']
//                                           .toString(),
//                                     ),
//                                     radius: 20,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 15),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       'Name:',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       snapshot.data!.docs[index]['name']
//                                           .toString(),
//                                       style: TextStyle(
//                                           fontStyle: FontStyle.italic),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 15),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       'Price:',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       "\$" +
//                                           snapshot.data!.docs[index]['price']
//                                               .toString(),
//                                       style: TextStyle(
//                                           fontStyle: FontStyle.italic),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
