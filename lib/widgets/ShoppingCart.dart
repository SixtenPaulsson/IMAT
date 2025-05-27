import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/shopping_item.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/pages/checkout_wizard.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatelessWidget {
  final ImatDataHandler iMat;

  const ShoppingCart({super.key, required this.iMat});

  void _showModifyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _ModifyCartDialog(iMat: iMat);
      },
    );
  }

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
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ), // Smaller font size
            ),
            const Divider(color: Colors.black, thickness: 2), // Black line
            // Scrollable Center Section
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehaviorWithCustomScrollbar(),
                child: Builder(
                  builder: (context) {
                    final items = List<ShoppingItem>.from(
                      iMat.getShoppingCart().items,
                    )..sort(
                      (a, b) => a.product.category.index.compareTo(
                        b.product.category.index,
                      ),
                    );
                    Map<ProductCategory, List<ShoppingItem>> grouped = {};
                    for (var item in items) {
                      grouped
                          .putIfAbsent(item.product.category, () => [])
                          .add(item);
                    }
                    return ListView(
                      children:
                          grouped.entries.expand((entry) {
                            return [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                child: Text(
                                  entry.key.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...entry.value.map(
                                (item) => Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: iMat.getImage(item.product),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.product.name,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _showModifyDialog(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  foregroundColor: Colors.black,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4,
                                                      ),
                                                  textStyle: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Ändra Antal',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: Text(
                                            'x${item.amount}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${(item.amount * item.product.price).toStringAsFixed(2)} kr',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.only(
                          left: 200,
                          right: 200,
                          top: 20,
                          bottom: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: SizedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // Adjust radius as needed
                            child:
                                CheckoutWizard(), // The widget from checkout_wizard.dart
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppTheme.colorScheme.tertiary, // Set button color to red
                  foregroundColor: Colors.white, // Set text color to black
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

class _ModifyCartDialog extends StatefulWidget {
  final ImatDataHandler iMat;
  const _ModifyCartDialog({required this.iMat});

  @override
  State<_ModifyCartDialog> createState() => _ModifyCartDialogState();
}

class _ModifyCartDialogState extends State<_ModifyCartDialog> {
  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final items = List<ShoppingItem>.from(widget.iMat.getShoppingCart().items)
      ..sort(
        (a, b) => a.product.category.index.compareTo(b.product.category.index),
      );
    Map<ProductCategory, List<ShoppingItem>> grouped = {};
    for (var item in items) {
      grouped.putIfAbsent(item.product.category, () => []).add(item);
    }
    double total = items.fold(
      0,
      (sum, item) => sum + item.amount * item.product.price,
    );
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.white,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ändra antal produkter',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children:
                    grouped.entries.expand((entry) {
                      return [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          child: Text(
                            entry.key.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...entry.value.map(
                          (item) => Card(
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
                                      child: widget.iMat.getImage(item.product),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item.product.name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${item.product.price.toStringAsFixed(2)} kr',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item.amount > 1) {
                                            widget.iMat.shoppingCartUpdate(
                                              item,
                                              delta: -1,
                                            );
                                          } else {
                                            widget.iMat.shoppingCartRemove(
                                              item,
                                            );
                                            if (widget.iMat
                                                .getShoppingCart()
                                                .items
                                                .isEmpty) {
                                              Navigator.of(context).pop();
                                            }
                                          }
                                          _update();
                                        },
                                      ),
                                      Text(
                                        'x${item.amount}',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          widget.iMat.shoppingCartUpdate(
                                            item,
                                            delta: 1,
                                          );
                                          _update();
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Text(
                                      '${(item.amount * item.product.price).toStringAsFixed(2)} kr',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Ta bort button
                                  TextButton(
                                    onPressed: () {
                                      widget.iMat.shoppingCartRemove(item);
                                      _update();
                                      if (widget.iMat
                                          .getShoppingCart()
                                          .items
                                          .isEmpty) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          AppTheme.colorScheme.tertiary,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      minimumSize: const Size(0, 32),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Ta bort',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    }).toList(),
              ),
            ),
            // Total price in lower right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 4.0),
                  child: Text(
                    'Total: ${total.toStringAsFixed(2)} kr',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
