import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AdminDrawer.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  final stream = FirebaseFirestore.instance.collection('lastOrders');

  String username = '';
  List<String> uid = [];

  void sss() async {
    final DocumentSnapshot _snapshot = await FirebaseFirestore.instance
        .collection('usersdata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = _snapshot['username'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrwawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('Orders',
                style: TextStyle(
                  fontSize: 22,
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: stream.get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(
                child: Text('SomeThing Went Wrong'),
              );
            }
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    // uid=snapshot.data!.docs[i]['userid'];

                    return Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'Card Order',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'name:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                username.isEmpty ? '' : username,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data!.docs[i]['amount'].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'DateTime:',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  snapshot.data!.docs[i]['date'].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          snapshot.data!.docs[i]['address'].toString().isEmpty
                              ? Text('')
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        snapshot.data!.docs[i]['address']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                          // Text('Amount: ' +
                          //     snapshot.data!.docs[i]['amount'].toString()),
                          // snapshot.data!.docs[i]['address'].toString().isEmpty
                          //     ? Text('')
                          //     : Text('Address: ' +
                          //         snapshot.data!.docs[i]['address'].toString()),
                        ],
                      ),
                    );

                    // ListTile(
                    //   title: Text(snapshot.data!.docs[i]['userid'].toString()),
                    // );
                  });
            return Container();
          },
        ),
      ),
    );
  }
}
