import 'package:get/get.dart';
import 'package:order_booking_shop/Models/OrderModels/OrderMasterModel.dart';
import '../../Repositories/OrderRepository/OrderMasterRepository.dart';

class OrderMasterViewModel extends GetxController{

  var allOrderMaster = <OrderMasterModel>[].obs;
  ShopVisitRepository ordermasterRepository = ShopVisitRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllOrderMaster();
  }

  fetchAllOrderMaster() async{
    var ordermaster = await ordermasterRepository.getShopVisit();
    allOrderMaster.value = ordermaster;
  }

  Future<String> fetchLastOrderMasterId() async{
    String ordermaster = await ordermasterRepository.getLastOrderId();
    return ordermaster;
  }

  addOrderMaster(OrderMasterModel ordermasterModel){
    ordermasterRepository.add(ordermasterModel);
    fetchAllOrderMaster();
  }

  updateOrderMaster(OrderMasterModel ordermasterModel){
    ordermasterRepository.update(ordermasterModel);
    fetchAllOrderMaster();
  }

  deleteOrderMaster(int id){
    ordermasterRepository.delete(id);
    fetchAllOrderMaster();
  }

}