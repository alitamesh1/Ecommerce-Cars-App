import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/FavoratePage.dart';
import 'package:shop_app/pages/categoryproducts.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/Favoraties.dart';
import 'package:shop_app/widgets/MyDrawer.dart';
import 'package:shop_app/widgets/NewArraivals.dart';

import '../constant.dart';
import 'addToCart.dart';
import 'detailsPage.dart';

class Home extends StatefulWidget {
  bool isAll = true;
  Home(this.isAll);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('category');
  CollectionReference productscollection =
      FirebaseFirestore.instance.collection('products');
  String serach = '';

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final favorate = Provider.of<Favorate>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: widget.isAll ? Text('Home Page') : Text('New Arraivals'),
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
      drawer: MyDreawer(),
      body: Column(
        children: [
          Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (val) {
                    setState(() {
                      serach = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: .4, color: blackcolor),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: blackcolor,
                      ),
                      prefixIcon: serach.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.text = "";
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 25,
                                color: Colors.black,
                              )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: .4, color: Colors.grey[900]!)),
                      contentPadding: EdgeInsets.symmetric()),
                ),
              )),

          FutureBuilder<QuerySnapshot>(
              future: collectionReference.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: TextStyle(color: Colors.black38),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CircularProgressIndicator(
                          color: Colors.black38,
                        )
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 32,
                        child: Stack(
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final namecategory = snapshot
                                    .data!.docs[index]['name']
                                    .toString();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Categoryproducts(
                                                  catname: namecategory,
                                                )));
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey[400]!)),
                                    child: Center(
                                        child: Text(
                                      namecategory,
                                      style: TextStyle(
                                        fontSize: 18,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 28,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(width: 1, color: Colors.grey[400]!)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Text(
                  'Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          Expanded(
              child: widget.isAll
                  ? FutureBuilder<QuerySnapshot>(
                      future: serach.isEmpty
                          ? productscollection
                              .orderBy('name', descending: false)
                              .get()
                          : productscollection
                              .where('name', isGreaterThanOrEqualTo: serach)
                              .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Loading',
                                  style: TextStyle(color: Colors.black38),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircularProgressIndicator(
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final namepro = snapshot
                                    .data!.docs[index]['name']
                                    .toString();
                                final pricepro = snapshot
                                    .data!.docs[index]['price']
                                    .toString();
                                final imagepro = snapshot
                                    .data!.docs[index]['image']
                                    .toString();

                                final date = DateTime.now();
                                return Card(
                                  margin: EdgeInsets.only(bottom: 24),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  name: namepro,
                                                  price: pricepro,
                                                  image: imagepro,
                                                  dateTime: date)));
                                    },
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          image: imagepro.isEmpty // not works
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/shopali.jpg'),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: NetworkImage(imagepro),
                                                  fit: BoxFit.cover)),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.yellow[700],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              width: 80,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  namepro,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              width: 80,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '\$$pricepro',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cart.additem(
                                                        date.toString(),
                                                        double.parse(pricepro),
                                                        namepro);
                                                  },
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.shopping_cart,
                                                    size: 30,
                                                    color: orangecolor,
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    favorate.addFavorate(
                                                        DateTime.now()
                                                            .toString(),
                                                        namepro,
                                                        pricepro.toString(),
                                                        imagepro);
                                                  },
                                                  child: Container(
                                                    color: whitecolor,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      })
                  : NewArrivals())

          // Card(
          //     margin: EdgeInsets.all(15),
          //     child: Padding(
          //       padding: EdgeInsets.all(8),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           TextFormField(
          //             decoration: InputDecoration(
          //                 hintText: 'Search...',
          //                 border: UnderlineInputBorder(
          //                   borderSide:
          //                       BorderSide(width: .4, color: blackcolor),
          //                 ),
          //                 suffixIcon: Icon(
          //                   Icons.search,
          //                   color: blackcolor,
          //                 ),
          //                 focusedBorder: UnderlineInputBorder(
          //                     borderSide: BorderSide(
          //                         width: .4, color: Colors.grey[900]!)),
          //                 contentPadding: EdgeInsets.symmetric(
          //                     horizontal: 10, vertical: 2)),
          //           ),
          //           Spacer(),
          //           Chip(
          //             label: Text(
          //               '}',
          //               style: TextStyle(
          //                 color:
          //                     Theme.of(context).primaryTextTheme.title!.color,
          //               ),
          //             ),
          //             backgroundColor: Theme.of(context).primaryColor,
          //           ),
          //         ],
          //       ),
          //     )),
        ],
      ),
    );
  }
}
