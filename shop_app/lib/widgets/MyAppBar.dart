import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
      ],
      title: Row(
        children: [
        
          Text(
            'Home',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text('Page',
              style: TextStyle(
                fontSize: 22,
              ))
        ],
      ),
      centerTitle: true,
    );
  }
}
