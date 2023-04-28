import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/pages/Login.dart';
import 'package:shop_app/pages/screemtyy.dart';
import 'package:shop_app/pages/spalsh.dart';

import '../constant.dart';

class SignUpPage extends StatefulWidget {
  final Function() onclicedsigned;
  SignUpPage({required this.onclicedsigned});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('usersdata');

  final keyform = GlobalKey<FormState>();

  Future signUpFire() async {
    final vald = keyform.currentState!.validate();

    if (!vald) keyform.currentState!.save();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      await collectionReference.doc(FirebaseAuth.instance.currentUser!.uid).set(
          {'username': namecontroller.text, 'email': emailcontroller.text});

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplachPage()));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future signup() async {
    //if (keyform.currentState!.validate()) keyform.currentState!.save();

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    if (namecontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        emailcontroller.text.isNotEmpty &&
        confirmpasswordcontroller.text.isNotEmpty) {
      if (keyform.currentState!.validate()) keyform.currentState!.save();
      if (confirmpasswordcontroller.text == passwordcontroller.text) {
        collectionReference.add({
          'username': namecontroller.text,
          'password': passwordcontroller.text,
          'email': emailcontroller.text
        }).then((value) {
          return {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Sign Up Corrrectly'))),
            namecontroller.text = "",
            emailcontroller.text = "",
            confirmpasswordcontroller.text = "",
            passwordcontroller.text = ""
          };
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('confirm the password correctly')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fill The filed First')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // delete appbar
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "Sign UP",
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
                          decoration: InputDecoration(
                              hintText: 'UserName',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: .5, color: inputborder))),
                          controller: namecontroller,
                          validator: (val) {
                            if (val!.isEmpty)
                              return 'Fill This Input';
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: .5, color: inputborder))),
                          validator: (val) {
                            if (val != passwordcontroller.text)
                              return 'Write the Password the Same';
                            else
                              return null;
                          },
                          controller: confirmpasswordcontroller,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: signUpFire,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Sign Up',
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
                                text: 'Already Have an Account? ',
                                children: [
                              TextSpan(
                                  text: 'Log In',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onclicedsigned,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue[400]))
                            ])),
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
