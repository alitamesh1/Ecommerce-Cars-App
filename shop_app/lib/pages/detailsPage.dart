import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/pages/addToCart.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/widgets/MyAppBar.dart';
import 'package:shop_app/widgets/MyDrawer.dart';

import 'FavoratePage.dart';

class DetailsPage extends StatefulWidget {
  final f = FirebaseFirestore.instance.collection('products').snapshots();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('products').snapshots();
  String name, image, price;
  DateTime dateTime;
  DetailsPage(
      {required this.name,
      required this.price,
      required this.image,
      required this.dateTime});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        drawer: MyDreawer(),
        appBar: AppBar(
          actions: [
            PopupMenuButton(
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
                'Details',
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  cart.additem(DateTime.now().toString(),
                      double.parse(widget.price), widget.name);
                  Navigator.pop(context);
                },
                child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Add to Cart',
                          style: TextStyle(color: whitecolor),
                        ),
                        Icon(Icons.shopping_cart)
                      ],
                    ))),
              )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  cart.additem(DateTime.now().toString(),
                      double.parse(widget.price), widget.name);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Buy Now',
                          style: TextStyle(color: blackcolor),
                        ),
                        Icon(Icons.bubble_chart)
                      ],
                    ))),
              )),
            ],
          ),
        ),
        body:

            //  StreamBuilder<QuerySnapshot>(
            //   stream: widget.collectionReference.snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }

            // return Container(
            //   width: double.infinity,
            //   height: 500,
            //   child: Image.network(snapshot.data!.docs.toString()),
            // );
            // return ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     itemBuilder: (context, index) {
            //       final image = widget.f.forEach((element) {
            //         widget.collectionReference
            //             .where('image',
            //                 isEqualTo: "${snapshot.data!.docs[index]['image']}")
            //             .snapshots();
            //       });
            //       return Container(
            //         width: double.infinity,
            //         height: 500,
            //         child: Image.network(image.toString()),
            //       );
            //     });

            SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(border: Border.all(width: .1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.name),
                      ],
                    )),
                    Divider(
                      height: .7,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${widget.price}'),
                      ],
                    )),
                    Divider(
                      height: 2,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.dateTime.toString()),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        )
        //   },
        // )

        );
  }
}
