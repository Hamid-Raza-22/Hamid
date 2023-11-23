import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Databases/OrderDatabase/DBHelperProducts.dart';

import '../View_Models/OrderViewModels/ProductsViewModel.dart'; // Import your database-related classes

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsViewModel _productsViewModel = ProductsViewModel();

  @override
  void initState() {
    super.initState();
    // Fetch data when the page is initialized
    _productsViewModel.fetchAllProductsModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Obx(() {
        // Use Obx to listen to changes in the allProducts list
        final products = _productsViewModel.allProducts;

        if (products.isEmpty) {
          return Center(child: Text('No products available.'));
        }

        return ListView.builder(
          itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card( // Use Card widget for better data display
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product:  ${product.product_name ?? ''}"),
                      Text("UOM: ${product.uom ?? ''}"),
                      Text("Price: ${product.price ?? ''}"),
                    ],
                  ),
                ),
              );
            },

        );
      }),
    );
  }
}
