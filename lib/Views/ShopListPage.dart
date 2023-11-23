import 'package:flutter/material.dart';
import 'package:order_booking_shop/Views/HomePage.dart';
import '../Databases/OrderDatabase/DBHelperOwner.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ShopListPage(
      onShopItemSelected: (selectedShopName) {
        runApp(MaterialApp(
          // home: NewOrderBookingPage(selectedShopName: selectedShopName),
        ));
      },
    ),
    // debugShowCheckedModeBanner: false,
  ));
}

class ShopListPage extends StatefulWidget {
  @override
  _ShopListPageState createState() => _ShopListPageState();

  // Define a callback function that takes a String as a parameter
  //void Function(String) onShopItemSelected;
  void Function(Map<String, String>) onShopItemSelected;

  ShopListPage({Key? key, required this.onShopItemSelected, this.user_name}) : super(key: key);
  final String? user_name;


}

class _ShopListPageState extends State<ShopListPage> {
  List<String> dropdownItems = [];
  String selectedItem = '';
  String feedbackText = '';
  String selectedShopOwner = '';
  List<Map<String, dynamic>> shopOwners = [];



  DBHelperOwner dbHelper = DBHelperOwner();

  void navigateToNewOrderBookingPage(String selectedShopName) async {
    // Set the selected shop name without navigation
    setState(() {
      selectedItem = selectedShopName;
    });
  }

  @override
  void initState() {
    super.initState();
    print('User Name in ShopListPage: ${widget.user_name}');
    fetchShopData();
  }

  void fetchShopData() async {
    List<String> shopNames = await dbHelper.getShopNames();
    shopOwners = (await dbHelper.getOwnersDB())!;
    //final shopOwners = await dbHelper.getOwnersDB();
    print(shopOwners);

    setState(() {
      dropdownItems = shopNames.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          toolbarHeight: 56.0,
          backgroundColor: Colors.grey,
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Settings'),
                    value: 'Option 1',
                  ),
                  PopupMenuItem(
                    child: Text('Log out'),
                    value: 'Option 2',
                  ),
                ];
              },
              onSelected: (value) {
                print('Selected: $value');
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Shop List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton<String>(
                    value: selectedItem.isEmpty ? null : selectedItem,
                    hint: Text('---Select Shop---'),
                    onChanged: (newValue) {
                      setState(() {
                        selectedItem = newValue!;
                      });
                      for (var owner in shopOwners) {
                        if (owner['shop_name'] == selectedItem) {
                          setState(() {
                            selectedShopOwner = owner['owner_name'];
                          });
                        }
                      }
                    },
                    items: dropdownItems.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(),
                    style: TextStyle(color: Colors.black),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text('Selected Item: ${selectedItem.isEmpty ? 'None' : selectedItem}'),
                Text('Selected Shop Owner: $selectedShopOwner'),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Feedback or Note',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onChanged: (text) {
                      setState(() {
                        feedbackText = text;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add your "Attachment" button click action here
                      },
                      icon: Icon(Icons.add),
                      label: Text('Image'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                        onPrimary: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {

                    final shopData = {
                      'shopName': selectedItem,
                      'ownerName': selectedShopOwner,
                      'user_name': widget.user_name,
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                        settings: RouteSettings(arguments: shopData),
                        //settings: RouteSettings(arguments: selectedShopOwner),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    onPrimary: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Clock In',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        );
    }
}