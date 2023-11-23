import 'package:flutter/material.dart';
import 'package:order_booking_shop/Repositories/OrderRepository/OrderMasterRepository.dart';
import '../Models/OrderModels/OrderMasterModel.dart';



class OrderMasterList extends StatefulWidget {
  final List<OrderMasterModel> savedOrderMasterData;

  const OrderMasterList({super.key, required this.savedOrderMasterData});

  @override
  _OrderMasterListState createState() => _OrderMasterListState();
}

class _OrderMasterListState extends State<OrderMasterList> {
  List<OrderMasterModel> _ordermasterList = [];


  @override
  void initState() {
    super.initState();
    _ordermasterList =  widget.savedOrderMasterData;
  }



  void _deleteOrderMaster(int index) async {
    final ordermaster = _ordermasterList[index];

    // Delete the shop from the database.
    final deletedRows = await ShopVisitRepository().delete(ordermaster.orderId!);

    if (deletedRows > 0) {
      // If the delete operation was successful in the database, update the UI.
      setState(() {
        _ordermasterList.removeAt(index);
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
        itemCount: _ordermasterList.length,
        itemBuilder: (context, index) {
          final ordermaster = _ordermasterList[index];

          return ListTile(
            title: Text(ordermaster.shopName!),
            subtitle: Text(ordermaster.brand!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteOrderMaster(index);
              },
            ),
            onTap: () {

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SavedOrderMasterDetailPage(ordermaster: ordermaster),
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


class SavedOrderMasterDetailPage extends StatelessWidget {
  final OrderMasterModel ordermaster;

  SavedOrderMasterDetailPage ({required this.ordermaster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Master Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Order ID: ${ordermaster.orderId}'),
            Text('Shop Name: ${ordermaster.shopName ?? "N/A"}'),
            //Text('Shop Address: ${shop.shopAddress ?? "N/A"}'),
            Text('Owner Name: ${ordermaster.ownerName ?? "N/A"}'),
            Text('Date: ${ordermaster.date ?? "N/A"}'),


            Text('Phone Number: ${ordermaster.phoneNo ?? "N/A"}'),
            Text('Brand ${ordermaster.brand ?? "N/A"}'),
            //details as needed.
          ],
        ),
      ),
    );

  }
}
