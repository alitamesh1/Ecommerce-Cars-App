import 'package:flutter/material.dart';
import 'package:shop_app/pages/Login.dart';
import 'package:shop_app/pages/SignUp.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LogInPage(
          onClicktoggle: toggle,
        )
      : SignUpPage(
          onclicedsigned: toggle,
        );

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
