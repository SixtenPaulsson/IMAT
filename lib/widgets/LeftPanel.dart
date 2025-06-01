import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:flutter/material.dart';

class LeftPanel extends StatefulWidget {
  final ImatDataHandler iMat;

  const LeftPanel({super.key, required this.iMat});

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: AppTheme.colorScheme.secondaryContainer,
      child: Column(
        children: [
          SizedBox(height: AppTheme.paddingSmall),
          _buildCard(
            title: 'Köp igen',
            onPressed: () {
              setState(() => selectedTitle = 'Köp igen');
              widget.iMat.selectPreviousProducts();
            },
            isFirstButton: true,
          ),
          SizedBox(height: AppTheme.paddingSmall),
          _buildCard(
            title: 'Favoriter',
            onPressed: () {
              setState(() => selectedTitle = 'Favoriter');
              widget.iMat.selectFavorites();
            },
          ),
          SizedBox(
            height: AppTheme.paddingLarge,
          ), // Extra spacing after Köp igen
          _buildCard(
            title: 'Visa allting',
            onPressed: () {
              setState(() => selectedTitle = 'Visa allting');
              widget.iMat.selectAllProducts();
            },
          ),
          SizedBox(height: AppTheme.paddingSmall),
          _buildCard(
            title: 'Urval',
            onPressed: () {
              setState(() => selectedTitle = 'Urval');
              var products = widget.iMat.products;
              if (products.isNotEmpty) {
                widget.iMat.selectSelection([
                  products[4],
                  products[45],
                  products[68],
                  products[102],
                  products[110],
                ], 'Urval');
              }
            },
          ),
          SizedBox(height: AppTheme.paddingSmall),
          _buildCard(
            title: 'Grill',
            onPressed: () {
              setState(() => selectedTitle = 'Grill');
              var products = widget.iMat.products;
              if (products.isNotEmpty) {
                widget.iMat.selectSelection([
                  products[3],
                  products[14],
                  products[15],
                  products[16],
                  products[12],
                ], 'Grill');
              }
            },
          ),

          SizedBox(height: AppTheme.paddingSmall),
          _buildCard(
            title: 'Grönsaker',
            onPressed: () {
              setState(() => selectedTitle = 'Grönsaker');
              widget.iMat.selectSelection(
                widget.iMat.findProductsByCategory(ProductCategory.CABBAGE),
                'Grönsaker',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required VoidCallback onPressed,
    bool isFirstButton = false,
  }) {
    final isSelected = selectedTitle == title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isFirstButton
                  ? AppTheme.colorScheme.primary
                  : isSelected
                  ? Colors.grey[300]
                  : Colors.white,
          foregroundColor: isFirstButton ? Colors.white : Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          minimumSize: const Size.fromHeight(52), // Increased height by 10px
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((
            Set<MaterialState> states,
          ) {
            if (states.contains(MaterialState.hovered)) {
              return isFirstButton
                  ? AppTheme.colorScheme.tertiaryContainer
                  : Colors.grey[200];
            }
            return null;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
