import 'package:flutter/material.dart';
import 'package:api_test/widgets/product_tile.dart';
import 'package:api_test/model/imat/product.dart';

class CenterStage extends StatelessWidget {
  final List<Product> products;

  const CenterStage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding from LeftPanel and ShoppingCart
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5), // Padding for the top card
            child: SizedBox(
              width: double.infinity, // Make the card stretch horizontally
              height: 150, // Set the desired height for the card
              child: Card(
                color: Colors.lightBlue, // Set the background color of the card
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10), // Add padding inside the card
                  child: Text(
                    'Populära varor denna veckan!!', // Replace with your desired text
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 5 products per row
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 1, // Adjust the aspect ratio of each product card
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductTile(products[index]); // Display each product
              },
            ),
          ),
        ],
      ),
    );
  }
}