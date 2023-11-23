
import 'package:order_booking_shop/Databases/OrderDatabase/DBHelperOrderMaster.dart';
import 'package:order_booking_shop/Models/OrderModels/OrderMasterModel.dart';

import '../../Databases/OrderDatabase/DBHelperOrderDetails.dart';
import '../../Databases/UtilOrder.dart';
import '../../Models/OrderModels/OrderDetailsModel.dart';

class OrderDetailsRepository {

  OrderDetailsDatabase dbHelperOrderDetails = OrderDetailsDatabase();

  Future<List<OrderDetailsModel>> getOrderDetails() async {
    var dbClient = await dbHelperOrderDetails.db;
    List<Map> maps = await dbClient.query('order_details', columns: ['id','order_master_id', 'productName', 'quantity', 'price', 'amount' ]);
    List<OrderDetailsModel> orderdetails = [];
    for (int i = 0; i < maps.length; i++) {

      orderdetails.add(OrderDetailsModel.fromMap(maps[i]));
    }
    return orderdetails;
  }


  Future<int> add(OrderDetailsModel orderdetailsModel) async {
    var dbClient = await dbHelperOrderDetails.db;
    return await dbClient.insert('orderDetails', orderdetailsModel.toMap());
  }

  Future<int> update(OrderDetailsModel orderdetailsModel) async {
    var dbClient = await dbHelperOrderDetails.db;
    return await dbClient.update('orderDetails', orderdetailsModel.toMap(),
        where: 'id = ?', whereArgs: [orderdetailsModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await dbHelperOrderDetails.db;
    return await dbClient.delete('orderDetails',
        where: 'id = ?', whereArgs: [id]);
  }

}