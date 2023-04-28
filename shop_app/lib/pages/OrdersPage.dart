import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/MyDrawer.dart';
import 'package:shop_app/widgets/orderItem.dart';

import '../constant.dart';
import 'FavoratePage.dart';
import 'addToCart.dart';

class OrdersPage extends StatefulWidget {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('lastOrders');
  CollectionReference collectionReferencename =
      FirebaseFirestore.instance.collection('usersdata');
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String username = '';
  void sss() async {
    final DocumentSnapshot _snapshot = await FirebaseFirestore.instance
        .collection('usersdata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = _snapshot['username'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDreawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
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
                                        builder: (context) => FAvoratePage()));
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
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<QuerySnapshot>(
          // future: Provider.of<Order>(context).ftectd(widget.user.toString()),
          // widget.user.isEmpty ?
          future: widget.collectionReference
              .where('userid', isEqualTo: widget.user.toString())
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(
                child: Text('SomeThing Went Wrong'),
              );
            }
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'Card Order',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'name:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                username.isEmpty ? '' : username,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data!.docs[i]['amount'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'DateTime:',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  snapshot.data!.docs[i]['date'].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          snapshot.data!.docs[i]['address'].toString().isEmpty
                              ? Text('')
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        snapshot.data!.docs[i]['address']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                          // Text('Amount: ' +
                          //     snapshot.data!.docs[i]['amount'].toString()),
                          // snapshot.data!.docs[i]['address'].toString().isEmpty
                          //     ? Text('')
                          //     : Text('Address: ' +
                          //         snapshot.data!.docs[i]['address'].toString()),
                        ],
                      ),
                    );

                    // ListTile(
                    //   title: Text(snapshot.data!.docs[i]['userid'].toString()),
                    // );
                  });
            return Container();
            // return Consumer<Order>(
            //   builder: (context, orderdata, child) {
            //     return ListView.builder(
            //         itemCount: orderdata.orders.length,
            //         itemBuilder: (context, i) =>
            //             OrderItemWidget(orderdata.orders[i]));
            //   },
            // );
          },
        ),
      ),
    );
  }
}
