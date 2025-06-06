import 'package:api_test/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat/shopping_item.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class BuyCard extends StatefulWidget {
  final Product product;

  const BuyCard({super.key, required this.product});

  @override
  _BuyCardState createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  bool isBuying = false; // Controls visibility of the +, -, and amount
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);
    quantity = iMat.shoppingCarItemAmount(ShoppingItem(widget.product));
    isBuying = quantity > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child:
          isBuying
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Minus Button
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 0) {
                        iMat.shoppingCartUpdate(
                          ShoppingItem(widget.product),
                          delta: -1,
                        );
                        setState(() {});
                      }
                    },
                  ),
                  // Quantity Text
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Plus Button
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      iMat.shoppingCartAdd(ShoppingItem(widget.product));
                      setState(() {}); //uppdaterar kortet
                    },
                  ),
                ],
              )
              : SizedBox(
                width: double.infinity, // Make the button stretch horizontally
                height: 45, // Set the desired height for the button
                child: ElevatedButton(
                  onPressed: () {
                    iMat.shoppingCartAdd(ShoppingItem(widget.product));
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colorScheme.primary,
                    // Set the button color
                    foregroundColor:
                        AppTheme.colorScheme.onPrimary, // Set the text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Köp',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ), // Larger text
                  ),
                ),
              ),
    );
  }
}
