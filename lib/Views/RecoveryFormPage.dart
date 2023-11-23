import 'package:flutter/material.dart';
import 'package:order_booking_shop/Views/RecoveryForm_2ndPage.dart';



class RecoveryFromPage extends StatefulWidget {
  @override
  _RecoveryFromPageState createState() => _RecoveryFromPageState();
}

class _RecoveryFromPageState extends State<RecoveryFromPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  TextEditingController _textField1Controller = TextEditingController();
  TextEditingController _textField2Controller = TextEditingController();
  TextEditingController _textField3Controller = TextEditingController();
  TextEditingController _yourController = TextEditingController();

  List<String> dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  String? selectedDropdownValue;

  @override
  void initState() {
    super.initState();
    selectedDropdownValue = dropdownItems[0];
  }

  @override
  Widget build(BuildContext context) {
    double inputWidth = 200; // Set the width for the input elements
    double dropdownWidth = 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text('Seventh Page'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to the Seventh Page!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Row with Date text and Field 1
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'DATE',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: inputWidth,
                              child: TextFormField(
                                controller: _textField1Controller,
                                decoration: InputDecoration(
                                  labelText: 'Field 1',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                textAlign: TextAlign.right,
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
                      // Dropdown menu with specified width
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Shop Name',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Container(
                        width: dropdownWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(),
                        ),
                        child: DropdownButton<String>(
                          value: selectedDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue = newValue;
                            });
                          },
                          items: dropdownItems.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Row with 3 text fields
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          '----- Previous Payment History -----',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Date'),
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField2Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text('Amount'),
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text('Recovery Person'),
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                        ],
                      ),
                      SizedBox(height: 20),
                      // Second Row with 3 text fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField2Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField2Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                width: inputWidth,
                                child: TextFormField(
                                  controller: _textField3Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Auto',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
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
                        ],
                      ),
                      SizedBox(height: 20),

                      // Three additional rows with one text field each

                      SizedBox(height: 20),

// Third Row with label and text field
                      // First Row with label and text field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Cash Recover'),
                                  SizedBox(width: 10),
                                  Container(
                                    width: inputWidth,
                                    child: TextFormField(
                                      controller: _textField1Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Field 1',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      textAlign: TextAlign.right,
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

// Second Row with label and text field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Recovery Person '),
                                  SizedBox(width: 10),
                                  Container(
                                    width: inputWidth,
                                    child: TextFormField(
                                      controller: _textField2Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Field 2',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      textAlign: TextAlign.right,
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

// Third Row with label and text field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Net Balance'),
                                  SizedBox(width: 10),
                                  Container(
                                    width: inputWidth,
                                    child: TextFormField(
                                      controller: _textField3Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Field 3',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      textAlign: TextAlign.right,
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
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecoveryForm_2ndPage()),
                        );
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission
                        }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
