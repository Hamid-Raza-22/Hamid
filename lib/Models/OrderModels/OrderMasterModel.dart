
import 'package:order_booking_shop/Models/ProductsModel.dart';

class OrderMasterModel {
  dynamic? orderId;
  String? date;
  String? shopName;
  String? ownerName;
  String? phoneNo;
  String? brand;
  dynamic? userId;

  OrderMasterModel({

    this.orderId,
    this.date,
    this.shopName,
    this.ownerName,
    this.phoneNo,
    this.brand,
    this.userId
  });

  factory OrderMasterModel.fromMap(Map<dynamic, dynamic> json) {
    return OrderMasterModel(
      orderId: json['orderId'],
      date: json['date'],
      shopName: json['shopName'],
      ownerName: json['ownerName'],
      phoneNo: json['phoneNo'],
      brand: json['brand'],
      userId: json['userId']
    );
  }

  Map<String, dynamic> toMap() {
    return {

      'orderId': orderId,
      'date': date,
      'shopName': shopName,
      'ownerName': ownerName,
      'phoneNo': phoneNo,
      'brand': brand,
      'userId': userId
    };
  }
}
//
//   Map<String, dynamic> toNewMap() {
//     return {
//       'shopName': shopName,
//       'ownerName': ownerName,
//       'phoneNo': phoneNo,
//       'brand': brand,
//     };
//   }
// }