import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat/shopping_item.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/widgets/BuyCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), // Add padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
              children: [
                // Product Image with Rounded Edges
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Rounded edges for the image
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: iMat.getImage(product), // Display product image
                  ),
                ),
                const SizedBox(height: 8), // Spacing between image and text
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                ),
                const SizedBox(height: 4), // Spacing between name and price
                // Product Price
                Text(
                  '${product.price.toStringAsFixed(2)} kr', // Display price with 2 decimal places
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5), // Spacing between price and buy card
                // Buy Card
                BuyCard(product: product),
              ],
            ),
          ),
          // Star Icon in the Top-Right Corner
          Positioned(
            top: 8,
            right: 8,
            child: _favoriteButton(product, context),
          ),
        ],
      ),
    );
  }

  Widget _favoriteButton(Product p, context) {
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);
    var isFavorite = iMat.isFavorite(product);

    var icon = isFavorite
        ? Icon(Icons.star, color: Colors.orange)
        : Icon(Icons.star_border, color: Colors.orange);

    return IconButton(
      onPressed: () {
        iMat.toggleFavorite(product);
      },
      icon: icon,
    );
  }
}