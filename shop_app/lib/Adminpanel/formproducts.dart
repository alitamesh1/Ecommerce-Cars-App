import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Adminpanel/AdminDrawer.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/pages/homepage.dart';

class FormProducts extends StatefulWidget {
  @override
  _FormProductsState createState() => _FormProductsState();
}

class _FormProductsState extends State<FormProducts> {
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final modelcontroller = TextEditingController();
  final categorycontroller = TextEditingController();

  final keyform = GlobalKey<FormState>();
  File? file;
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');
  var filepath;
  var filename;

  Future getdata() async {
    collectionReference.get();
  }

  final categoryList = ['TOYOTA', 'Audi', 'BMW'];

  Future selectfile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No selected File')));
    }

    filepath = result.files.single.path;
    filename = result.files.single.name;
    setState(() {
      file = File(filepath);
    });
  }

  DropdownMenuItem<String> builditems(String item) => DropdownMenuItem(
        value: item,
        child: Text("$item"),
      );

  Future upload() async {
    // CollectionReference collectionReference =
    //   storage.ref('files/$filename').putFile(file!);
    // final valdiation = keyform.currentState!.validate();

    // if (!valdiation) return;
    //if (keyform.currentState!.validate()) return keyform.currentState!.save();

    if (file == null)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Select File First')));

    Reference reference = storage.ref().child('files').child('$filename');
    UploadTask task = reference.putFile(file!);

    task.whenComplete(() async {
      var downloadlink = await task.snapshot.ref.getDownloadURL();
      // collectionReference.add({

      // });
      if (downloadlink.isNotEmpty) {
        collectionReference
            .add({
              'name': namecontroller.text,
              'price': double.parse(pricecontroller.text),
              'model': modelcontroller.text,
              'category': this.categoryValue,
              'image': downloadlink
            })
            .then((value) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Inserted Done'))))
            .then((value) {
              namecontroller.text = '';
              pricecontroller.text = '';
              //categorycontroller.text = '';
              modelcontroller.text = '';
              this.categoryValue = null;
              setState(() {
                file = null;
              });
            });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Inserted Done')));
      }
    });
  }

  String? categoryValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrwawer(),
      appBar: AppBar(
        // // actions: [
        // //   Row(
        // //     children: [
        // //       // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        // //     ],
        // //   )
        // ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('Products',
                style: TextStyle(
                  fontSize: 22,
                ))
          ],
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => HomePage()));
        //     },
        //     icon: Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  "Add a Product",
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
                            hintText: 'Name',
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: .5, color: inputborder))),
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
                                borderSide:
                                    BorderSide(width: .5, color: inputborder))),
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
                                borderSide:
                                    BorderSide(width: .5, color: inputborder))),
                        controller: modelcontroller,
                        validator: (val) {
                          return 'Fill This Input';
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      DropdownButton(
                        value: categoryValue,
                        iconSize: 36,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        items: categoryList.map(builditems).toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryValue = value.toString();
                          });
                        },
                      ),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       hintText: 'Category',
                      //       border: UnderlineInputBorder(
                      //           borderSide:
                      //               BorderSide(width: .5, color: inputborder))),
                      //   controller: categorycontroller,
                      //   validator: (val) {
                      //     return 'Fill This Input';
                      //   },
                      //),
                      SizedBox(
                        height: 40,
                      ),
                      file == null
                          ? GestureDetector(
                              onTap: selectfile,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        width: 1, color: Colors.red[800]!),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Select File',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: existvalue,
                                  border: Border.all(
                                      width: 1, color: Colors.red[800]!),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'File Is aleredy Exist',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: upload,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: inputborder,
                              border:
                                  Border.all(width: 1, color: Colors.red[800]!),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Upload',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
