//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//
//   DatabaseHelper._privateConstructor();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     // Get the application documents directory
//     String path = await getDatabasesPath();
//     String databasePath = join(path, 'your_database.db');
//
//     // Open the database
//     return await openDatabase(databasePath, version: 1, onCreate: _createTables);
//   }
//
//   Future<void> _createTables(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE ordermaster (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         shopName TEXT,
//         ownerName TEXT,
//         phoneNo TEXT,
//         brand TEXT,
//         date TEXT
//       )
//     ''');
//
//     await db.execute('''
//       CREATE TABLE orderdetails (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         ordermasterId INTEGER,
//         itemsDropdownValue TEXT,
//         qty INTEGER,
//         rate INTEGER,
//         amount INTEGER,
//         FOREIGN KEY (ordermasterId) REFERENCES ordermaster (id)
//       )
//     ''');
//   }
//
//   final database = await DatabaseHelper.instance.database;
//
// // Insert data into ordermaster table
//   await database.insert('ordermaster', {
//   'shopName': _ShopNameController.text,
//   'ownerName': _ownerNameController.text,
//   'phoneNo': _phoneNoController.text,
//   'brand': _brandNameController.text,
//   'date': _getCurrentDate(),
//   });
//
// // Retrieve the last inserted ordermasterId
//   int ordermasterId = await database.query('ordermaster').max('id') as int;
//
// // Insert data into orderdetails table for each row
//   for (var rowData in rowDataList) {
//   await database.insert('orderdetails', {
//   'ordermasterId': ordermasterId,
//   'itemsDropdownValue': rowData.itemsDropdownValue,
//   'qty': int.tryParse(rowData.qtyController.text) ?? 0,
//   'rate': int.tryParse(rowData.rateController.text) ?? 0,
//   'amount': int.tryParse(rowData.amountController.text) ?? 0,
//   });
//   }
//
//
//
//
//
// }
//
//
//
// //
// //
// // import '../Models/OrderMaster.dart';
// //
// // import '../Models/ProductsModel.dart';
// // import '../Views/OrderBookingPage.dart';
// // import 'dart:io' as io;
// // import 'dart:async';
// // import 'package:get/get.dart';
// //
// // class DatabaseHelper {
// //   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
// //   static Database? _database;
// //
// //   DatabaseHelper._privateConstructor();
// //
// //   Future<Database> get database async {
// //     if (_database != null) {
// //       return _database!;
// //     } else {
// //
// //
// //
// //       //_database = await openDatabase(join(await getDatabasesPath(), 'order_database.db'));
// //     }
// //     _database = await _initDatabase();
// //     return _database!;
// //   }
// //
// //   Future<Database> _initDatabase() async {
// //     // ignore: non_constant_identifier_names
// //     io.Directory DocumentsDirectory = await getApplicationDocumentsDirectory();
// //     String path = join(DocumentsDirectory.path, 'APXorder.db');
// //     return await openDatabase(path, version: 1, onCreate: _createTables);
// //   }
// //
// //   Future<void> _createTables(Database db, int version) async {
// //     await db.execute('''
// //       CREATE TABLE OrderMaster (
// //         orderId TEXT PRIMARY KEY,
// //         shopName TEXT,
// //         ownerName TEXT,
// //         phoneNo TEXT,
// //         brand TEXT
// //       )
// //     ''');
// //
// //     await db.execute('''
// //     CREATE TABLE OrderDetails (
// //       id INTEGER PRIMARY KEY,
// //       product_code TEXT,
// //       quantity INTEGER,
// //       product_name TEXT,
// //       uom TEXT,
// //       price TEXT,
// //       FOREIGN KEY (orderId) REFERENCES OrderMaster(orderId)
// //     )
// //   ''');
// //
// //     await db.execute(
// //         "CREATE TABLE products(product_code TEXT PRIMARY KEY, product_name TEXT, uom TEXT ,price TEXT)"
// //     );
// //
// //   }
// //   Future<Object> getrow() async {
// //     final Database db = await _initDatabase();
// //     try {
// //       var results = await db.rawQuery("SELECT * FROM products");
// //       if (results.isNotEmpty) {
// //         return results;
// //       } else {
// //         print("No rows found in the 'products' table.");
// //         return false;
// //       }
// //     } catch (e) {
// //       print("Error retrieving product: $e");
// //       return false;
// //     }
// //   }
// //   Future<bool> enterProduct(Product product) async {
// //     final db = await database;
// //     await db.insert('products', product.toMap());
// //     return true;
// //   }
// //
// //   // Future<void> clearProductTable() async {
// //   //   final db = await database;
// //   //   await db.delete('product');
// //   // }
// //   Future<void> insertProduct(Product product) async {
// //     final db = await database;
// //     await db.insert('products', product.toMap());
// //   }
// //   Future<void> insertOrderDetails(OrderDetails orderDetails) async {
// //     final db = await database;
// //     await db.insert('OrderDetails', orderDetails.toMap());
// //   }
// //   Future<Product?> getProductByCode(String productCode) async {
// //     final db = await database;
// //     final results = await db.query('products',
// //         where: 'product_code = ?',
// //         whereArgs: [productCode],
// //         limit: 1);
// //     if (results.isNotEmpty) {
// //       return Product.fromMap(results.first);
// //     } else {
// //       return null;
// //     }
// //   }
// //   Future<List<Product>> fetchProducts() async {
// //     final db = await database;
// //     final List<Map<String, dynamic>> maps = await db.query('products');
// //
// //     // Convert the List<Map> into a List of Product objects
// //     return List.generate(maps.length, (index) {
// //       return Product.fromMap(maps[index]);
// //         // product_code: maps[index]['product_code'],
// //         // product_name: maps[index]['product_name'],
// //         // uom: maps[index]['uom'],
// //         // price: maps[index]['price'],
// //      // );
// //     });
// //   }
// //
// //   Future<int> insertOrder(OrderMaster order) async {
// //     final db = await database;
// //     return await db.insert('OrderMaster', order.toMap());
// //   }
// //
// // }
// //
// // // The rest of your code remains unchanged
// //
// // Future<void> insertOrderMaster(OrderMaster orderMaster) async {
// //   final db = await DatabaseHelper._database;
// //   await db?.insert('OrderMaster', orderMaster.toMap(),
// //   );
// // }
// //
// // Future<void> insertOrderDetails(OrderDetails orderDetails) async {
// //   final db = await DatabaseHelper._database;
// //   await db?.insert('OrderDetails', orderDetails.toMap());
// //
// // }
// // Future<List<OrderMaster>?> getOrders() async {
// //   final db = await DatabaseHelper.instance.database;
// //   final masterResults = await db.query('OrderMaster');
// //   final detailsResults = await db.query('OrderDetails');
// //
// //   // Create a map of order ID to order details
// //   final detailsMap = <String, List<OrderDetails>>{};
// //
// //   for (var row in detailsResults) {
// //     final detail = OrderDetails.fromMap(row);
// //     final orderId = detail.orderId;
// //
// //     if (!detailsMap.containsKey(orderId)) {
// //       detailsMap[orderId] = [];
// //     }
// //
// //     detailsMap[orderId]!.add(detail);
// //   }
// //
// //   final orders = masterResults.map((row) {
// //     final orderId = row['orderId'];
// //     final orderMaster = OrderMaster.fromMap(row);
// //   //  orderMaster.orderDetails = detailsMap[orderId] ?? [];
// //     return orderMaster;
// //   }).toList();
// //
// //   return orders;
// // }
