import 'package:get/get.dart';
//import 'package:order_booking_shop/Models/OrderModels/OrderMasterModel.dart';
//import '../../Models/OrderModels/OrderMasterModel.dart';
import '../../Models/ProductsModel.dart';
import '../../Repositories/OrderRepository/OrderMasterRepository.dart';
import '../../Repositories/OrderRepository/ProductsRepository.dart';

class ProductsViewModel extends GetxController {
  var allProducts = <ProductsModel>[].obs;

  UsersRepository productsRepository = UsersRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllProductsModel();
  }

  fetchAllProductsModel() async {
    var products = await productsRepository.getProductsModel();
    allProducts.value = products;

  }
  addProductAll(ProductsModel productsModel) {
    productsRepository.add(productsModel);
    fetchAllProductsModel();
  }

  updateProductAll(ProductsModel productsModel) {
    productsRepository.update(productsModel);
    fetchAllProductsModel();
  }

  deleteProductsAll(int id) {
    productsRepository.delete(id);
    fetchAllProductsModel();
  }
}
