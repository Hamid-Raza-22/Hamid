import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../Models/loginModel.dart';

class DBHelperLogin{

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
    String path = join(documentDirectory.path,'login.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE login(user_id TEXT , password TEXT ,user_name TEXT)");
  }

  Future<bool> insertLogin(List<dynamic> dataList) async {
    final Database db = await initDatabase();
    try {
      for (var data in dataList) {
        await db.insert('login', data);
      }
      return true;
    } catch (e) {
      print("Error inserting login data: ${e.toString()}");
      return false;
    }
  }
  Future<bool>login(Users user) async{
    final Database db = await initDatabase();
    var results=await db.rawQuery("select * from login where user_id = '${user.user_id}' AND password = '${user.password}'");
    if(results.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  Future<void> deleteAllRecords() async{
    final db = await initDatabase();
    await db.delete('login');
  }

  Future<List<Map<String, dynamic>>?> getAllLogins() async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> logins = await db.query('login');
      return logins;
    } catch (e) {
      print("Error retrieving products: $e");
      return null;
    }
  }
  Future<String?> getUserName(String userId) async {
    final Database db = await initDatabase();
    try {
      var results = await db.rawQuery("select user_name from login where user_id = '$userId'");
      if (results.isNotEmpty) {
        // Explicitly cast to String
        return results.first['user_name'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return null;
    }
    }
}

