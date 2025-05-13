import 'package:api_test/model/imat/shopping_item.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatelessWidget {
  final ImatDataHandler iMat;

  const ShoppingCart({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded edges
      ),
      elevation: 5, // Add shadow for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text
            const Text(
              'Din Shopping Lista',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.black, thickness: 2), // Black line
            // Scrollable Center Section
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollBehaviorWithCustomScrollbar(), // Custom scroll behavior
                child: ListView(children: _buildCategorySections()),
              ),
            ),

            // Bottom Section
            const Divider(color: Colors.black, thickness: 2), // Black line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${iMat.shoppingCartTotal().toStringAsFixed(2)} kr',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  iMat.placeOrder();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set button color to red
                  foregroundColor: Colors.black, // Set text color to black
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Gå till Checkout',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategorySections() {
    Map<ProductCategory, List<ShoppingItem>> categorizedItems = {};

    // Categorize items
    for (var item in iMat.getShoppingCart().items) {
      categorizedItems.putIfAbsent(item.product.category, () => []).add(item);
    }

    // Build sections for each category
    List<Widget> sections = [];
    categorizedItems.forEach((category, items) {
      sections.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            ...items.map(
              (item) => ListTile(
                title: Text(item.product.name),
                subtitle: Text(
                  '${item.amount} x ${item.product.price.toStringAsFixed(2)} kr',
                ),
              ),
            ),
          ],
        ),
      );
    });

    return sections;
  }
}

class ScrollBehaviorWithCustomScrollbar extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      thumbVisibility: true, // Always show the scrollbar thumb
      thickness: 12.0, // Adjust the thickness of the scrollbar
      radius: Radius.circular(8.0), // Rounded edges for the scrollbar
      child: child,
    );
  }
}
