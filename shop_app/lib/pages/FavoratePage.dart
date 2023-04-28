import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Favoraties.dart';
import 'package:shop_app/widgets/MyDrawer.dart';
import 'package:shop_app/widgets/favorateItem.dart';

class FAvoratePage extends StatefulWidget {
  @override
  State<FAvoratePage> createState() => _FAvoratePageState();
}

class _FAvoratePageState extends State<FAvoratePage> {
  @override
  Widget build(BuildContext context) {
    final favorate = Provider.of<Favorate>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favoraties'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      drawer: MyDreawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Center(
              child: Text(
                'Your Favorate',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: favorate.favorateList.length,
                  itemBuilder: (context, index) {
                    return FavorateItemWidget(
                        favorate.favorateList.values.toList()[index].id,
                        favorate.favorateList.values.toList()[index].name,
                        favorate.favorateList.values
                            .toList()[index]
                            .price
                            .toString(),
                        favorate.favorateList.values.toList()[index].image);
                  }))
        ],
      ),
    );
  }
}
