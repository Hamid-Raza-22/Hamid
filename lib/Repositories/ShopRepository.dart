import 'package:order_booking_shop/Databases/DBHelper.dart';

import 'package:order_booking_shop/Models/ShopModel.dart';

import '../Databases/Util.dart';

class ShopRepository {

  DBHelper dbHelper = DBHelper();

  Future<List<ShopModel>> getShop() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient!.query(shopVisit, columns: ['id', 'shop_name' , 'city' , 'shopAddress' , 'ownerName' , 'ownerCNIC' , 'phoneNo' , 'alternativePhoneNo']);
    List<ShopModel> shop = [];

    for (int i = 0; i < maps.length; i++) {
      shop.add(ShopModel.fromMap(maps[i]));
    }
    return shop;
  }

  Future<List<ShopModel>> getShopName() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient!.query(shopVisit, columns: ['id', 'shop_name']);
    List<ShopModel> shop = [];

    for (int i = 0; i < maps.length; i++) {
      shop.add(ShopModel.fromMap(maps[i]));
    }
    return shop;
  }

  Future<int> add(ShopModel shopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.insert(shopVisit , shopModel.toMap());
  }

  Future<int> update(ShopModel shopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.update(shopVisit, shopModel.toMap(),
        where: 'id=?', whereArgs: [shopModel.id] );
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.delete(shopVisit,
        where: 'id=?', whereArgs: [id] );
  }
}



