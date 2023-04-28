// import 'dart:math';

// import 'package:flutter/material.dart';

// import '../providers/order.dart' as ord;

// class OrderItemWidget extends StatefulWidget {
//   //final ord.OrderItem order;
//   String? amount, uid, date, name;
//   //OrderItemWidget(this.order);
//   //List<String>? products;
//   int? quan;
//   OrderItemWidget.from(
//       {this.amount, this.quan, this.date, this.name, this.uid});

//   @override
//   _OrderItemWidgetState createState() => _OrderItemWidgetState();
// }

// class _OrderItemWidgetState extends State<OrderItemWidget> {
//   var _expanded = false;
//   @override
//   Widget build(BuildContext context) {
//     //  if (widget.products == null) widget.products = [];
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text('\$' + widget.amount.toString()),
//             subtitle: Text(widget.date.toString()),
//             trailing: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _expanded = !_expanded;
//                   });
//                 },
//                 icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
//           ),
//           if (_expanded)
//             // Container(
//             //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//             //   height: min(widget.products!.length * 20.0 + 10, 100),
//             //   child: ListView(
//             //     children: widget.products!
//             //         .map((proid) => Row(
//             //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //               children: [
//             //                 Text(
//             //                   widget.products,
//             //                   style: TextStyle(
//             //                     fontSize: 18,
//             //                     fontWeight: FontWeight.bold,
//             //                   ),
//             //                 ),
//             //                 Text(
//             //                   "${proid.quantity} X \$${proid.price}",
//             //                   style: TextStyle(
//             //                     fontSize: 18,
//             //                     color: Colors.grey,
//             //                   ),
//             //                 )
//             //               ],
//             //             ))
//             //         .toList(),
//             //   ),

//             // ),

//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//               height: 400,

//               // child: ListView.builder(
//               //   itemCount: widget.products!.length,
//               //   itemBuilder: (context, i) {
//               //     return Row(
//               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //       children: [
//               //         Text(
//               //           widget.products![i],
//               //           style: TextStyle(
//               //             fontSize: 18,
//               //             fontWeight: FontWeight.bold,
//               //           ),
//               //         ),
//               //         Text(
//               //           "${widget.quan}",
//               //           style: TextStyle(
//               //             fontSize: 18,
//               //             color: Colors.grey,
//               //           ),
//               //         )
//               //       ],
//               //     );
//               //   },

//               //   children: widget.products!
//               //       .map((proid) => Row(
//               //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //             children: [
//               //               Text(
//               //                 widget.products,
//               //                 style: TextStyle(
//               //                   fontSize: 18,
//               //                   fontWeight: FontWeight.bold,
//               //                 ),
//               //               ),
//               //               Text(
//               //                 "${proid.quantity} X \$${proid.price}",
//               //                 style: TextStyle(
//               //                   fontSize: 18,
//               //                   color: Colors.grey,
//               //                 ),
//               //               )
//               //             ],
//               //           ))
//               //   .toList(),
//               //),
//             ),
//         ],
//       ),
//     );
//   }
// }
