import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/Favoraties.dart';

class FavorateItemWidget extends StatefulWidget {
  String? id, name, price, image;
  FavorateItemWidget(this.id, this.name, this.price, this.image);

  @override
  State<FavorateItemWidget> createState() => _FavorateItemWidgetState();
}

class _FavorateItemWidgetState extends State<FavorateItemWidget> {
  @override
  Widget build(BuildContext context) {
    final favorate = Provider.of<Favorate>(context);
    final cart = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.red[700]!),
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.name!.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.price!),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.image!),
            ),
            onLongPress: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Do You Want Add To Cart? '),
                      actions: [
                        TextButton(
                            onPressed: () {
                              cart.additem(widget.id!,
                                  double.parse(widget.price!), widget.name!);
                              Navigator.pop(context);
                              // favorate.removeitem(widget.id!);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No',
                                style: TextStyle(color: Colors.black))),
                      ],
                    );
                  });
            },
            trailing: IconButton(
                onPressed: () {
                  favorate.removeitem(widget.id!);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
          // IconButton(
          //     onPressed: () {
          //       favorate.removeitem(widget.id!);
          //     },
          //     icon: Icon(
          //       Icons.delete,
          //       color: Colors.red,
          //     )),
        ],
      ),
    );
  }
}
