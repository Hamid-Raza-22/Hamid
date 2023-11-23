
import '../../Databases/OrderDatabase/DBHelperProducts.dart';
import '../../Databases/UtilOrder.dart';
import '../../Models/ProductsModel.dart';

class UsersRepository{

  DBHelperProducts dbHelperProducts = DBHelperProducts();

  Future<List<ProductsModel>> getProductsModel() async{
    var dbClient = await dbHelperProducts.db;
    List<Map> maps = await dbClient.query('products',columns: ['product_code','product_name','uom','price']);
    List<ProductsModel> products = [];
    for(int i = 0; i<maps.length; i++)
    {
      products.add(ProductsModel.fromMap(maps[i]));
    }
    return products;
  }

  Future<int> add(ProductsModel productsModel) async{
    var dbClient = await dbHelperProducts.db;
    return await dbClient.insert('products', productsModel.toMap());
  }


  Future<int> update(ProductsModel productsModel) async{
    var dbClient = await dbHelperProducts.db;
    return await dbClient.update('products', productsModel.toMap());
     //   where: 'product_code = ?', whereArgs: [productsModel.product_code]);
  }

  Future<int> delete(int product_code) async{
    var dbClient = await dbHelperProducts.db;
    return await dbClient.delete('products',
        where: 'product_code = ?', whereArgs: [product_code]);
  }



}

