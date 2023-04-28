import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Adminpanel/AdminDrawer.dart';
import 'package:shop_app/constant.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('products').snapshots();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final modelcontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  void showModel(var id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: .5, color: inputborder))),
                controller: namecontroller,
                validator: (val) {
                  return 'Fill This Input';
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Price',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: .5, color: inputborder))),
                controller: pricecontroller,
                validator: (val) {
                  return 'Fill This Input';
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Model',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: .5, color: inputborder))),
                controller: modelcontroller,
                validator: (val) {
                  return 'Fill This Input';
                },
              ),
              SizedBox(
                height: 20,
              ),

              // DropdownButton(
              //   value: categoryValue,
              //   iconSize: 36,
              //   icon: Icon(Icons.arrow_drop_down),
              //   isExpanded: true,
              //   items: categoryList.map(builditems).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       categoryValue = value.toString();
              //     });
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Category',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(width: .5, color: inputborder))),
                controller: categorycontroller,
                validator: (val) {
                  return 'Fill This Input';
                },
              ),

              ElevatedButton.icon(
                  onPressed: () {
                    collectionReference.doc(id).update({
                      'name': namecontroller.text,
                      'price': double.parse(pricecontroller.text),
                      'model': modelcontroller.text,
                      'category': categorycontroller,
                    });
                  },
                  icon: Icon(Icons.update),
                  label: Text('Update'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrwawer(),
      appBar: AppBar(
        // actions: [
        //   // Row(
        //   //   children: [
        //   //     IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        //   //     IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        //   //   ],
        //   )
        // ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('Products',
                style: TextStyle(
                  fontSize: 22,
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onLongPress: () =>
                          showModel(snapshot.data!.docs[index].id),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]['image'].toString(),
                            )),
                        title: Text(
                          snapshot.data!.docs[index]['name'].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing:
                            // IconButton(
                            //   onPressed: () {
                            //     showModel(snapshot.data!.docs[index].id);
                            //   },
                            //   icon: Icon(
                            //     Icons.update,
                            //     color: existvalue,
                            //     size: 30,
                            //   ),
                            // ),
                            IconButton(
                          onPressed: () {
                            collectionReference
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: existvalue,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
