import 'package:flutter/material.dart';

class RecoveryForm_2ndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eighth Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildTextFieldRow('Receipt:'),
          buildTextFieldRow('Date:'),
          buildTextFieldRow('Shop Name:'),
          buildTextFieldRow('Recovery Person:'),
          buildTextFieldRow('Payment Amount:'),
          buildTextFieldRow('Not Balance:'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the submit button click event
              // You can add your logic here
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldRow(String labelText) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              labelText,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
