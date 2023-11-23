
import '../Databases/DBHelperShopVisit.dart';
import '../Models/ShopVisitModels.dart';

class ShopVisitRepository {

  DBHelperShopVisit dbHelpershopvisit = DBHelperShopVisit();

  Future<List<ShopVisitModel>> getShopVisit() async {
    var dbClient = await dbHelpershopvisit.db;
    List<Map> maps = await dbClient.query('shopVisit', columns: ['id','date', 'shopName' , 'bookerName' , 'brand' , 'itemDescription' , 'quantity','walkthrough', 'planogram' , 'signage' , 'productReviewed', 'imagePath']);
    List<ShopVisitModel> shopvisit = [];

    for (int i = 0; i < maps.length; i++) {
      shopvisit.add(ShopVisitModel.fromMap(maps[i]));
    }
    return shopvisit;
  }

  Future<int> addShopVisit(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelpershopvisit.db;
    return await dbClient.insert('shopVisit' , shopvisitModel.toMap());
  }

  Future<int> update(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelpershopvisit.db;
    return await dbClient.update('shopVisit', shopvisitModel.toMap(),
        where: 'id=?', whereArgs: [shopvisitModel.id] );
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelpershopvisit.db;
    return await dbClient.delete('shopVisit',
        where: 'id=?', whereArgs: [id] );
  }
}



