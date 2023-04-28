import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/AuthPage.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/MyDrawer.dart';
import 'package:shop_app/widgets/cart_items.dart';
import '../providers/Cart.dart' show Cart;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

String? id, price, quantity, title;
List<String>? titles;
Map<String, dynamic>? _map;

class _CartPageState extends State<CartPage> {
  String finaladdress = '';
  double latiude = 0.0, longtiude = 0.0;

  double lateded = 0.0, longated = 0.0;

  Future<String> getLocatinlast() async {
    //var dataloc = await Location().getLocation();
    String newAddress;
    Position dataloc = await Geolocator.getCurrentPosition();
    longated = dataloc.longitude.toDouble();
    lateded = dataloc.latitude.toDouble();
    var coordinate = Coordinates(lateded, longated);
    // print(dataloc.latitude.toString());
    // print(dataloc.longitude.toString());

    var address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lateded, longated));
    var humanaddress = address.first;

    //print(humanaddress.countryName.toString());

    return newAddress =
        ' ${humanaddress.countryName}, ${humanaddress.locality}, ${humanaddress.subLocality}, ${humanaddress.addressLine}';

    // print(finaladdress.toString());
  }

  String orderfirebase = 'lastOrders';
  getAddressLocation() async {
    try {
      var locdata = await Geolocator.getCurrentPosition();
      latiude = locdata.altitude.toDouble();
      longtiude = locdata.longitude.toDouble();
      print(latiude.toString());
      var humanAddress = await Geocoder.local
          .findAddressesFromCoordinates(Coordinates(latiude, longtiude));

      var lastAddress = humanAddress.first;

      print(lastAddress.countryName.toString());
    } catch (e) {
      print(e);
    }
  }

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

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('lastOrders');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocatinlast();
    sss();
  }

  @override
  Widget build(BuildContext context) {
    if (titles == null) titles = [];
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(cart.count.toString())),
          ),
          Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel)))
        ],
        centerTitle: true,
      ),
      drawer: MyDreawer(),
      body: Column(
        children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalprice}',
                        style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title!.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    // TextButton.icon(
                    //     onPressed: getLocatinlast,
                    //     icon: Icon(Icons.map),
                    //     label: Text('data')),
                    // TextButton(
                    //     onPressed: () async {
                    //       //  order.addNewOrder(cart.totalprice,
                    //     },
                    //     child: Text('Order')),

                    GestureDetector(
                      onTap: () async {
                        finaladdress = await getLocatinlast();
                        if (finaladdress.isEmpty || cart.totalprice <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Check Of The Informations')));
                        }

                        collectionReference
                            .add({
                              'amount': cart.totalprice,
                              'date': DateTime.now().toString(),
                              'id': DateTime.now().toString(),
                              'userid': FirebaseAuth.instance.currentUser!.uid
                                  .toString(),
                              'username': username,

                              'address': finaladdress.toString(),
                              'qauntity': cart.count,
                              //        'products': titles it works
                              'products': titles!.map((e) => e).toList()
                            })
                            .then((value) => print('Ok'))
                            .then((_) => titles!.clear())
                            .then((value) => cart.removeitems())
                            .then((value) => Navigator.pop(context));

                        // StreamBuilder<User?>(
                        //     stream: FirebaseAuth.instance.authStateChanges(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         if (finaladdress.isEmpty ||
                        //             cart.totalprice <= 0 ||
                        //             titles!.isEmpty) {
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //               SnackBar(
                        //                   content: Text(
                        //                       'Check Of The Informations')));
                        //         } else {
                        //           collectionReference
                        //               .add({
                        //                 'amount': cart.totalprice,
                        //                 'date': DateTime.now().toString(),
                        //                 'id': DateTime.now().toString(),
                        //                 'userid': FirebaseAuth
                        //                     .instance.currentUser!.uid
                        //                     .toString(),
                        //                 'address': finaladdress.toString(),
                        //                 'qauntity': cart.count,
                        //                 //        'products': titles it works
                        //                 'products':
                        //                     titles!.map((e) => e).toList()
                        //               })
                        //               .then((value) => print('Ok'))
                        //               .then((_) => titles!.clear())
                        //               .then((value) => cart.removeitems())
                        //               .then((value) => Navigator.pop(context));
                        //         }
                        //       } else {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => AuthPage()));
                        //       }
                        //       return Container();
                        //     });

                        // order.addOneOrder(
                        //     DateTime.now().toString(),
                        //     titles!.map((e) => e).toList(),
                        //     cart.totalprice,
                        //     finaladdress);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red[500],
                        ),
                        child: Text(
                          'Buy Now',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    id = cart.items.values.toList()[index].id;

                    //titles!.add(cart.items.values.toList()[index].title);
                    title = cart.items.values.toList()[index].title;
                    titles!.add(cart.items.values.toList()[index].title);
                    price = cart.items.values.toList()[index].price.toString();
                    quantity =
                        cart.items.values.toList()[index].quantity.toString();
                    return CartItem(
                      cart.items.values.toList()[index].id,
                      cart.items.keys.toList()[index],
                      cart.items.values.toList()[index].price,
                      cart.items.values.toList()[index].quantity,
                      cart.items.values.toList()[index].title,
                    );
                  }))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton({required this.cart});
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isloadding = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.cart.totalprice <= 0 || _isloadding)
          ? null
          : () async {
              setState(() {
                _isloadding = true;
              });

              await Provider.of<Order>(context)
                  .addOrder(
                      widget.cart.items.values.toList(), widget.cart.totalprice)
                  .then((value) => print('Ok'))
                  .catchError((_) => print('Error'));

              // .addOrders(id!, quantity!,
              //     price!, title!, widget.cart.totalprice, context);

              setState(() {
                _isloadding = false;
              });

              widget.cart.clear();
            },
      child: _isloadding
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red[500],
              ),
              child: Text(
                'Buy Now',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
    );
  }
}
