import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Adminpanel/AllProducts.dart';
import 'package:shop_app/AuthPage.dart';
import 'package:shop_app/pages/FavoratePage.dart';
import 'package:shop_app/pages/Home.dart';
import 'package:shop_app/pages/OrdersPage.dart';
import 'package:shop_app/pages/screemtyy.dart';

import '../constant.dart';

class MyDreawer extends StatefulWidget {
  MyDreawer({
    Key? key,
  }) : super(key: key);

  @override
  _MyDreawerState createState() => _MyDreawerState();
}

class _MyDreawerState extends State<MyDreawer> {
  final user = FirebaseAuth.instance.currentUser!.email;

  String username = '';

  void getUserName() async {
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
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: username.isEmpty
                  ? Text('Name: ' + 'User')
                  : Text('Name:' + username.toString()),
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
                    'Home Page',
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
                    MaterialPageRoute(builder: (context) => Home(false)));
              },
              child: ListTile(
                  title: Text(
                    'New Arravils',
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
            child: ListTile(
              title: Text(
                'Favorate',
                style: TextStyle(color: blackcolor),
              ),
              trailing: Icon(
                Icons.favorite,
                color: blackcolor,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FAvoratePage()));
              },
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrdersPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                  title: Text(
                    'Orders',
                    style: TextStyle(color: blackcolor),
                  ),
                  trailing: Icon(
                    Icons.bubble_chart,
                    color: blackcolor,
                  )),
            ),
          ),
          Divider(
            height: .2,
            color: Colors.black,
          ),
          SizedBox(
            height: 70,
          ),
          user!.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                      title: Text(
                        'Log In',
                        style: TextStyle(color: blackcolor),
                      ),
                      trailing: Icon(
                        Icons.home,
                        color: blackcolor,
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                      title: Text(
                        'Log Out',
                        style: TextStyle(color: blackcolor),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthPage()));
                      },
                      trailing: Icon(
                        Icons.home,
                        color: blackcolor,
                      )),
                ),
          Divider(
            height: .2,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
