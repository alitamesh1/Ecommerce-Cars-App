import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/detailsPage.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/Favoraties.dart';

import '../constant.dart';

class NewArrivals extends StatefulWidget {
  // String ?maySearch;
  // NewArrivals([this.maySearch]);
  @override
  _NewArrivalsState createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  //String search = '';
  var search;
  final ss = TextEditingController();
  Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('products')
      .where('name')
      .orderBy('name', descending: true)
      .limit(6)
      .snapshots();
  CollectionReference h = FirebaseFirestore.instance.collection('products');

  // Stream<QuerySnapshot> _streamsearch= FirebaseFirestore.instance
  //     .collection('products')
  //     .where('name', isEqualTo:)
  //     .orderBy('name')
  //     .snapshots();
  // Stream<QuerySnapshot> _streamsearch = FirebaseFirestore.instance
  //     .collection('products')
  //     .where('name', isEqualTo: search)
  //     .snapshots();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  var searchcontrller = TextEditingController();

  //String? namepro, pricepro, imagepro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favorate = Provider.of<Favorate>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Card(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      name: snapshot.data!.docs[index]['name']
                                          .toString(),
                                      price: snapshot.data!.docs[index]['price']
                                          .toString(),
                                      image: snapshot.data!.docs[index]['image']
                                          .toString(),
                                      dateTime: DateTime.now())));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data!.docs[index]['image'].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Material(
                                color: Colors.white,
                                child: Text(
                                  snapshot.data!.docs[index]['name'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.white,
                                child: Text(
                                  snapshot.data!.docs[index]['price']
                                      .toString(),
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        width: .5, color: Colors.black)),
                                child: TextButton.icon(
                                    onPressed: () {
                                      cart.additem(
                                          DateTime.now().toString(),
                                          double.parse(snapshot
                                              .data!.docs[index]['price']
                                              .toString()),
                                          snapshot.data!.docs[index]['name']);
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      'Add To Cart',
                                      style: TextStyle(color: Colors.white),
                                    ))),

                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .5, color: Colors.red)),
                                child: TextButton.icon(
                                    onPressed: () {
                                      favorate.addFavorate(
                                          DateTime.november.toString(),
                                          snapshot.data!.docs[index]['name'],
                                          snapshot.data!.docs[index]['price']
                                              .toString(),
                                          snapshot.data!.docs[index]['image']
                                              .toString());
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'Favorates',
                                      style: TextStyle(color: Colors.red),
                                    ))),

                            //     onPressed: () {},
                            //     icon: Icon(Icons.shopping_cart)),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.favorite,
                            //     ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });

    // Column(
    //   children: [
    //     Container(
    //       padding: EdgeInsets.all(10),
    //       child: TextFormField(
    //         decoration: InputDecoration(
    //             hintText: 'Search...',
    //             border: UnderlineInputBorder(
    //               borderSide: BorderSide(width: .4, color: blackcolor),
    //             ),
    //             suffixIcon: Icon(
    //               Icons.search,
    //               color: blackcolor,
    //             ),
    //             focusedBorder: UnderlineInputBorder(
    //                 borderSide:
    //                     BorderSide(width: .4, color: Colors.grey[900]!)),
    //             contentPadding:
    //                 EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
    //         controller: searchcontrller,
    //       ),
    //     ),
    //     StreamBuilder<QuerySnapshot>(
    //         stream: _stream,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           }

    //           return Container(
    //             height: 500,
    //             child: GridView.builder(
    //                 itemCount: snapshot.data!.docs.length,
    //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                     crossAxisCount: 2,
    //                     crossAxisSpacing: 10,
    //                     mainAxisSpacing: 10),
    //                 itemBuilder: (context, index) {
    //                   //setState(() {});
    //                   final namepro =
    //                       snapshot.data!.docs[index]['name'].toString();
    //                   final pricepro =
    //                       snapshot.data!.docs[index]['price'].toString();
    //                   final imagepro =
    //                       snapshot.data!.docs[index]['image'].toString();
    //                   final date = DateTime.now();

    //final document = snapshot.data!.docs[index];
    // return GestureDetector(
    //     onTap: () {},
    //     child: Column(children: [
    //       Center(
    //         child: Column(
    //           children: [
    //             Center(
    //               child: Container(
    //                 height: 100,
    //                 width: 100,
    //                 child: Image.network(snapshot
    //                     .data!.docs[index]['image']
    //                     .toString()),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: 12),
    //               child: Row(
    //                 mainAxisAlignment:
    //                     MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "Name:",
    //                     style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     snapshot.data!.docs[index]['name']
    //                         .toString(),
    //                     style: TextStyle(
    //                         fontStyle: FontStyle.italic),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: 12),
    //               child: Row(
    //                 mainAxisAlignment:
    //                     MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "Price:",
    //                     style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     "\$ ${snapshot.data!.docs[index]['price'].toString()}",
    //                     style: TextStyle(
    //                         fontStyle: FontStyle.italic),
    //                   ),
    //                   SizedBox(
    //                     width: 2,
    //                   )
    //                 ],
    //               ),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Icon(Icons.shopping_cart),
    //                 Icon(
    //                   Icons.favorite,
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       )
    //     ]));
    //                   var dd = snapshot.data!.docs[index].id;
    //                   return Container(
    //                     decoration: BoxDecoration(
    //                         border: Border.all(width: .5, color: blackcolor),
    //                         borderRadius: BorderRadius.circular(5)),
    //                     height: 700,
    //                     width: 150,
    //                     child: Center(
    //                       child: Column(
    //                         children: [
    //                           GestureDetector(
    //                             onTap: () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => DetailsPage(
    //                                             name: namepro,
    //                                             dateTime: date,
    //                                             price: pricepro,
    //                                             image: imagepro,
    //                                           )));
    //                             },
    //                             child: Center(
    //                               child: Container(
    //                                 height: 100,
    //                                 width: 100,
    //                                 child: Image.network(imagepro),
    //                               ),
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding:
    //                                 const EdgeInsets.symmetric(horizontal: 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Text(
    //                                   "Name:",
    //                                   style: TextStyle(
    //                                       fontSize: 18,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                                 // dd == null
    //                                 //     ? Text('no docs')
    //                                 Text(
    //                                   namepro,
    //                                   style: TextStyle(
    //                                       fontStyle: FontStyle.italic),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding:
    //                                 const EdgeInsets.symmetric(horizontal: 12),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Text(
    //                                   "Price:",
    //                                   style: TextStyle(
    //                                       fontSize: 18,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                                 Text(
    //                                   pricepro,
    //                                   style: TextStyle(
    //                                       fontStyle: FontStyle.italic),
    //                                 ),
    //                                 SizedBox(
    //                                   width: 2,
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             children: [
    //                               Icon(
    //                                 Icons.shopping_cart,
    //                                 size: 20,
    //                               ),
    //                               SizedBox(
    //                                 width: 5,
    //                               ),
    //                               Icon(
    //                                 Icons.favorite,
    //                                 size: 20,
    //                               )
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 }),
    //           );
    //         }),
    //   ],
    // );

    //  Container(
    //   height: 400,
    //   child: GridView(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10),
    //     children: [
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       ),
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       ),
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       ),
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       ),
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       ),
    //       Container(
    //         decoration:
    //             BoxDecoration(border: Border.all(width: .5, color: blackcolor)),
    //         height: 150,
    //         width: 150,
    //         child: Center(
    //           child: Text('hhhh'),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
