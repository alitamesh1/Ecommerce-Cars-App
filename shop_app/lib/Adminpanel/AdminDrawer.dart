import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Adminpanel/AllProducts.dart';
import 'package:shop_app/Adminpanel/allOrders.dart';
import 'package:shop_app/Adminpanel/formproducts.dart';
import 'package:shop_app/pages/Home.dart';

import '../constant.dart';

class AdminDrwawer extends StatefulWidget {
  const AdminDrwawer({Key? key}) : super(key: key);

  @override
  State<AdminDrwawer> createState() => _AdminDrwawerState();
}

class _AdminDrwawerState extends State<AdminDrwawer> {
  final user = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Name:'),
              accountEmail: user!.isEmpty
                  ? Text('data')
                  : Text('Email: ' + user.toString())),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home(true)));
              },
              child: ListTile(
                  title: Text(
                    'Go to App',
                    style: TextStyle(color: blackcolor),
                  ),
                  trailing: Icon(
                    Icons.home,
                    color: blackcolor,
                  )),
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormProducts()));
              },
              child: ListTile(
                  title: Text(
                    'Add Product',
                    style: TextStyle(color: blackcolor),
                  ),
                  trailing: Icon(
                    Icons.home,
                    color: blackcolor,
                  )),
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllProducts()));
              },
              child: ListTile(
                  title: Text(
                    'Show Products',
                    style: TextStyle(color: blackcolor),
                  ),
                  trailing: Icon(
                    Icons.new_label,
                    color: blackcolor,
                  )),
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllOrders()));
              },
              child: ListTile(
                  title: Text(
                    'Show Orders',
                    style: TextStyle(color: blackcolor),
                  ),
                  trailing: Icon(
                    Icons.home,
                    color: blackcolor,
                  )),
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
