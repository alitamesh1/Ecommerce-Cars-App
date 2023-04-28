import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:flutter/foundation.dart';

class Productorders {
  static Productorders order = new Productorders();
  String? id;
  double? amount;
  DateTime? dateTime;
  List<String>? lists;
  Productorders.pro({this.lists});
  Productorders({this.id, this.amount, this.lists, this.dateTime});
}

class OrderItem {
  final String? id;
  final double? amount;
  final List<String>? products;
  final String? dateTime;
  final String? address;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime,
      @required this.address});
}

class Order with ChangeNotifier {
  Map<String, OrderItem> _orders = {};
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('orders');

  void addOneOrder(
      String proid, List<String> product, double amount, String address) {
    _orders.putIfAbsent(
        proid,
        () => OrderItem(
            id: DateTime.now().toString(),
            amount: amount,
            products: product,
            dateTime: DateTime.now().toString(),
            address: address));
    notifyListeners();
  }

  Map<String, OrderItem> get orders {
    return {..._orders};
  }

  int get count {
    return _orders.length;
  }

  // Future addNewOrder(double amount, Productorders order) async {
  //   Productorders order = new Productorders();
  //   List<String>? listid;
  //   Productorders.pro(lists: order.lists);
  //   collectionReference.add({
  //     // 'id': Productorders.order.id,
  //     'id': DateTime.now().second.toString(),
  //     'amount': amount.toString(),
  //     'datetime': DateTime.now().toString(),
  //     'products': orders.map((e) => e.id).toList(),
  //   }).then((value) => print('ok'));
  // }

  // Future<void> ftectd(String s) async {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection('new');

  //   collectionReference.where('userid', isEqualTo: s).get();
  //   List<OrderItem> orderlist = [];
  //   var ordersData = collectionReference.get() as Map<String, dynamic>;

  //   if (ordersData == null) {
  //     return;
  //   }

  //   ordersData.forEach((orderid, orderitemdata) {
  //     orderlist.add(OrderItem(
  //         id: orderid,
  //         amount: orderitemdata['amount'],
  //         products: (orderitemdata['products'] as List<dynamic>)
  //             .map((item) => CartItem(
  //                 id: item['id'].toString(),
  //                 title: item['title'],
  //                 quantity: item['quantity'],
  //                 price: item['price']))
  //             .toList(),
  //         dateTime: DateTime.parse(orderitemdata['datetime'])));
  //   });
  //   _orders = orderlist.reversed.toList();
  //   notifyListeners();
  // }

  // Future<void> fetchOrderData() async {
  //   CollectionReference collectionReference =
  //       await FirebaseFirestore.instance.collection('orders');
  //   List<OrderItem> orderlist = [];
  //   var ordersData = collectionReference.get() as Map<String, dynamic>;

  //   if (ordersData == null) {
  //     return;
  //   }

  //   ordersData.forEach((orderid, orderitemdata) {
  //     orderlist.add(OrderItem(
  //         id: orderid,
  //         amount: orderitemdata['amount'],
  //         products: (orderitemdata['products'] as List<dynamic>)
  //             .map((item) => CartItem(
  //                 id: item['id'].toString(),
  //                 title: item['title'],
  //                 quantity: item['quantity'],
  //                 price: item['price']))
  //             .toList(),
  //         dateTime: DateTime.parse(orderitemdata['datetime'])));
  //   });
  //   _orders = orderlist.reversed.toList();
  //   notifyListeners();
  // }

  Future<void> addOrders(String id, String quan, String price, String title,
      double amount, BuildContext context) async {
    final datestamb = DateTime.now().toString();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('orders');

    collectionReference
        .add({
          'datetime': datestamb.toString(),
          'id': DateTime.now().second.toString(),
          'amount': amount.toString(),
          'products': {
            'id': id,
            'quantity': quan,
            'price': price,
            'title': title
          }
        })
        .then((value) => print('ok'))
        .catchError((e) => print(e));
    // cartlist
    //     .map((e) => {
    //           'id': e.id.toString(),
    //           'quantity': e.quantity.toString(),
    //           'price': e.price.toString(),
    //           'title': e.title.toString()
    //         })
    //     .toList()
    // })
    // .then((value) => print(value))
    // .catchError((s) => print(s));
    // .then((value) => ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Inserts Done'))))
    // .catchError((ee) => ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('$ee'))));
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartitem, double total) async {
    final datestamb = DateTime.now().toString();
    CollectionReference collectionReference =
        await FirebaseFirestore.instance.collection('orders');

    collectionReference.add({
      'datetime': datestamb,
      'id': DateTime.now().toString(),
      'amount': total.toString(),
      'products': cartitem.map((e) => {
            'id': e.id.toString(),
            'quantity': e.quantity.toString(),
            'price': e.price.toString(),
            'title': e.title.toString()
          })
    });
    // .then((value) => ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Inserts Done'))))
    // .catchError((_) => ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Wrong Thing'))));
    notifyListeners();
  }
}
