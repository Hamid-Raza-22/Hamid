import 'package:get/get.dart';
import '../Models/ShopVisitModels.dart';
import '../Repositories/ShopVisitRepository.dart';

class ShopVisitViewModel extends GetxController{

  var allShopVisit = <ShopVisitModel>[].obs;
  ShopVisitRepository shopvisitRepository = ShopVisitRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllShopVisit();
  }

  fetchAllShopVisit() async{
    var shopvisit = await shopvisitRepository.getShopVisit();
    allShopVisit.value = shopvisit;
  }

  addShopVisit(ShopVisitModel shopvisitModel){
    shopvisitRepository.addShopVisit(shopvisitModel);
    fetchAllShopVisit();
  }

  updateShopVisit(ShopVisitModel shopvisitModel){
    shopvisitRepository.update(shopvisitModel);
    fetchAllShopVisit();
  }

  deleteShopVisit(int id){
    shopvisitRepository.delete(id);
    fetchAllShopVisit();
  }

}