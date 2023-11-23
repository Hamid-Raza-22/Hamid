import 'dart:io' as io;
import 'package:order_booking_shop/Models/ProductsModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '';
class DBHelperProducts{

  static Database? _db;

  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }
  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'products.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE products(id NUMBER, product_code TEXT, product_name TEXT, uom TEXT ,price TEXT)"
    );
  }

  Future<bool> insertProductsData(List<dynamic> dataList) async {
    final Database db = await initDatabase();
    try {
      for (var data in dataList) {
        await db.insert('products', data);
      }
      return true;
    } catch (e) {
      print("Error inserting product data: ${e.toString()}");
      return false;
    }
  }

  Future<Iterable> getProductsNames() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>>? productNames= await db.query('products');
      return productNames!.map((map) => map['product_name'].toList());
    } catch (e) {
      print("Error retrieving products: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>?> getProductsDB() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> products = await db.query('products');
      return products;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }
  Future<void> update(ProductsModel product) async {
    // Get a reference to the database.
    final db = await initDatabase();

    // Update the given Dog.
    await db.update(
      'products',
      product.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [product.id],
    );
  }

  Future<void> deleteAllRecords() async{
    final db = await initDatabase();
    await db.delete('products');
  }
// Future<void> displayDatabaseContent() async {
//   final Database db = await openDatabase(
//     join(await getDatabasesPath(), 'products.db'),
//   );
//
//   final List<Map<String, dynamic>> data = await db.query('products');
//
//   for (final row in data) {
//     print('CODE: ${row['product_code']}, Name: ${row['product_name']}, UOM: ${row['uom'] }, PRICE: ${row['price']}');
//   }
// }
}

