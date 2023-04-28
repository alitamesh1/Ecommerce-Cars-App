import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  double totl = 0.0;
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    return _items.length;
  }

  // double get totalamount {
  //   totl+=
  // }
  double get totalprice {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.price * cartitem.quantity;
    });
    return total;
    notifyListeners();
  }

  void removeitems() {
    _items = {};
  }

  void additem(String proid, double _price, String _title) {
    // String? proid;
    // double? _price;
    // String? _title;

    _items.putIfAbsent(
        proid,
        () => CartItem(
            id: DateTime.now().toString(),
            title: _title,
            quantity: 1,
            price: _price));
    notifyListeners();
  }

  void removeitem(String proid) {
    _items.remove(proid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
