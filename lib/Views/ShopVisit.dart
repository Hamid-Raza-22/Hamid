import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Databases/OrderDatabase/DBHelperProducts.dart';
import '../Databases/OrderDatabase/DBProductCategory.dart';
import '../Models/ProductsModel.dart';

import '../Models/ShopVisitModels.dart';
import '../View_Models/OrderViewModels/ProductsViewModel.dart';
import '../View_Models/ShopVisitViewModel.dart';
import 'FinalOrderBookingPage.dart';
import 'ShopVisit_2ndPage.dart';
void main() {
  runApp(MaterialApp(
    home: ShopVisit(
      onBrandItemsSelected: (selectedBrand) {
        // Handle the selected brand here if needed
        print("Selected Brand: $selectedBrand");
      },
    ),
  ));
}


class ShopVisit extends StatefulWidget {
  @override
  _ShopVisitState createState() => _ShopVisitState();
  void Function(String) onBrandItemsSelected;
  ShopVisit({Key? key, required this.onBrandItemsSelected}) : super(key: key);
}

class _ShopVisitState extends State<ShopVisit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ShopNameController = TextEditingController();
  TextEditingController _brandDropDownController = TextEditingController();
  TextEditingController BookerNameController = TextEditingController();
  final shopisitViewModel = Get.put(ShopVisitViewModel());
  int? shopvisitId;
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<String> brandDropdownItems = [];
  String selectedItem ='';
  String? selectedDropdownValue;
  String selectedBrand = '';
  List<String> selectedProductNames = [];
  // Add an instance of ProductsViewModel
  ProductsViewModel productsViewModel = Get.put(ProductsViewModel());

  void navigateToNewOrderBookingPage(String selectedBrandName) async {
    // Set the selected shop name without navigation
    setState(() {
      selectedItem = selectedBrandName;
      });
    }

  List<StockCheckItem> stockCheckItems = [StockCheckItem()];

  int serialNo = 1;

  @override
  void initState() {
    super.initState();
    selectedDropdownValue = dropdownItems[0]; // Default value

    // Fetch brand items from the database and set them as dropdown items.
    _fetchBrandItemsFromDatabase();

    // Listen for changes in product names and update the selectedProductNames list
    ever(productsViewModel.allProducts, (List<ProductsModel> products) {
      selectedProductNames = products.map((product) => product.product_name ?? "").toList();
    });

    // Fetch product names from the database and set them as selectedProductNames.
  //  _fetchProductNamesFromDatabase();
  }

  // Method to fetch brand items from the database.
  void _fetchBrandItemsFromDatabase() async {
    DBHelperProductCategory dbHelper = DBHelperProductCategory();
    List<String> brandItems = await dbHelper.getBrandItems();

    // Set the retrieved brand items in the state.
    setState(() {
      brandDropdownItems = brandItems;
    });
  }


  @override
  Widget build(BuildContext context) {

    final shopData = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final passedShopName = shopData['shopName'];
    final passedOwnerName = shopData['ownerName'];
    final userName = shopData['user_name'];
    print(userName);
    print(passedShopName);
    print(passedOwnerName);
     ShopNameController.text= passedShopName!;
    BookerNameController.text=userName!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Visit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Date: ${_getFormattedDate()}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Shop Name',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Container(
                      height: 30,
                      child: TextFormField(
                        controller: ShopNameController,
                        decoration: InputDecoration(
                          //labelText: '$passedShopName',
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Booker Name',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: TextFormField(
                        controller: BookerNameController,
                        decoration: InputDecoration(
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
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Brand',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 30,
                            child: TypeAheadFormField<String>(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _brandDropDownController,
                              ),
                              suggestionsCallback: (pattern) {
                                return brandDropdownItems.where((item) => item.toLowerCase().contains(pattern.toLowerCase())
                                ).toList();
                              },
                              itemBuilder: (context, itemData) {
                                return ListTile(
                                  title: Text(itemData),
                                );
                              },
                              // In the _brandDropDownController's onChanged callback, after the brand is selected, navigate to the FinalOrderBookingPage and pass the selected brand.
                              onSuggestionSelected: (itemData) {

                                setState(() {

                                  _brandDropDownController.text = itemData;

                                });
                                // Call the callback to pass the selected brand to FinalOrderBookingPage
                                widget.onBrandItemsSelected(itemData);
                                print('Selected Brand: $itemData');
                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Checklist',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '1-Stock Check (Current Balance)',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Sr',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Item Description',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '                Qty',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 5),
                        for (int index = 0; index < stockCheckItems.length; index++)
                          StockCheckItemRow(
                            stockCheckItem: stockCheckItems[index],
                            serialNo: index + 1,
                            onDelete: () {
                              deleteStockCheckItem(index);
                            },
                            dropdownItems: dropdownItems,
                            selectedProductNames: selectedProductNames,
                          ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            addStockCheckItem();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Add Item',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate())
                    {

                      // Prepare the data to be passed to the next page
                      Map<String, dynamic> dataToPass = {
                        'shopName': passedShopName,
                        'ownerName': passedOwnerName,
                        'date': _getFormattedDate(),
                        'selectedBrandName': _brandDropDownController.text,
                        'bookerName': BookerNameController.text,
                        'itemDescription':stockCheckItems[0].itemDescriptionController.text,
                        'quantity':stockCheckItems[0].qtyController.text

                      };

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopVisit_2ndPage(),
                          settings: RouteSettings(arguments: dataToPass),
                        ),
                      );
                    }
                    },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Next Page',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void addStockCheckItem() {
    setState(() {
      stockCheckItems.add(StockCheckItem());
    });
  }

  void deleteStockCheckItem(int index) {
    setState(() {
      stockCheckItems.removeAt(index);
    });
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  // Define a callback function to pass the selected brand
  void onBrandSelected(String selectedBrand) {
    setState(() {
      _brandDropDownController.text = selectedBrand;
    });
  }
}

class StockCheckItem {
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  String? selectedDropdownValue;
}class StockCheckItemRow extends StatelessWidget {
  final StockCheckItem stockCheckItem;
  final int serialNo;
  final VoidCallback onDelete;
  final List<String> dropdownItems;
  final List<String> selectedProductNames;

  StockCheckItemRow({
    required this.stockCheckItem,
    required this.serialNo,
    required this.onDelete,
    required this.dropdownItems,
    required this.selectedProductNames,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$serialNo',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(width: 20),
        Container(
          width: 175,
          height: 30,
          child:TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              controller: stockCheckItem.itemDescriptionController,
            ),
            suggestionsCallback: (pattern) {
              return selectedProductNames.where(
                    (item) => item.toLowerCase().contains(pattern.toLowerCase()),
              ).toList();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: Text(itemData),
              );
            },
            onSuggestionSelected: (itemData) {
              stockCheckItem.selectedDropdownValue = itemData;
              stockCheckItem.itemDescriptionController.text = itemData;
            },
          )

        ),
        SizedBox(width: 10),
        Container(
          width: 70,
          height: 30,
          child: TextFormField(
            controller: stockCheckItem.qtyController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, size: 20),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
