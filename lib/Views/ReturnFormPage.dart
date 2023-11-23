import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ReturnFormPage(),
  ));
}

class ReturnFormPage extends StatefulWidget {
  @override
  _ReturnFormPageState createState() => _ReturnFormPageState();
}

class _ReturnFormPageState extends State<ReturnFormPage> {
  final TextEditingController _dateTextController = TextEditingController();
  String _selectedShopValue = 'Option 1';
  String _selectedItem1Value = 'Option 1';
  String _selectedItem2Value = 'Option 1';
  String _selectedItem3Value = 'Option 1';
  String _selectedItem4Value = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            'Return Form',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.grey,
          child: Column(
            children: [
              buildDropdownRow(
                '--Select Shop--',
                ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                'Date',
                '----',
                _selectedShopValue,
                _dateTextController,
              ),
              buildItemRow('Item 1', _selectedItem1Value),
              buildItemRow('Item 2', _selectedItem2Value),
              buildItemRow('Item 3', _selectedItem3Value),
              buildItemRow('Item 4', _selectedItem4Value),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownRow(
      String labelText,
      List<String> options,
      String dateLabelText,
      String datePlaceholder,
      String selectedValue,
      TextEditingController textController,
      ) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                hint: Text('-- $labelText --'),
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 16),
          Text('$dateLabelText: ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Container(
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: datePlaceholder,
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemRow(String itemLabel, String selectedValue) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$itemLabel Description', style: TextStyle(fontSize: 16)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<String>(
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      hint: Text('-- Select $itemLabel Description --'),
                      items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Qty', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Enter Field 2',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                SizedBox(width: 16),
                Text('Reason', style: TextStyle(fontSize: 16)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle the submit button click event
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
