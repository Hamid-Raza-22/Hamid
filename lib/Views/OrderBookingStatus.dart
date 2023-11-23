import 'package:flutter/material.dart';

class OrderBookingStatus extends StatefulWidget {
  @override
  _OrderBookingStatusState createState() => _OrderBookingStatusState();
}

class _OrderBookingStatusState extends State<OrderBookingStatus> {
  String? selectedDropdownValue = 'Option 1'; // Initial dropdown value
  String? selectedStatusValue = 'Option 1'; // Initial status dropdown value
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Twelfth Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [   Text(
                  'Shop: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: screenWidth * 0.4,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<String>(
                            value: selectedDropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDropdownValue = newValue;
                              });
                            },
                            items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Order: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: screenWidth * 0.4,
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              // Handle text field value change
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data Range: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: screenWidth * 0.3,
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              // Handle text field value change
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'to',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          // Handle text field value change
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
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
                  Text(
                    'Status: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: screenWidth * 0.4,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          child: Row(
                            children: [

                              DropdownButton<String>(
                                value: selectedStatusValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatusValue = newValue;
                                  });
                                },
                                items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                                    .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Date'),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) {
                        // Handle sorting here
                      },
                    ),
                    DataColumn(
                      label: Text('Order'),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) {
                        // Handle sorting here
                      },
                    ),
                    DataColumn(
                      label: Text('Shop'),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) {
                        // Handle sorting here
                      },
                    ),
                    DataColumn(
                      label: Text('Amount'),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) {
                        // Handle sorting here
                      },
                    ),
                    DataColumn(
                      label: Text('Status'),
                      numeric: false,
                      onSort: (int columnIndex, bool ascending) {
                        // Handle sorting here
                      },
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Data 1')),
                      DataCell(Text('Data 2')),
                      DataCell(Text('Data 3')),
                      DataCell(Text('Data 4')),
                      DataCell(Text('Data 5')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Data 6')),
                      DataCell(Text('Data 7')),
                      DataCell(Text('Data 8')),
                      DataCell(Text('Data 9')),
                      DataCell(Text('Data 10')),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(width: 10), // Add spacing between text and text field
                    Container(
                      width: 200, // Set the width for the input elements
                      child: TextFormField(

                        decoration: InputDecoration(
                          labelText: 'Field 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        textAlign: TextAlign.right, // Align the text field content to the right
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // This will close the current page
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrderBookingStatus(),
  ));
}
