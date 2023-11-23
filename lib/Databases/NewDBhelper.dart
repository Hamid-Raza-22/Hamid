// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:io' as io;
// import 'dart:async';
//
// import '../Models/ShopModel.dart';
//
// class DBHelper {
//   static Database? _db;
//
//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDatabase();
//     return _db!;
//   }
//
//
//   Future<Database> initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'shop.db');
//     var db = await openDatabase(path, version: 2, onCreate: _onCreate , onUpgrade: _onUpgrade,);
//     return db;
//   }
//   Future<void> _onCreate(Database db, int version) async{
//     await db.execute("CREATE TABLE shop(id INTEGER PRIMARY KEY AUTOINCREMENT, shopName TEXT, city TEXT, shopAddress TEXT, ownerName TEXT, ownerCNIC TEXT, phoneNo TEXT, alternativePhoneNo TEXT)");
//     //DBProductsCategory
//     await db.execute("CREATE TABLE productCategory(product_brand TEXT)");
//     //DBHelperProducts
//     await db.execute("CREATE TABLE products(id NUMBER, product_code TEXT, product_name TEXT, uom TEXT ,price TEXT)");
//     //DBHelperOwner
//     await db.execute("CREATE TABLE ownerData(id NUMBER,shop_name TEXT, owner_name TEXT, owner_contact TEXT)");
//     //DBHelperOrderMaster
//     await db.execute("CREATE TABLE orderMaster(orderId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT, shopName TEXT, ownerName TEXT, phoneNo TEXT, brand TEXT, userId TEXT)");
//     //DBHelperOrderDetail
//     await db.execute('''
//       CREATE TABLE order_details(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         order_master_id INTEGER,
//         product_name TEXT,
//         quantity INTEGER,
//         price INTEGER,
//         amount INTEGER,
//         FOREIGN KEY (order_master_id) REFERENCES order_master(orderId)
//       )
//     ''');
//     //DBlogin
//     await db.execute("CREATE TABLE login(user_id TEXT , password TEXT )");
//
//   }
//
//
// }
// Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//   print('Database upgrade: from $oldVersion to $newVersion');
//   if (oldVersion < 2) {
//     print('Adding columns: city and alternativePhoneNo');
//     // Add the "city" column in version 2.
//     await db.execute('ALTER TABLE shop ADD COLUMN city TEXT');
//     // Add the "alternativePhoneNo" column in version 2.
//     await db.execute('ALTER TABLE shop ADD COLUMN alternativePhoneNo TEXT');
//
//   }
// }
//
// Future<ShopModel?> getShopData(int shopId) async {
//   final dbClient = await db;
//   final List<Map<String, dynamic>> maps = await dbClient!.query(
//     'shop',
//     where: 'id = ?',
//     whereArgs: [shopId],
//   );
//
//   if (maps.isNotEmpty) {
//     return ShopModel.fromMap(maps.first);
//   } else {
//     return null;
//   }
// }
// Future<bool> entershopdata(String shopName) async {
//   final Database db = await initDatabase();
//   try {
//     await db.rawInsert("INSERT INTO shops (shop_name) VALUES ('$shopName')");
//     return true;
//   } catch (e) {
//     print("Error inserting product: $e");
//     return false;
//   }
// }
// Future<Object> getrow() async {
//   final Database db = await initDatabase();
//   try {
//     var results = await db.rawQuery("SELECT * FROM shops");
//     if (results.isNotEmpty) {
//       return results;
//     } else {
//       print("No rows found in the 'shops' table.");
//       return false;
//     }
//   } catch (e) {
//     print("Error retrieving product: $e");
//     return false;
//   }
// }
// // Future<bool> enterownerdata(ShopModel shopModel) async {
// //   final Database db = await initDatabase();
// //   try {
// //     await db.rawQuery("INSERT INTO  owner(owner_name,owner_contact  VALUES ('${shopModel.ownerName.toString()}','${shopModel.phoneNo.toString()}'}') ");
// //     return true;
// //   } catch (e) {
// //     print("Error inserting product: $e");
// //     return false;
// //   }
// //   }
//
// // Define a function to perform a migration if necessary.
//
// // Create a shop
// Future<int> createShop(ShopModel shop) async {
//   final dbClient = await db;
//   return dbClient!.insert('shop', shop.toMap());
// }
//
// // Read all shops
// Future<List<ShopModel>> getShop() async {
//   final dbClient = await db;
//   final List<Map<String, dynamic>> maps = await dbClient!.query('shop');
//   return List.generate(maps.length, (index) {
//     return ShopModel.fromMap(maps[index]);
//   });
// }
//
//
// // Update a shop
// Future<int> updateShop(ShopModel shop) async {
//   final dbClient = await db;
//   return dbClient!.update('shop', shop.toMap(),
//       where: 'id = ?', whereArgs: [shop.id]);
// }
//
// // Delete a shop
// Future<int> deleteShop(int id) async {
//   final dbClient = await db;
//   return dbClient!.delete('shop', where: 'id = ?', whereArgs: [id]);
// }
//
//
//
// //--------------------------------DBProductsCategory-----------------------------------
//
// Future<bool> insertProductCategory(List<dynamic> dataList) async {
//   final Database db = await initDatabase();
//   try {
//     for (var data in dataList) {
//       await db.insert('productCategory', data);
//     }
//     return true;
//   } catch (e) {
//     print("Error inserting product category data: ${e.toString()}");
//     return false;
//   }
// }
// Future<List<String>> getBrandItems() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> result = await db.query('productCategory');
//     return result.map((data) => data['product_brand'] as String).toList();
//   } catch (e) {
//     print("Error fetching brand items: $e");
//     return [];
//   }
// }
//
// Future<void> deleteAllRecords() async{
//   final db = await initDatabase();
//   await db.delete('productCategory');
// }
//
// Future<List<Map<String, dynamic>>?> getAllPCs() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> PCs = await db.query('productCategory');
//     return PCs;
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return null;
//   }
// }
//
//
// //-----------------------------------DBHelperProducts----------------------------------
//
// Future<bool> insertProductsData(List<dynamic> dataList) async {
//   final Database db = await initDatabase();
//   try {
//     for (var data in dataList) {
//       await db.insert('products', data);
//     }
//     return true;
//   } catch (e) {
//     print("Error inserting product data: ${e.toString()}");
//     return false;
//   }
// }
//
// Future<Iterable> getProductsNames() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>>? productNames= await db.query('products');
//     return productNames!.map((map) => map['product_name'].toList());
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return [];
//   }
// }
//
// Future<List<Map<String, dynamic>>?> getProductsDB() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> products = await db.query('products');
//     return products;
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return null;
//   }
// }
// Future<void> update(ProductsModel product) async {
//   // Get a reference to the database.
//   final db = await initDatabase();
//
//   // Update the given Dog.
//   await db.update(
//     'products',
//     product.toMap(),
//     // Ensure that the Dog has a matching id.
//     where: 'id = ?',
//     // Pass the Dog's id as a whereArg to prevent SQL injection.
//     whereArgs: [product.id],
//   );
// }
//
// Future<void> deleteAllRecords() async{
//   final db = await initDatabase();
//   await db.delete('products');
// }
//
// //-----------------------------------DBHelperOwner-----------------------------------
//
// Future<bool> insertOwnerData(List<dynamic> dataList) async {
//   final Database db = await initDatabase();
//   try {
//     for (var data in dataList) {
//       await db.insert('ownerData', data);
//     }
//     return true;
//   } catch (e) {
//     print("Error inserting owner  data: ${e.toString()}");
//     return false;
//   }
// }
// Future<List<String>> getShopNames() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> shopNames = await db.query('ownerData');
//     return shopNames.map((map) => map['shop_name'] as String).toList();
//   } catch (e) {
//     print("Error retrieving shop names: $e");
//     return [];
//   }
// }
//
// Future<List<Map<String, dynamic>>?> getOwnersDB() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> owner = await db.query('ownerData');
//     return owner;
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return null;
//   }
// }
//
// Future<void> deleteAllRecords() async{
//   final db = await initDatabase();
//   await db.delete('ownerData');
// }
//
//
// //-----------------------------------DBHelperOrderMaster----------------------------------
// Future<List<Map<String, dynamic>>?> getOrderMasterDB() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> products = await db.query('orderMaster');
//     return products;
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return null;
//   }
// }
//
// Future<void> postMasterTable() async {
//   final Database db = await initDatabase();
//   final ApiServices api = ApiServices();
//   try {
//     final products = await db.rawQuery('select * from orderMaster');
//     var count = 0;
//     for(var i in products){
//       print(i.toString());
//       count++;
//       var result = await api.masterPost(i, 'https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/ordermaster/post');
//       if(result == true){
//         db.rawQuery('DELETE FROM orderMaster WHERE orderId = ${i['orderId']}');
//       }
//     }
//   } catch (e) {
//     print("ErrorRRRRRRRRR: $e");
//     return null;
//   }
// }
//
// //-----------------------------------DBHelperOrderDetail----------------------------------
// Future<void> addOrderDetails(List<OrderDetailsModel> orderDetailsList) async {
//   final db = await database;
//   for (var orderDetails in orderDetailsList) {
//     await db.insert('order_details', orderDetails.toMap());
//   }
// }
//
//
// //-------------------------------------DBlogin--------------------------------------
//
// Future<bool> insertLogin(List<dynamic> dataList) async {
//   final Database db = await initDatabase();
//   try {
//     for (var data in dataList) {
//       await db.insert('login', data);
//     }
//     return true;
//   } catch (e) {
//     print("Error inserting login data: ${e.toString()}");
//     return false;
//   }
// }
// Future<bool>login(Users user) async{
//   final Database db = await initDatabase();
//   var results=await db.rawQuery("select * from login where user_id = '${user.user_id}' AND password = '${user.password}'");
//   if(results.isNotEmpty){
//     return true;
//   }
//   else{
//     return false;
//   }
// }
// Future<void> deleteAllRecords() async{
//   final db = await initDatabase();
//   await db.delete('login');
// }
//
// Future<List<Map<String, dynamic>>?> getAllLogins() async {
//   final Database db = await initDatabase();
//   try {
//     final List<Map<String, dynamic>> logins = await db.query('login');
//     return logins;
//   } catch (e) {
//     print("Error retrieving products: $e");
//     return null;
//     }
// }
//
// }