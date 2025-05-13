import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  final ImatDataHandler iMat;

  const LeftPanel({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: const Color.fromARGB(255, 154, 172, 134),
      child: Column(
        children: [
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Köp igen',
            onPressed: () => iMat.selectPreviousProducts(),
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Grill',
            onPressed: () {
              var products = iMat.products ?? [];
              if (products.isNotEmpty) {
                iMat.selectSelection([
                  products[4],
                  products[12],
                  products[14],
                  products[15],
                  products[16],
                ]);
              }
            },
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Visa allting',
            onPressed: () => iMat.selectAllProducts(),
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Favoriter',
            onPressed: () => iMat.selectFavorites(),
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Urval',
            onPressed: () {
              var products = iMat.products ?? [];
              if (products.isNotEmpty) {
                iMat.selectSelection([
                  products[4],
                  products[45],
                  products[68],
                  products[102],
                  products[110],
                ]);
              }
            },
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Grönsaker',
            onPressed:
                () => iMat.selectSelection(
                  iMat.findProductsByCategory(ProductCategory.CABBAGE),
                ),
          ),
          SizedBox(height: AppTheme.paddingTiny),
          _buildCard(
            title: 'Söktest',
            onPressed: () => iMat.selectSelection(iMat.findProducts('mj')),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed, // Make the entire card clickable
      hoverColor: const Color.fromARGB(255, 255, 1, 1), // Change color on hover
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 190,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 5,
                ), // Add padding to the top-left
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16), // Adjust font size if needed
                ),
              ),
              Spacer(), // Push the button to the right
              Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ), // Add padding to the right
                child: SizedBox(
                  height: 40, // Set the desired height for the button
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text(
                      'Go To',
                    ), // Replace with your button text if needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
