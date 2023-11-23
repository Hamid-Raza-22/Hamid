class OrderDetailsModel {
  dynamic? id;
  dynamic? orderMasterId;
  String? productName;
  dynamic? amount;
  dynamic? price;
  dynamic? quantity;

  OrderDetailsModel({
    this.id,
    this.orderMasterId,
    this.productName,
    this.amount,
    this.price,
    this.quantity,

  });

  factory OrderDetailsModel.fromMap(Map<dynamic, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      orderMasterId: json['order_master_id'],
      productName: json['productName'],
      amount: json['amount'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_master_id':orderMasterId,
      'productName': productName,
      'amount': amount,
      'price': price,
      'quantity': quantity,
    };
  }
}