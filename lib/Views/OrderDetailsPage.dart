// import 'package:flutter/material.dart';
//
// import '../Databases/OrderDatabase/DBHelperOrderMaster.dart';
// import '../Models/OrderModels/OrderMasterModel.dart';
//
// List<OrderMasterModel> orderMasters = [];
//
// @override
// void initState() {
//   super.initState();
//   loadOrderMasters();
// }
//
// void loadOrderMasters() async {
//   final db = DBHelperOrderMaster();
//   final masters = await db.getOrderMasters();
//   setState(() {
//     orderMasters = masters;
//   });
// }
//
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Order Master List'),
//     ),
//     body: ListView.builder(
//       itemCount: orderMasters.length,
//       itemBuilder: (context, index) {
//         final orderMaster = orderMasters[index];
//         return ListTile(
//           title: Text(orderMaster.shopName!),
//           subtitle: Text(orderMaster.date!),
//           // Add other order master details here
//         );
//       },
//     ),
//   );
// }
