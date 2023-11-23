
class ShopVisitModel {
  int? id;
  String? date;
  String? shopName;
  String? bookerName;
  String? brand;
  String? itemDescription;
  String? quantity;
  bool? walkthrough;
  bool? planogram;
  bool? signage;
  bool? productReviewed;
  String? imagePath;

  ShopVisitModel({

    this.id,
    this.date,
    this.shopName,
    this.bookerName,
    this.itemDescription,
    this.brand,
    this.quantity,
    this.walkthrough,
    this.planogram,
    this.signage,
    this.productReviewed,
    this.imagePath,
  });

  factory ShopVisitModel.fromMap(Map<dynamic, dynamic> json) {
    return ShopVisitModel(
      id: json['id'],
      date: json['date'],
      shopName: json['shopName'],
      bookerName: json['bookerName'],
      itemDescription: json['itemDescription'],
      brand: json['brand'],
      quantity: json['quantity'],
      walkthrough: json['walkthrough'] == 1 || json['walkthrough'] == 'true' || json['walkthrough'] == true,
      planogram: json['planogram'] == 1 || json['planogram'] == 'true' || json['planogram'] == true,
      signage: json['signage'] == 1 || json['signage'] == 'true' || json['signage'] == true,
      productReviewed: json['productReviewed'] == 1 || json['productReviewed'] == 'true' || json['productReviewed'] == true,
      imagePath: json['imagePath'], // Add this line to get the imagePath from the database
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'shopName': shopName,
      'bookerName': bookerName,
      'itemDescription': itemDescription,
      'brand': brand,
      'quantity': quantity,
      'walkthrough': walkthrough == true ? 1 : 0,
      'planogram': planogram == true ? 1 : 0,
      'signage': signage == true ? 1 : 0,
      'productReviewed': productReviewed == true ? 1 : 0,
      'imagePath': imagePath, // Add this line to store the imagePath in the database
    };
  }
}
