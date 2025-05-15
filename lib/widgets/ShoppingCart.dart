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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Smaller font size
            ),
            const Divider(color: Colors.black, thickness: 2), // Black line
            // Scrollable Center Section
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehaviorWithCustomScrollbar(),
                child: Builder(
                  builder: (context) {
                    final items = List<ShoppingItem>.from(iMat.getShoppingCart().items)
                      ..sort((a, b) => a.product.category.index.compareTo(b.product.category.index));
                    Map<ProductCategory, List<ShoppingItem>> grouped = {};
                    for (var item in items) {
                      grouped.putIfAbsent(item.product.category, () => []).add(item);
                    }
                    return ListView(
                      children: grouped.entries.expand((entry) {
                        return [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            child: Text(
                              entry.key.name,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...entry.value.map((item) => Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: iMat.getImage(item.product),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            textStyle: const TextStyle(fontSize: 12),
                                          ),
                                          child: const Text('Modify'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      'x${item.amount}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    '${(item.amount * item.product.price).toStringAsFixed(2)} kr',
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ];
                      }).toList(),
                    );
                  },
                ),
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
}

class ScrollBehaviorWithCustomScrollbar extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      controller:
          ScrollController(), //La till den här raden så att programmet inte blir surt
      thumbVisibility: true, // Always show the scrollbar thumb
      thickness: 12.0, // Adjust the thickness of the scrollbar
      radius: Radius.circular(8.0), // Rounded edges for the scrollbar
      child: child,
    );
  }
}
