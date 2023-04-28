import 'package:flutter/material.dart';

class favorateItem {
  String? id, name, price, image;

  favorateItem({this.id, this.name, this.price, this.image});
}

class Favorate with ChangeNotifier {
  Map<String, favorateItem> favorateList = {};

  List<String> lists = [];

  void add(String name, String price) {}

  int get count {
    return favorateList.length;
  }

  Map<String, favorateItem> get items {
    return {...favorateList};
  }

  void addFavorate(String favorid, String name, String price, String image) {
    favorateList.putIfAbsent(
        favorid,
        () =>
            favorateItem(id: favorid, name: name, price: price, image: image));

    notifyListeners();
  }

  void removeitem(String proid) {
    favorateList.remove(proid);
    notifyListeners();
  }
}
