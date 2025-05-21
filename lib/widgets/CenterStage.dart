import 'package:api_test/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:api_test/widgets/product_tile.dart';
import 'package:api_test/model/imat/product.dart';

class CenterStage extends StatelessWidget {
  final List<Product> products;
  final String title;

  const CenterStage({
    super.key,
    required this.products,
    this.title = 'Populära varor denna veckan!!',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ), // Add padding from LeftPanel and ShoppingCart
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ), // Padding for the top card
            child: SizedBox(
              width: double.infinity, // Make the card stretch horizontally
              height: 65, // Set the desired height for the card
              child: Card(
                color:
                    AppTheme
                        .colorScheme
                        .inversePrimary, // Set the background color of the card
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    10,
                  ), // Add padding inside the card
                  child: Text(
                    title, // Use the title parameter for the header text
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 5 products per row
                crossAxisSpacing: 12, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio:
                    0.59, // Decreased from 0.7 to 0.6 to make cards taller
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
