class ShopModel{

  int? id;
  String? shop_name;
  String? city;
  String? shopAddress;
  String? ownerName;
  String? ownerCNIC;
  String? phoneNo;
  String? alternativePhoneNo;

  ShopModel({this.id,this.shop_name,this.city,this.shopAddress,this.ownerName,this.ownerCNIC,this.phoneNo,this.alternativePhoneNo});

  factory ShopModel.fromMap(Map<dynamic,dynamic> json){
    return ShopModel(
        id: json['id'],
        shop_name: json['shop_name'],
        city: json['city'],
        shopAddress: json['shopAddress'],
        ownerName:json['ownerName'],
        ownerCNIC: json['ownerCNIC'],
        phoneNo: json['phoneNo'],
        alternativePhoneNo: json['alternativePhoneNo']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'shop_name':shop_name,
      'city': city,
      'shopAddress':shopAddress,
      'ownerName':ownerName,
      'ownerCNIC':ownerCNIC,
      'phoneNo':phoneNo,
      'alternativePhoneNo': alternativePhoneNo
    };
  }
}

