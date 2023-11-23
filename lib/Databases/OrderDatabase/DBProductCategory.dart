import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHelperProductCategory{

  static Database? _db;

  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database>initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'productCategory.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE productCategory(product_brand TEXT)");
  }

  Future<bool> insertProductCategory(List<dynamic> dataList) async {
    final Database db = await initDatabase();
    try {
      for (var data in dataList) {
        await db.insert('productCategory', data);
      }
      return true;
    } catch (e) {
      print("Error inserting product category data: ${e.toString()}");
      return false;
    }
  }
  Future<List<String>> getBrandItems() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> result = await db.query('productCategory');
      return result.map((data) => data['product_brand'] as String).toList();
    } catch (e) {
      print("Error fetching brand items: $e");
      return [];
    }
  }

  Future<void> deleteAllRecords() async{
    final db = await initDatabase();
    await db.delete('productCategory');
  }

  Future<List<Map<String, dynamic>>?> getAllPCs() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> PCs = await db.query('productCategory');
      return PCs;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }


}