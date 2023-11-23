// import 'package:get/get.dart';
// import 'package:order_booking_shop/Models/OrderModel.dart';
// import 'package:order_booking_shop/Repositories/OrderRepository.dart';
//
// class OrderViewModel extends GetxController{
//
//   var allOrder = <OrderModel>[].obs;
//   OrderRepository orderRepository = OrderRepository();
//
//   @override
//   void oninit() {
//     super.onInit();
//     fetchAllOrder();
//   }
//
//   fetchAllOrder() async {
//     var order = await orderRepository.getOrder();
//     allOrder.value= order;
//     fetchAllOrder();
//
//   }
//
//   addOrder(OrderModel orderModel){
//     orderRepository.add(orderModel);
//     fetchAllOrder();
//
//   }
//
//   updateOrder(OrderModel orderModel){
//     orderRepository.update(orderModel);
//     fetchAllOrder();
//
//   }
//
//   deleteOrder(int id){
//     orderRepository.delete(id);
//     fetchAllOrder();
//
//   }
// }
//
//
//
