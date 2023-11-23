import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/ShopVisitModels.dart';

class DBHelperShopVisit {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'shopvisit.db');
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE shopVisit (
        id INTEGER PRIMARY KEY NOT NULL,
        date TEXT,
        shopName TEXT,
        bookerName TEXT,
        brand TEXT,
        itemDescription TEXT,
        quantity TEXT,
        walkthrough BOOL,
        planogram BOOL,
        signage BOOL,
        productReviewed BOOL,
        imagePath TEXT
      )
    ''');
  }

  // Future<void> joinTables() async {
  //   var dbClient = await db;
  //
  //   // Ensure both tables exist before attempting to join
  //   await dbClient.execute('''
  //     CREATE TABLE shopVisit_2nd (
  //       id INTEGER PRIMARY KEY NOT NULL,
  //       walkthrough TEXT,
  //       planogram TEXT,
  //       signage TEXT,
  //       productReviewed TEXT,
  //       imagePath TEXT
  //      )
  //   ''');
  //
  //   // Perform an inner join on the 'id' column
  //   await dbClient.execute('''
  //     INSERT INTO shopVisit
  //       (id, date, shopName, bookerName, brand, itemDescription, quantity)
  //     SELECT
  //       shopVisit.id, date, shopName, bookerName, brand, itemDescription, quantity
  //     FROM
  //       shopVisit
  //     INNER JOIN
  //       shopVisit_2nd ON shopVisit.id = shopVisit_2nd.id
  //   ''');
  //
  Future<int> addShopVisit(ShopVisitModel shopvisitModel) async {
    var dbClient = await db;
    return await dbClient.insert('shopVisit', shopvisitModel.toMap());
  }

  Future<int> update(ShopVisitModel shopvisitModel) async {
    var dbClient = await db;
    return await dbClient.update('shopVisit', shopvisitModel.toMap(),
        where: 'id=?', whereArgs: [shopvisitModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete('shopVisit', where: 'id=?', whereArgs: [id]);
  }
  Future<List<Map<String, dynamic>>?> getShopVisitDB() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> shopVisit = await db.query('shopVisit');
      return shopVisit;
    } catch (e) {
      print("Error retrieving shopVisit: $e");
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getShopVisit() async {
    final db = await _db;
    try {
      if (db != null) {
        final List<Map<String, dynamic>> products = await db.rawQuery('SELECT * FROM shopVisit');
        return products;
      } else {
        // Handle the case where the database is null
        return [];
      }
    } catch (e) {
      // Let the calling code handle the error
      rethrow;
    }
  }

}
