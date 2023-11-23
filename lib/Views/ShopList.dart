import 'package:flutter/material.dart';

import '../Databases/DBHelper.dart';
import '../Models/ShopModel.dart';

class ShopList extends StatefulWidget {
  final List<ShopModel> savedShopData;

  const ShopList({super.key, required this.savedShopData});

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  List<ShopModel> _shopList = [];


  @override
  void initState() {
    super.initState();
    _shopList =  widget.savedShopData;
  }



  void _deleteShop(int index) async {
    final shop = _shopList[index];

    // Delete the shop from the database.
    final deletedRows = await DBHelper().deleteShop(shop.id!);

    if (deletedRows > 0) {
      // If the delete operation was successful in the database, update the UI.
      setState(() {
        _shopList.removeAt(index);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Shops'),
      ),
      body: ListView.builder(
        itemCount: _shopList.length,
        itemBuilder: (context, index) {
          final shop = _shopList[index];

          return ListTile(
            title: Text(shop.shop_name!),
            subtitle: Text(shop.city!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteShop(index);
              },
            ),
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShopDetailPage(shop: shop),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// The ShopDetailPage remains the same.


class ShopDetailPage extends StatelessWidget {
  final ShopModel shop;

  ShopDetailPage({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Shop Name: ${shop.shop_name ?? "N/A"}'),
            Text('Shop City: ${shop.city ?? "N/A"}'),
            Text('Shop Address: ${shop.shopAddress ?? "N/A"}'),
            Text('Owner Name: ${shop.ownerName ?? "N/A"}'),
            Text('Owner CNIC: ${shop.ownerCNIC ?? "N/A"}'),
            Text('Phone Number: ${shop.phoneNo ?? "N/A"}'),
            Text('Alternative Phone Number: ${shop.alternativePhoneNo ?? "N/A"}'),

            // Add more details as needed.
          ],
        ),
      ),
    );
  }
}
