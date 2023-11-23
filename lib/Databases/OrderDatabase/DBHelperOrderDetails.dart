import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/OrderModels/OrderDetailsModel.dart';

class OrderDetailsDatabase {
  static Database? _database;

  Future<Database> get db async{
    if(_database != null)
    {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }
  Future<Database?> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'order_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createOrderDetailsTable(db, version);
      },
    );

    return _database; // Return the initialized database
  }

  Future<void> createOrderDetailsTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE order_details(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        order_master_id INTEGER ,
        productName TEXT,
        quantity INTEGER,
        price INTEGER,
        amount INTEGER,
        FOREIGN KEY (order_master_id) REFERENCES orderMaster(orderId)
      )
    ''');
  }


  Future<List<Map<String, dynamic>>> getOrderDetails() async {
    final db = await _database;
    try {
      if (db != null) {
        final List<Map<String, dynamic>> products = await db.rawQuery('SELECT * FROM order_details');
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




  Future<void> addOrderDetails(List<OrderDetailsModel> orderDetailsList) async {
    final db = await _database;
    for (var orderDetails in orderDetailsList) {
      await db?.insert('order_details', orderDetails.toMap());
    }
  }
}


