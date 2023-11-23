import 'package:flutter/material.dart';
import 'package:order_booking_shop/Views/OrderBookingStatus.dart';
import 'package:order_booking_shop/Views/RecoveryFormPage.dart';
import 'package:order_booking_shop/Views/ReturnFormPage.dart';
import 'package:order_booking_shop/Views/ShopPage.dart';
import 'package:order_booking_shop/Views/ShopVisit.dart';
import 'package:order_booking_shop/Views/ShopVisit_2ndPage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {



  //final String selectedItem;
  //HomePage({required this.selectedItem});



  void navigateToShopPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
  }

  @override
  Widget build(BuildContext context) {


    // final Map<String, String>? shopData =
    // ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    //
    // String selectedShopName = shopData?['shopName'] ?? ''; // Access the shop name
    // String selectedShopOwner = shopData?['ownerName'] ?? ''; // Access the owner name

    final shopData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final selectedShopName = shopData['shopName'];
    final selectedShopOwner = shopData['ownerName'];
    final userName = shopData['user_name'];

    print('Selected Shop Name: $selectedShopName');
    print('Selected Shop Owner: $selectedShopOwner');
    print(userName);

    //final selectedItem = ModalRoute.of(context as BuildContext)?.settings.arguments as String; //AS
    //String selectedShopName = selectedItem; //AS
    //print(selectedShopName);  //AS

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        toolbarHeight: 120.0,
        title: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end, // Align everything to the right
              children: [
                Text(
                  'Switch Shop',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cached),
                  color: Colors.black,
                  onPressed: () {
                    // Handle the action for reloading or switching shops
                  },
                ),
              ],
            )

          ],
        ),
      ),
      body: SingleChildScrollView( // Wrap your content with SingleChildScrollView
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(0xf52a, fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Add Shop'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopVisit(onBrandItemsSelected: (String ) {  },),
                              settings: RouteSettings(arguments: shopData)),);},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Shop Visit'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnFormPage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(0xee93, fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Return Form'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RecoveryFromPage()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Recovery'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderBookingStatus(),
                            ),
                          );;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(0xf52a, fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Order Booking Status'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[200],
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      ));
}