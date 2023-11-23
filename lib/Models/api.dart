// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import '../Databases/OrderDatabase.dart';
// import 'OrderDetails.dart';
// import 'ProductsModel.dart';
//
// Future<void> fetchProductData() async {
//   final url = Uri.parse('https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/product/record/' ); // Replace with your API URL
//   try {
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       // If the request is successful, parse the JSON response
//       final List<dynamic> products = json.decode(response.body);
//
//       // Clear existing product data
//      // await DatabaseHelper.instance.clearProductTable();
//
//       // Insert the retrieved data into your product table
//       for (var productData in products) {
//         final product = Product.fromMap(productData);
//         await DatabaseHelper.instance.enterProduct(product);
//
//         // Retrieve product data and insert into OrderDetails
//         final productCode = product.product_code;
//         final productByName = await DatabaseHelper.instance.getProductByCode(productCode);
//         if (productByName != null) {
//           final productName = productByName.product_name;
//           final uom = productByName.uom;
//           final price = productByName.price;
//
//           // Create an OrderDetails instance with product data and order information
//           final orderDetails = OrderDetails(
//             productCode: productCode,
//             productName: productName,
//             uom: uom,
//             price: price,
//             quantity: 1,
//             orderId: '', // Replace with your order ID
//           );
//
//           // Insert the order details into the OrderDetails table
//           await DatabaseHelper.instance.insertOrderDetails(orderDetails);
//         }
//       }
//
//       // Display a success message or update the UI
//       Fluttertoast.showToast(
//         msg: 'Product data fetched and saved successfully!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     } else {
//       // Handle the error
//       print('Failed to fetch product data: ${response.statusCode}');
//       print(response.body);
//
//       // Display an error message or update the UI accordingly
//       Fluttertoast.showToast(
//         msg: 'Failed to fetch product data',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   } catch (e) {
//     // Handle network or other exceptions
//     print('Error: $e');
//
//     // Display an error message or update the UI accordingly
//     Fluttertoast.showToast(
//       msg: 'Error: $e',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }
// }