import 'package:get/get.dart';
//import 'package:order_booking_shop/Models/OrderModels/OrderMasterModel.dart';
//import '../../Models/OrderModels/OrderDetailsModel.dart';
import '../../Models/OrderModels/OrderDetailsModel.dart';
import '../../Repositories/OrderRepository/OrderDetailsRepository.dart';
//import '../../Repositories/OrderRepository/OrderMasterRepository.dart';

class OrderDetailsViewModel extends GetxController{

  var allOrderDetails = <OrderDetailsModel>[].obs;
  OrderDetailsRepository orderdetailsRepository = OrderDetailsRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllOrderDetails();
  }




  fetchAllOrderDetails() async{
    var orderdetails = await orderdetailsRepository.getOrderDetails();
    allOrderDetails.value = orderdetails;
  }


  addOrderDetail(OrderDetailsModel orderdetailsModel){
    orderdetailsRepository.add(orderdetailsModel);
    fetchAllOrderDetails();
  }

  updateOrderDetails(OrderDetailsModel orderdetailsModel){
    orderdetailsRepository.update(orderdetailsModel);
    fetchAllOrderDetails();
  }

  deleteOrderDetails(int id){
    orderdetailsRepository.delete(id);
    fetchAllOrderDetails();
  }

}