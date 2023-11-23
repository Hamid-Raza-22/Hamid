
import 'package:order_booking_shop/Databases/OrderDatabase/DBHelperOrderMaster.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Databases/DBHelperShopVisit.dart';
import '../Databases/DBlogin.dart';
import '../Databases/OrderDatabase/DBHelperOwner.dart';
import '../Databases/OrderDatabase/DBHelperProducts.dart';
import '../Databases/OrderDatabase/DBProductCategory.dart';
import 'ApiServices.dart';

class DatabaseOutputs{
  Future<void> checkFirstRun() async {
    SharedPreferences SP = await SharedPreferences.getInstance();
    bool firstrun = await SP.getBool('firstrun') ?? true;
    if(firstrun == true){
      initializeData();
      await SP.setBool('firstrun', false);
    }else{
      print("UPDATING.......................................");
      await update();
      initializeData();
    }
  }

  void initializeData() async{
    final api = ApiServices();
    final db = DBHelperProducts();
    final dbowner = DBHelperOwner();
    final dblogin=DBHelperLogin();
    final dbProductCategory=DBHelperProductCategory();
    var response = await api.getApi("https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/product/record");
    var results= await db.insertProductsData(response);  //return True or False
    //print(results.toString());
    var response2 = await api.getApi("https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/AddAhop/record/");
    var results2 = await dbowner.insertOwnerData(response2);   //return True or False
    //print(results2.toString());
    var response4 = await api.getApi("https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/login/get/");
    var results4= await dblogin.insertLogin(response4);//return True or False
    //print(results4.toString());
    var response5 = await api.getApi("https://g04d40198f41624-i0czh1rzrnvg0r4l.adb.me-dubai-1.oraclecloudapps.com/ords/courage/product_brand/get/");
    var results5= await dbProductCategory.insertProductCategory(response5);//return True or False
    print(results5.toString());
    // final pdb=DBHelperProducts();
    // pdb.displayDatabaseContent();
    showAllTables();
  }
  Future<void> update() async {
    final db = DBHelperProducts();
    final dbowner = DBHelperOwner();
    final dblogin=DBHelperLogin();
    final dbProductCategory=DBHelperProductCategory();
    print("DELETING.......................................");
    await db.deleteAllRecords();
    await dbowner.deleteAllRecords();
    await dblogin.deleteAllRecords();
    await dbProductCategory.deleteAllRecords();
  }

  Future<void> showOrderMaster() async {
    print("**************Tables SHOWING****************");
    print("**************Order Master****************");
    final db = DBHelperOrderMaster();

    var data = await db.getOrderMasterDB();
    int co = 0;
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Order Master is $co");

  }
  Future<void> showShopVisit() async {
    print("**************Tables SHOWING****************");
    print("**************SHOP VISIT****************");
    final db = DBHelperShopVisit();

    var data = await db.getShopVisit();
    int co = 0;
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of SHOP VISIT is $co");

  }


  Future<void> showOrderDetails() async {
    print("**************Tables SHOWING****************");
    print("**************Order Details****************");
    final db = DBHelperOrderMaster();

    var data = await db.getOrderDetails();
    int co = 0;
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Order Details is $co");

  }

  Future<void> showAllTables() async {
    print("**************Tables SHOWING****************");
    print("**************Tables Products****************");
    final db = DBHelperProducts();
    final dbowner = DBHelperOwner();
    final dblogin = DBHelperLogin();
    final dbPC = DBHelperProductCategory();

    var data = await db.getProductsDB();
    int co = 0;
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Products is $co");

    print("**************Tables Owners****************");
    co=0;
    data = await dbowner.getOwnersDB();
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Owners is $co");

    print("**************Logins Owners****************");
    co=0;
    data = await dblogin.getAllLogins();
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Logins is $co");

    print("**************ProductsCategories Owners****************");
    co=0;
    data = await dbPC.getAllPCs();
    for(var i in data!){
      co++;
      print("$co | ${i.toString()} \n");
    }
    print("TOTAL of Products Categories is $co");

  }
}