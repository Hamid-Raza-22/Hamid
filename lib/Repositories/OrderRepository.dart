//
// import 'package:order_booking_shop/Models/OrderModel.dart';
//
// import '../Databases/OrderDatabase.dart';
// import '../Databases/UtilOrder.dart';
//
// class OrderRepository {
//
//   OrderDatabase orderDatabase = OrderDatabase();
//
//
//
//   Future<List<OrderModel>> getOrder() async {
//     var dbClient = await orderDatabase.db;
//   List<Map> maps = await dbClient!.query(tableName2, columns: ['id', 'Shop Name','Owner Name','Phone No','Brand','Item1', 'Item2', 'Item3','Item4']);
//     List<OrderModel> order = [];
//
//     for (int i = 0; i < maps.length; i++) {
//       order.add((OrderModel.fromMap(maps[i])));
//     }
//     return order;
//
//
//   }
//   Future<int> add(OrderModel orderModel) async{
//     var dbClient = await orderDatabase.db;
//     return await dbClient!.insert(tableName2 , orderModel.toMap());
//   }
//
//   Future<int> update(OrderModel orderModel) async{
//     var dbClient = await orderDatabase.db;
//     return await dbClient!.update(tableName2 , orderModel.toMap(),
//         where: 'id=?', whereArgs: [orderModel.id] );
//   }
//
//   Future<int> delete(int id) async{
//     var dbClient = await orderDatabase.db;
//     return await dbClient!.delete(tableName2 ,
//         where: 'id=?', whereArgs: [id] );
//   }
// }
//
//
//
