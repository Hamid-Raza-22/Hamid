// import 'package:flutter/material.dart';
//
// import '../Databases/DBHelperOrder.dart';
// import '../Models/OrderModel.dart';
// //import '../Models/ShopModel.dart';
//
// class OrderList extends StatefulWidget {
//   final List<OrderModel> savedOrderData;
//
//   const OrderList({super.key, required this.savedOrderData});
//
//   @override
//   _OrderListState createState() => _OrderListState();
// }
//
// class _OrderListState extends State<OrderList> {
//   List<OrderModel> _orderList = [];
//
//
//   @override
//   void initState() {
//     super.initState();
//     _orderList =  widget.savedOrderData;
//   }
//
//
//
//   void _deleteOrder(int index) async {
//     final order = _orderList[index];
//
//     // Delete the shop from the database.
//     final deletedRows = await OrderDatabase().deleteOrder(order.id!);
//
//     if (deletedRows > 0) {
//       // If the delete operation was successful in the database, update the UI.
//       setState(() {
//         _orderList.removeAt(index);
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Orders'),
//       ),
//       body: ListView.builder(
//         itemCount: _orderList.length,
//         itemBuilder: (context, index) {
//           final order = _orderList[index];
//
//           return ListTile(
//             title: Text(order.ShopName!),
//             subtitle: Text(order.Brand!),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 _deleteOrder(index);
//               },
//             ),
//             onTap: () {
//
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => OrderDetailPage(order: order),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// // The ShopDetailPage remains the same.
//
//
// class OrderDetailPage extends StatelessWidget {
//   final OrderModel order;
//
//   OrderDetailPage({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Shop Name: ${order.ShopName ?? "N/A"}'),
//            // Text('Shop City: ${shop.city ?? "N/A"}'),
//             //Text('Shop Address: ${shop.shopAddress ?? "N/A"}'),
//             Text('Owner Name: ${order.OwnerName ?? "N/A"}'),
//             //Text('Owner CNIC: ${shop.ownerCNIC ?? "N/A"}'),
//             Text('Phone Number: ${order.PhoneNo ?? "N/A"}'),
//             //Text('Alternative Phone Number: ${shop.alternativePhoneNo ?? "N/A"}'),
//             Text('Brand: ${order.Brand ?? "N/A"}'),
//             // Add more details as needed.
//           ],
//         ),
//       ),
//     );
//   }
// }
