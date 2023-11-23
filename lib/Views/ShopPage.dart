import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:order_booking_shop/View_Models/ShopViewModel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ShopModel.dart';
import 'package:get/get.dart';
import 'ShopList.dart';
import 'ShopPage.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {


  final shopViewModel = Get.put(ShopViewModel());

  final shopNameController = TextEditingController();
  final cityController = TextEditingController();
  final shopAddressController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerCNICController = TextEditingController();
  final phoneNoController = TextEditingController();
  final alternativePhoneNoController = TextEditingController();

  int? shopId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text Field 1 - Shop Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Shop Name',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: shopNameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Shop Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'City',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: cityController,
                            decoration: InputDecoration(
                              labelText: 'Enter City',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Text Field 2 - Shop Address
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Shop Address',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: shopAddressController,
                            decoration: InputDecoration(
                              labelText: 'Enter Shop Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Text Field 3 - Owner Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Owner Name',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: ownerNameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Owner Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Text Field 4 - Owner CNIC
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Owner CNIC',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: ownerCNICController,
                            decoration: InputDecoration(
                              labelText: 'Enter Owner CNIC',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Text Field 5 - Phone Number
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: phoneNoController,
                            decoration: InputDecoration(
                              labelText: 'Enter Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Text Field 5 - Phone Number
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ' ALternative Phone Number',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          TextFormField(
                            controller: alternativePhoneNoController,
                            decoration: InputDecoration(
                              labelText: 'Alternative Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),


                      const SizedBox(height: 20),

                      // ElevatedButton for adding location
                      // "Save" button with width and height
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add Location',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Align the "save" button to the bottom right
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (shopNameController.text != "") {
                                shopViewModel.addShop(ShopModel(
                                  id: shopId,
                                  shop_name: shopNameController.text,
                                  city: cityController.text,
                                  shopAddress: shopAddressController.text,
                                  ownerName: ownerNameController.text,
                                  ownerCNIC: ownerCNICController.text,
                                  phoneNo: phoneNoController.text,
                                  alternativePhoneNo: alternativePhoneNoController.text,
                                ));

                                shopNameController.text = "";
                                cityController.text="";
                                shopAddressController.text = "";
                                ownerNameController.text = "";
                                ownerCNICController.text = "";
                                phoneNoController.text = "";
                                alternativePhoneNoController.text="";

                                 Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ShopList(savedShopData: shopViewModel.allShop),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(200, 50),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

