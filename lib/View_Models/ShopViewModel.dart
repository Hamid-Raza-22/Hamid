import 'package:get/get.dart';
import 'package:order_booking_shop/Models/ShopModel.dart';
import 'package:order_booking_shop/Repositories/ShopRepository.dart';

import '../Repositories/OrderRepository.dart';

class ShopViewModel extends GetxController{

  var allShop = <ShopModel>[].obs;
  ShopRepository shopRepository = ShopRepository();



  @override
  void onInit() {
    super.onInit();
    fetchAllShop();
  }

  fetchAllShop() async {
    var shop = await shopRepository.getShop();
    allShop.value= shop;

  }

  addShop(ShopModel shopModel){
    shopRepository.add(shopModel);
    fetchAllShop();
    //var dummy=fetchAllShop();
   // print (dummy);

  }

  updateShop(ShopModel shopModel){
    shopRepository.update(shopModel);
    // fetchAllShop();

  }

  deleteShop(int id){
    shopRepository.delete(id);
    fetchAllShop();

  }
}






