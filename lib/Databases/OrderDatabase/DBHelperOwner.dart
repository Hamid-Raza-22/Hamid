
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperOwner{

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
    var documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'owner.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE ownerData(id NUMBER,shop_name TEXT, owner_name TEXT, owner_contact TEXT)");
  }

  Future<bool> insertOwnerData(List<dynamic> dataList) async {
    final Database db = await initDatabase();
    try {
      for (var data in dataList) {
        await db.insert('ownerData', data);
      }
      return true;
    } catch (e) {
      print("Error inserting owner  data: ${e.toString()}");
      return false;
    }
  }
  Future<List<String>> getShopNames() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> shopNames = await db.query('ownerData');
      return shopNames.map((map) => map['shop_name'] as String).toList();
    } catch (e) {
      print("Error retrieving shop names: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>?> getOwnersDB() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> owner = await db.query('ownerData');
      return owner;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }

  Future<void> deleteAllRecords() async{
    final db = await initDatabase();
    await db.delete('ownerData');
  }

}
