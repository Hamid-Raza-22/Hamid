import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/async.dart';
import 'package:order_booking_shop/API/DatabaseOutputs.dart';
import 'package:order_booking_shop/API/Globals.dart';
import 'package:order_booking_shop/Databases/OrderDatabase/DBHelperOrderMaster.dart';
import '../Databases/OrderDatabase/DBHelperOrderDetails.dart';
import '../Models/OrderModels/OrderDetailsModel.dart';
import '../Models/OrderModels/OrderMasterModel.dart';
import '../Models/ProductsModel.dart';
import '../View_Models/OrderViewModels/OrderDetailsViewModel.dart';
import '../View_Models/OrderViewModels/OrderMasterViewModel.dart';
import '../View_Models/OrderViewModels/ProductsViewModel.dart';
import 'OrderBooking_2ndPage.dart';
import 'package:get/get.dart';
import 'OrderMasterList.dart';

void main() => runApp(MaterialApp(
  home: FinalOrderBookingPage(),
));

class FinalOrderBookingPage extends StatefulWidget {
  // final String selectedBrand; // Define a parameter to receive the selected brand
  // FinalOrderBookingPage({ required this.selectedBrand}); // Constructor to receive the selected brand
  @override
  _FinalOrderBookingPageState createState() => _FinalOrderBookingPageState();
}

class _FinalOrderBookingPageState extends State<FinalOrderBookingPage> {
  final ordermasterViewModel = Get.put(OrderMasterViewModel());
  final orderdetailsViewModel = Get.put(OrderDetailsViewModel());
  int? ordermasterId;
  int? orderdetailsId;
  TextEditingController _ShopNameController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _brandNameController = TextEditingController();
  // TextEditingController _dateController = TextEditingController();
  //final ProductsViewModel productsViewModel = Get.put(ProductsViewModel());
  final productsViewModel = Get.put(ProductsViewModel());
  String selectedBrand = '';
  List<RowData> rowDataList = [];
  List<String> selectedProductNames = [];
  int serialNumber = 1;

  @override
  void initState() {
    // Initially add two rows
    addNewRow();
    addNewRow();
    DatabaseOutputs db = DatabaseOutputs();
    db.showOrderMaster();
    DBHelperOrderMaster dbmaster = DBHelperOrderMaster();
    dbmaster.postMasterTable();
    db.showOrderDetails();
    dbmaster.postOrderDetails();
    db.showShopVisit();
   // db.showShopVisit_2nd();
  }

  @override
  Widget build(BuildContext context) {

    // final String selectedBrand; // Define a parameter to receive the selected brand
    // FinalOrderBookingPage({required this.selectedBrand}); // Constructor to receive the selected brand

    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final shopName = data['shopName'];
    final ownerName = data['ownerName'];
    final selectedBrandName = data['selectedBrandName'];
    String bookerName = data['bookerName'];

    print(bookerName);

    _ShopNameController.text = shopName!;
    _ownerNameController.text = ownerName!;
    _brandNameController.text = selectedBrandName as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTextFormField('Shop Name', _ShopNameController),
                SizedBox(height: 10),
                buildTextFormField('Owner Name', _ownerNameController),
                SizedBox(height: 10),
                buildTextFormField('Phone#', _phoneNoController),
                SizedBox(height: 10),
                buildTextFormField('Brand', _brandNameController),
                SizedBox(height: 10),
                for (var i = 0; i < rowDataList.length; i++)
                  buildRow(rowDataList[i], i + 1),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      addNewRow();
                    },
                    child: Text('Add Products'),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: ()  async {
                      if (_ShopNameController.text.isNotEmpty)  {
                        var id = await customAlphabet('1234567890', 12);
                        ordermasterViewModel.addOrderMaster(OrderMasterModel(
                          orderId: int.parse(id),
                          shopName: _ShopNameController.text,
                          ownerName: _ownerNameController.text,
                          phoneNo: _phoneNoController.text,
                          brand: _brandNameController.text,
                          date:  _getCurrentDate(),
                          userId: userNames.toString()
                        ));

                        // OrderMasterModel recentOrderMaster = ordermasterViewModel.allOrderMaster.last;
                        // print("LAST ${recentOrderMaster}");
                        // ordermasterId = recentOrderMaster.orderId;
                        String masterid = await ordermasterViewModel.fetchLastOrderMasterId();
                        ordermasterId = int.parse(masterid);

                        List<Map<String, dynamic>> rowDataDetails = [];
                        for (var rowData in rowDataList) {
                          String selectedItem = rowData.itemsDropdownValue;
                          int quantity = int.tryParse(rowData.qtyController.text) ?? 0;
                          int totalAmount = int.tryParse(rowData.amountController.text) ?? 0;

                          rowDataDetails.add({
                            'selectedItem': selectedItem,
                            'quantity': quantity,
                            'totalAmount': totalAmount,
                          });
                        }

                        // Save order details associated with the order master
                        saveOrderDetails();

                        // Define the data to pass to the next page
                        Map<String, dynamic> dataToPass = {
                          'orderId': ordermasterId,
                          'orderDate': _getCurrentDate(),
                          'bookerName': bookerName,
                          //  'visitConductedBy': visitConductedBy,
                          'rowDataDetails': rowDataDetails,
                        };
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            //builder: (context) => OrderMasterList(savedOrderMasterData: ordermasterViewModel.allOrderMaster),
                            builder: (context) => OrderBooking_2ndPage(), // Replace 'NextPage' with the actual page you're navigating to
                            settings: RouteSettings(arguments: dataToPass),
                          ),
                        );
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _getCurrentDate(),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void saveOrderDetails() async {
    List<OrderDetailsModel> orderDetailsList = [];

    for (var rowData in rowDataList) {
      final orderDetails = OrderDetailsModel(
        orderMasterId: ordermasterId ?? 0, // Assuming ordermasterId is set
        productName: rowData.itemsDropdownValue,
        quantity: int.tryParse(rowData.qtyController.text) ?? 0,
        price: int.tryParse(rowData.rateController.text) ?? 0,
        amount: int.tryParse(rowData.amountController.text) ?? 0,
      );
      orderDetailsList.add(orderDetails);
    }

    // Save order details
    await DBHelperOrderMaster().addOrderDetails(orderDetailsList);
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        SizedBox(height: 5),
        Container(
          height: 30,

          child: TextFormField(
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget buildRow(RowData rowData, int rowNumber) {
    rowData.qtyController.addListener(() {
      calculateAmount(rowData.qtyController, rowData.rateController,
          rowData.amountController, rowData);
    });

    rowData.rateController.addListener(() {
      calculateAmount(rowData.qtyController, rowData.rateController,
          rowData.amountController, rowData);
    });

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [ SizedBox(height: 15,),
          Text(
            '$rowNumber.',
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
          SizedBox(height: 5,),
          Container(
            width: 150,
            child: buildItemsDropdown(rowData),
          ),
          SizedBox(height: 5),
          Container(
            width: 55,
            child: buildTextFormField('Qty', rowData.qtyController),
          ),
          SizedBox(height: 5),
          Container(
            width:60 ,
            child: buildNonEditableText('Rate', rowData.rateController),
          ),
          Container(
            width: 80,
            child: buildNonEditableText('Amount', rowData.amountController),
          ),
          Expanded( // Add this Expanded widget
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete_outline, size: 20),
                onPressed: () {
                  deleteRow(rowData);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemsDropdown(RowData rowData) {
    final products = productsViewModel.allProducts;
    final rateController = rowData.rateController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item',
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        SizedBox(height: 5),
        Container(
          height: 30,
          width: double.infinity, // Set the width to fill available space
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: rowData.itemsDropdownValue,
            onChanged: (newValue) {
              setState(() {
                rowData.itemsDropdownValue = newValue!;
                final selectedProduct = products.firstWhere(
                      (product) => product.product_name == newValue,
                  orElse: () => ProductsModel(
                      product_code: '',
                      product_name: '',
                      uom: '',
                      price: ''
                  ),
                );
                rateController.text = selectedProduct.price!;
                calculateAmount(
                  rowData.qtyController,
                  rowData.rateController,
                  rowData.amountController,
                  rowData,
                );
              });
            },
            items: products
                .map((product) => product.product_name ?? "")
                .toSet()
                .map(
                  (productName) {
                return DropdownMenuItem<String>(
                  value: productName,
                  child: Text(
                    productName,
                    style: TextStyle(fontSize: 11),
                  ),
                );
              },
            )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildNonEditableText(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        SizedBox(height: 5),
        Container(
          height: 30,
          child: TextFormField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
  void addNewRow() {
    setState(() {
      final newRow = RowData(
        serialNumber: serialNumber,
        qtyController: TextEditingController(),
        rateController: TextEditingController(),
        amountController: TextEditingController(),
        // Set a default initial value for itemsDropdownValue
        itemsDropdownValue: productsViewModel.allProducts.isNotEmpty
            ? productsViewModel.allProducts[0].product_name! : '',
      );
      rowDataList.add(newRow);
      serialNumber++;
    });
  }

  void deleteRow(RowData rowData) {
    setState(() {
      rowDataList.remove(rowData);
    });
  }

  void calculateAmount(TextEditingController qtyController,
      TextEditingController rateController,
      TextEditingController amountController,
      RowData rowData) {
    String? qty = qtyController.text;
    String? rate = rateController.text;

    if (qty != null && rate != null) {
      try {
        int qtyValue = int.tryParse(qty) ?? 0;
        int rateValue = int.tryParse(rate) ?? 0;
        int amount = qtyValue * rateValue;
        amountController.text = amount.toString();
      } catch (e) {
        amountController.text = '';
      }
    } else {
      amountController.text = '';
    }
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return now.toUtc().toIso8601String(); // Store the date as ISO8601 format
  }

}
class RowData {
  final int serialNumber;
  final TextEditingController qtyController;
  final TextEditingController rateController;
  final TextEditingController amountController;
  String itemsDropdownValue; // Store the selected product name for this row

  RowData({
    required this.serialNumber,
    required this.qtyController,
    required this.rateController,
    required this.amountController,
    required this.itemsDropdownValue,
  });
}

