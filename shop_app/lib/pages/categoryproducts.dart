import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/Favoraties.dart';
import 'package:shop_app/widgets/MyDrawer.dart';

import '../constant.dart';
import 'FavoratePage.dart';
import 'addToCart.dart';

// ignore: must_be_immutable
class Categoryproducts extends StatefulWidget {
  String? catname;

  Categoryproducts({required this.catname});

  @override
  _CategoryproductsState createState() => _CategoryproductsState();
}

class _CategoryproductsState extends State<Categoryproducts> {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('products').snapshots();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favorate = Provider.of<Favorate>(context);
    return Scaffold(
        drawer: MyDreawer(),
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                tooltip: 'Cart and Favorates',
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CartPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => CartPage()));
                                },
                                child: Text('My Cart')),
                            Icon(
                              Icons.shopping_cart,
                              color: orangecolor,
                            )
                          ],
                        ),
                      )),
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>
                                              FAvoratePage()));
                                },
                                child: Text('My Favorates')),
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ])
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.catname!,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('Page',
                  style: TextStyle(
                    fontSize: 22,
                  ))
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Text(
                    'Products Of ' + widget.catname!,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: collectionReference
                    .where('category', isEqualTo: widget.catname)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 400,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                child: Image.network(
                                  snapshot.data!.docs[index]['image']
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Name: ' +
                                      snapshot.data!.docs[index]['name']
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(
                                    "\$" +
                                        snapshot.data!.docs[index]['price']
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: .5, color: Colors.red)),
                                        child: Text('Favorates',
                                            style:
                                                TextStyle(color: Colors.red))),
                                    onTap: () {
                                      favorate.addFavorate(
                                          DateTime.november.toString(),
                                          snapshot.data!.docs[index]['name'],
                                          snapshot.data!.docs[index]['price']
                                              .toString(),
                                          snapshot.data!.docs[index]['image']
                                              .toString());
                                      // favorate.addFavorate(
                                      //     DateTime.november.toString(),
                                      //     snapshot.data!.docs[index]['name'],
                                      //     snapshot.data!.docs[index]['price'],
                                      //     snapshot.data!.docs[index]['image']
                                      //         .toString());
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                                width: .5,
                                                color: Colors.black)),
                                        child: Text(
                                          'Add To Cart',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    onTap: () {
                                      cart.additem(
                                          DateTime.now().toString(),
                                          double.parse(snapshot
                                              .data!.docs[index]['price']
                                              .toString()),
                                          snapshot.data!.docs[index]['name']);
                                    },
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         cart.additem(
                              //             DateTime.now().toString(),
                              //             double.parse(snapshot
                              //                 .data!.docs[index]['price']
                              //                 .toString()),
                              //             snapshot.data!.docs[index]['name']);
                              //         // cart.additem(
                              //         //     DateTime.now().toString(),
                              //         //     double.parse(snapshot
                              //         //         .data!.docs[index]['price']
                              //         //         .toString()),
                              //         //     snapshot.data!.docs[index]['name']);
                              //       },
                              //       child: Container(
                              //           padding: EdgeInsets.all(10),
                              //           decoration: BoxDecoration(
                              //               color: Colors.red,
                              //               border: Border.all(
                              //                   width: .5,
                              //                   color: Colors.black)),
                              //           child: TextButton.icon(
                              //               onPressed: () {},
                              //               icon: Icon(
                              //                 Icons.shopping_cart,
                              //                 color: Colors.black,
                              //               ),
                              //               label: Text(
                              //                 'Add To Cart',
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ))),
                              //     ),
                              //     SizedBox(
                              //       width: 5,
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         favorate.addFavorate(
                              //             DateTime.november.toString(),
                              //             snapshot.data!.docs[index]['name'],
                              //             snapshot.data!.docs[index]['price'],
                              //             snapshot.data!.docs[index]['image']
                              //                 .toString());
                              //       },
                              //       child: Container(
                              //           padding: EdgeInsets.all(10),
                              //           decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   width: .5, color: Colors.red)),
                              //           child: TextButton.icon(
                              //               onPressed: () {
                              //                 favorate.addFavorate(
                              //                     DateTime.november.toString(),
                              //                     snapshot.data!.docs[index]
                              //                         ['name'],
                              //                     snapshot.data!.docs[index]
                              //                         ['price'],
                              //                     snapshot.data!
                              //                         .docs[index]['image']
                              //                         .toString());
                              //               },
                              //               icon: Icon(
                              //                 Icons.favorite,
                              //                 color: Colors.red,
                              //               ),
                              //               label: Text(
                              //                 'Favorates',
                              //                 style:
                              //                     TextStyle(color: Colors.red),
                              //               ))),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        )

        //  StreamBuilder<QuerySnapshot>(
        //   stream: collectionReference.doc().get(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }

        //     return GridView.builder(
        //         itemCount: snapshot.data!.docs.length,
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
        //         itemBuilder: (context, index) {
        //           return Container(
        //             // height: 400,
        //             child: Column(
        //               children: [
        //                 Center(
        //                   child: Image.network(
        //                     snapshot.data!.docs[index]['image'].toString(),
        //                     width: 150,
        //                     height: 100,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //                 Center(
        //                   child:
        //                       Text(snapshot.data!.docs[index]['name'].toString()),
        //                 ),
        //                 Center(
        //                   child: Text("\$" +
        //                       snapshot.data!.docs[index]['price'].toString()),
        //                 ),
        //               ],
        //             ),
        //           );
        //         });
        //   },
        // ),
        );
  }
}
