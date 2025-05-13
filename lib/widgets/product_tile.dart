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
        borderRadius: BorderRadius.circular(10),
      ),
<<<<<<< HEAD
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: iMat.getImage(product),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _favoriteButton(product, context),
                ),
=======
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), // Add padding inside the card
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the left
              children: [
                // Product Image with Rounded Edges
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Rounded edges for the image
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
                  overflow:
                      TextOverflow.ellipsis, // Add ellipsis if text overflows
                ),
                const SizedBox(height: 4), // Spacing between name and price
                // Product Price
                Text(
                  '${product.price.toStringAsFixed(2)} kr', // Display price with 2 decimal places
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 5), // Spacing between price and buy card
                // Buy Card
                BuyCard(product: product),
>>>>>>> ab9d09de904d22c2374b076acb9be675fd9d7dcd
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${product.price.toStringAsFixed(2)} kr',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            BuyCard(product: product),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton(Product p, context) {
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);
    var isFavorite = iMat.isFavorite(product);

    var icon =
        isFavorite
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
