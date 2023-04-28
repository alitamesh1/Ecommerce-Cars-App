import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/pages/Home.dart';
import 'package:shop_app/pages/SignUp.dart';
import 'package:shop_app/pages/screemtyy.dart';
import 'package:shop_app/pages/spalsh.dart';

import '../constant.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback onClicktoggle;
  LogInPage({required this.onClicktoggle});
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  final keyform = GlobalKey<FormState>();

  Future logIn() async {
    final valid = keyform.currentState!.validate();
    if (valid) keyform.currentState!.save();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplachPage()));

      // await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailcontroller.text, password: passwordcontroller.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  // String? username;
  // String? password;

  // List<QuerySnapshot> usernamelist = [];
  // List<String> userpasswordlist = [];
  // getdata() async {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('users');

  //   var resopser = await collectionReference.doc().get();

  //   usernamelist = resopser.get('username');
  //   userpasswordlist = resopser.get('password');
  //   //   username = element['username'].toString();
  //   //   password = element['password'].toString();
  //   //   usernamelist.add(element['username'].data().toString());
  //   //   userpasswordlist.add(element['password'].data().toString());
  //   // });
  // }

  // login() async {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('users');

  //   var resopser = await collectionReference
  //       .where('username', isEqualTo: usernamelist)
  //       .get();
  //   resopser.docs.forEach((element) {
  //     setState(() {
  //       //usernamelist.add();
  //     });
  //   });

  // usernamelist.add(resopser.get('username'));

  // await collectionReference
  //     .where('username', isEqualTo: usernamelist[0]['username'].toString())
  //     .get();

  // await collectionReference.where('password', isEqualTo: password).get();

  //   if (namecontroller.text == username &&
  //       passwordcontroller.text == password) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('correct')));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('wrong password or username')));
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // delete appbar

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // usernamelist[0].isEmpty
              //     ? Text('data')
              //     : Text(usernamelist[0].toString()),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Form(
                    key: keyform,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: .5, color: inputborder))),
                          controller: emailcontroller,
                          validator: (val) {
                            if (val!.isEmpty || !val.contains('@'))
                              return 'Fill This Input with valid email';
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: .5, color: inputborder))),
                          controller: passwordcontroller,
                          validator: (val) {
                            if (val!.isEmpty || val.length < 6)
                              return 'Fill This Input at least 6 char';
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: logIn,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'LogIn',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: 'No Account? ',
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClicktoggle,
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue[200]))
                            ])),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) => Try()));
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //         color: inputborder,
                        //         border:
                        //             Border.all(width: 1, color: Colors.red[800]!),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Center(
                        //       child: Text(
                        //         'Sign Up',
                        //         style:
                        //             TextStyle(color: Colors.white, fontSize: 18),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
