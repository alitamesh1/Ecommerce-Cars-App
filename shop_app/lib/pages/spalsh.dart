import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Adminpanel/AllProducts.dart';
import 'package:shop_app/pages/Home.dart';

class SplachPage extends StatefulWidget {
  const SplachPage({Key? key}) : super(key: key);

  @override
  State<SplachPage> createState() => _SplachPageState();
}

class _SplachPageState extends State<SplachPage> {
  String username = 'user';
  void _checkUser() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('usersdata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = snapshot['username'];
    });

    if (username == 'adminshop') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllProducts()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(true)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Welcome',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
