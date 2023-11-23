

import '../Databases/DBlogin.dart';
import '../Models/loginModel.dart';

class UsersRepository{

  DBHelperLogin dbHelperUsers = DBHelperLogin();

  Future<List<Users>> getUsers() async{
    var dbClient = await dbHelperUsers.db;
    List<Map> maps = await dbClient.query('login',columns: ['user_id','password','user_name']);
    List<Users> users = [];
    for(int i = 0; i<maps.length; i++)
    {
      users.add(Users.fromMap(maps[i]));
    }
    return users;
  }

  Future<int> add(Users users) async{
    var dbClient = await dbHelperUsers.db;
    return await dbClient.insert('login', users.toMap());
  }


  Future<int> update(Users users) async{
    var dbClient = await dbHelperUsers.db;
    return await dbClient.update('login', users.toMap());
    //   where: 'product_code = ?', whereArgs: [productsModel.product_code]);
  }

  Future<int> delete(int user_id) async{
    var dbClient = await dbHelperUsers.db;
    return await dbClient.delete('login',
        where: 'user_id = ?', whereArgs: [user_id]);
  }
}

