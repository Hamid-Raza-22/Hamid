// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../API/ApiServices.dart';
// import '../Models/ProductsModel.dart';
// import '../View_Models/OrderViewModels/OrderDetailsViewModel.dart';
// import '../View_Models/OrderViewModels/OrderMasterViewModel.dart';
// import '../View_Models/OrderViewModels/ProductsViewModel.dart';
// import 'OrderMasterList.dart';
//
// void main() => runApp(MaterialApp(
//   home: OrderBookingPage(),
// ));
//
// class OrderBookingPage extends StatefulWidget {
//   @override
//   _OrderBookingPageState createState() => _OrderBookingPageState();
// }
//
// class _OrderBookingPageState extends State<OrderBookingPage> {
//   final ordermasterViewModel = Get.put(OrderMasterViewModel());
//   final orderdetailsViewModel = Get.put(OrderDetailsViewModel());
//   final productsViewModel = Get.put(ProductsViewModel());
//
//   final shopNameController = TextEditingController();
//   final ownerNameController = TextEditingController();
//   final phoneNoController = TextEditingController();
//   final brandController = TextEditingController();
//
//   final api = ApiServices();
//
//   int? ordermasterId;
//   int? orderdetailsId;
//   int? productsId;
//   ProductsModel? selectedProduct;
//   List<RowData> rowDataList = []; // Store data for multiple rows
//
//   @override
//   void initState() {
//     // Initially add two rows
//     addNewRow();
//     addNewRow();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Booking'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.centerRight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     'DATE',
//                     style: TextStyle(fontSize: 13, color: Colors.black),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                     height: 30,
//                     width: 100,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Field 1',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       textAlign: TextAlign.right,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter some text';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             buildTextFormField('Shop Name', 'Field 1', shopNameController),
//             SizedBox(height: 10),
//             buildTextFormField('Owner Name', 'Field 2', _textField2Controller),
//             SizedBox(height: 10),
//             buildTextFormField('Phone#', 'Field 3', _textField3Controller),
//             SizedBox(height: 10),
//             buildTextFormField('Brand', 'Field 4', _textField4Controller),
//             SizedBox(height: 10),
//             for (var rowData in rowDataList)
//               buildRow(rowData),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.center,
//               child: ElevatedButton(
//                 onPressed: () {
//                   addNewRow();
//                 },
//                 child: Text('Add Products'),
//               ),
//             ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.center,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (shopNameController.text.isNotEmpty) {
//                     ordermasterViewModel.addOrderMaster(OrderMasterModel(
//                       orderId: ordermasterId,
//                       shopName: shopNameController.text,
//                       ownerName: ownerNameController.text,
//                       phoneNo: phoneNoController.text,
//                       brand: brandController.text,
//                       product: selectedProduct,
//                     ));
//
//                     senddata();
//
//                     shopNameController.text = "";
//                     ownerNameController.text = "";
//                     phoneNoController.text = "";
//                     brandController.text = "";
//
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             OrderMasterList(savedOrderMasterData: ordermasterViewModel.allOrderMaster),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Confirm'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextFormField(
//       String labelText,
//       String hintText,
//       TextEditingController controller,
//       ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//           style: TextStyle(fontSize: 13, color: Colors.black),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 30,
//           child: TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: hintText,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//             ),
//             style: TextStyle(fontSize: 13),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildRow(RowData rowData) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Item',
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: 200,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: DropdownButton<String>(
//                   isExpanded: true,
//                   value: rowData.selectedDropdownValue,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       rowData.selectedDropdownValue = newValue;
//                     });
//                   },
//                   items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                       .map<DropdownMenuItem<String>>(
//                         (String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     },
//                   ).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Qty',
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 height: 30,
//                 width: 78,
//                 child: TextFormField(
//                   controller: rowData.qtyController,
//                   decoration: InputDecoration(
//                     labelText: 'Qty',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     calculateAmount(
//                         rowData.qtyController, rowData.rateController, rowData.amountController);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Rate',
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 height: 30,
//                 width: 60,
//                 child: TextFormField(
//                   controller: rowData.rateController,
//                   decoration: InputDecoration(
//                     labelText: 'Rate',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     calculateAmount(
//                         rowData.qtyController, rowData.rateController, rowData.amountController);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Amount',
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 height: 30,
//                 child: TextFormField(
//                   controller: rowData.amountController,
//                   decoration: InputDecoration(
//                     labelText: 'Amount',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   void addNewRow() {
//     setState(() {
//       final newRowNumber = rowDataList.length + 1;
//       final newRow = RowData(
//         rowNumber: newRowNumber,
//         qtyController: TextEditingController(),
//         rateController: TextEditingController(),
//         amountController: TextEditingController(),
//         selectedDropdownValue: null,
//       );
//       rowDataList.add(newRow);
//     });
//   }
//
//   void calculateAmount(
//       TextEditingController qtyController,
//       TextEditingController rateController,
//       TextEditingController amountController,
//       ) {
//     String? qty = qtyController.text;
//     String? rate = rateController.text;
//
//     if (qty != null && rate != null) {
//       try {
//         double qtyValue = double.parse(qty);
//         double rateValue = double.parse(rate);
//         double amount = qtyValue * rateValue;
//         amountController.text = amount.toStringAsFixed(2); // Rounded to 2 decimal places
//       } catch (e) {
//         amountController.text = '';
//       }
//     } else {
//       amountController.text = '';
//     }
//   }
// }
//
// class RowData {
//   final int rowNumber;
//   final TextEditingController qtyController;
//   final TextEditingController rateController;
//   final TextEditingController amountController;
//   String? selectedDropdownValue;
//
//   RowData({
//   required this.rowNumber,
//   required this.qtyController,
//   required this.rateController,
//   required this.amountController,
//   this.selectedDropdownValue,
//   });
// }