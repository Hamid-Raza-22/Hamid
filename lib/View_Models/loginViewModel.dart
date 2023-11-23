import 'package:get/get.dart';
import '../Models/loginModel.dart';
import '../Repositories/loginRepository.dart';

class UsersViewModel extends GetxController {
  var allUsers = <Users>[].obs;

  UsersRepository usersRepository = UsersRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllUsersModel();
  }

  fetchAllUsersModel() async {
    var users = await usersRepository.getUsers();
    allUsers.value = users;

  }
  addUserAll(Users users) {
    usersRepository.add(users);
    fetchAllUsersModel();
  }

  updateUserAll(Users users) {
    usersRepository.update(users);
    fetchAllUsersModel();
  }

  deleteProductsAll(int user_id) {
    usersRepository.delete(user_id);
    fetchAllUsersModel();
  }
}
