import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Adminpanel/AllProducts.dart';
import 'package:shop_app/Adminpanel/formproducts.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/pages/Home.dart';
import 'package:shop_app/pages/LogIn.dart';
import 'package:shop_app/pages/MapScreen.dart';
import 'package:shop_app/pages/OrdersPage.dart';
import 'package:shop_app/pages/SignUp.dart';
import 'package:shop_app/pages/addToCart.dart';
import 'package:shop_app/pages/categoryproducts.dart';
import 'package:shop_app/pages/detailsPage.dart';
import 'package:shop_app/pages/homepage.dart';
import 'package:shop_app/pages/location.dart';
import 'package:shop_app/pages/screemtyy.dart';
import 'package:shop_app/pages/spalsh.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/Favoraties.dart';
import 'package:shop_app/providers/order.dart';

import 'AuthPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Order()),
        ChangeNotifierProvider.value(value: Favorate())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //navigatorKey: navigatorKey,
        theme: ThemeData(primaryColor: blackcolor),
        title: 'Shop App',
        home: MainPage(),
      ),
    );
  }
}

//final navigatorKey = GlobalKey<NavigatorState>();

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home(true);
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
