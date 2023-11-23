import 'package:flutter/material.dart';

import '../Models/OrderModels/OrderDetailsModel.dart';
import '../Repositories/OrderRepository/OrderDetailsRepository.dart';

class OrderDetailsList extends StatefulWidget {
  final List<OrderDetailsModel> savedOrderDetailsData;

  const OrderDetailsList({Key? key, required this.savedOrderDetailsData})
      : super(key: key);

  @override
  _OrderDetailsListState createState() => _OrderDetailsListState();
}

class _OrderDetailsListState extends State<OrderDetailsList> {
  List<OrderDetailsModel> _orderdetailsList = [];

  @override
  void initState() {
    super.initState();
    _orderdetailsList = widget.savedOrderDetailsData;
  }

  // void _deleteOrderDetails(int index) async {
  //   final orderdetails = _orderdetailsList[index];
  //   // Delete the order details from the database.
  //   // You need to implement the delete method in OrderDetailsRepository.
  //   final deletedRows = await OrderDetailsRepository().delete(orderdetails.orderDetailsId!);
  //
  //   if (deletedRows > 0) {
  //     setState(() {
  //       _orderdetailsList.removeAt(index);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Order Details'),
      ),
      body: ListView.builder(
        itemCount: _orderdetailsList.length,
        itemBuilder: (context, index) {
          final orderdetails = _orderdetailsList[index];

          return ListTile(
            title: Text(orderdetails.productName ?? 'N/A'),
           // subtitle: Text(orderdetails. ?? 'N/A'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
              //  _deleteOrderDetails(index);
              },
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SavedOrderDetailsDetailPage(orderdetails: orderdetails),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SavedOrderDetailsDetailPage extends StatelessWidget {
  final OrderDetailsModel orderdetails;

  SavedOrderDetailsDetailPage({required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         //   Text('Order Details ID: ${orderdetails.orderDetailsId}'),
            Text('Product Name: ${orderdetails.productName ?? "N/A"}'),
          //  Text('Brand: ${orderdetails.brand ?? "N/A"}'),
            Text('Price: ${orderdetails.price ?? "N/A"}'),
            Text('Quantity: ${orderdetails.quantity ?? "N/A"}'),
            Text('Amount: ${orderdetails.amount ?? "N/A"}'),
            // Add more details as needed.
          ],
        ),
      ),
    );
  }
}
