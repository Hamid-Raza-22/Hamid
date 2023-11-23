import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_booking_shop/Views/HomePage.dart';


class OrderBooking_2ndPage extends StatelessWidget {
  String? selectedDropdownValue = 'Option 1';
  bool isDataSavedInApex = true;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final orderId = data['orderId'];
    final orderDate = data['orderDate'];
    final bookerName  = data['bookerName'];
    final rowDataDetails = data['rowDataDetails'] as List<Map<String, dynamic>>;

    final selectedItems = <String>[];
    final quantities = <int>[];
    final totalAmounts = <int>[];

    for (final rowData in rowDataDetails) {
      final selectedItem = rowData['selectedItem'] as String;
      final quantity = rowData['quantity'] as int;
      final totalAmount = rowData['totalAmount'] as int;

      selectedItems.add(selectedItem);
      quantities.add(quantity);
      totalAmounts.add(totalAmount);}

    final totalAmount = totalAmounts.fold<int>(0, (sum, amount) => sum + amount);



    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildSizedBox(30),
              buildText('Order#'),
              buildTextFormField(30,orderId.toString(), readOnly: true), // Set read-only
              buildSizedBox(10),
              buildText('Booker Name'),
              buildTextFormField(30,bookerName, readOnly: true), // Set read-only
              buildSizedBox(10),
              buildText('Order Date'),
              buildTextFormField(30,orderDate.toString(), readOnly: true), // Set read-only
              buildSizedBox(20),
              buildHeading('Order Summary', 15),
              buildSizedBox(10),
              buildRow([
                buildExpandedColumn('Description', 50, readOnly: true),
                buildSizedBox(10),
                buildExpandedColumn('Qty', 20, readOnly: true),
                buildSizedBox(10),
                buildExpandedColumn('Amount', 20, readOnly: true),
              ]),
              for (int i = 0; i < selectedItems.length; i++)
                buildRow([
                  buildExpandedColumn(selectedItems[i], 50, readOnly: true),
                  buildSizedBox(10),
                  buildExpandedColumn(quantities[i].toString(), 20, readOnly: true),
                  buildSizedBox(10),
                  buildExpandedColumn(totalAmounts[i].toString(), 20, readOnly: true),
                ]), buildSizedBox(10),
              buildRow([ buildText('Total  '),
                buildSizedBox(10),
                buildExpandedColumn(totalAmount.toString(), 10, readOnly: true),
              ]),

              Column(
                children: [
                  buildSizedBox(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        child: buildElevatedButton('Re Confirm', () {
                          // Handle the action for the "Re Confirm" button here
                        }),
                      ),
                    ],
                  ),
                  buildSizedBox(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: buildElevatedButton('PDF Share', () {

                          if (isDataSavedInApex) {
                            //Logic
                          } else {
                            //Logic
                          }
                          // Handle the action for the "PDF Share" button here
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  buildSizedBox(10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 100,
                      child: buildElevatedButton('Close', () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
  }

  Widget buildTextFormField(double height,String text, {bool readOnly = false}) {
    return Container(
      height: height,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        maxLines: 1,
        style: TextStyle(fontSize: 15),
        initialValue: text,
        readOnly: readOnly,
      ),
    );
  }

  Widget buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  Widget buildHeading(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildExpandedColumn(String Text, double width, {bool readOnly = false}) {
    return Expanded(
      flex: width != null ? width.toInt() : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Text != null)
            buildTextFormField(30,Text,readOnly: readOnly),
        ],
      ),
    );
  }

  Widget buildRow(List<Widget> children) {
    return Row(
      children: children,
    );
  }

  Widget buildElevatedButton(String txt, [Function()? onPressed]) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(txt),
    );
  }
}

