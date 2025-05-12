import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat/util/functions.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/pages/account_view.dart';
import 'package:api_test/pages/history_view.dart';
import 'package:api_test/widgets/cart_view.dart';
import 'package:api_test/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 10, child: _header(context)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 20,
                  //height: 400,
                  child: _leftPanel(iMat),
                ),
                Expanded(
                  flex: 55,
                  //height: 400,
                  child: _centerStage(context, products),
                ),
                Expanded(
                  flex: 25,
                  //color: Colors.blueGrey,
                  child: _shoppingCart(iMat),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shoppingCart(ImatDataHandler iMat) {
    return Column(
      children: [
        Text('Kundvagn'),
        Container(height: 600, child: CartView()),
        ElevatedButton(
          onPressed: () {
            iMat.placeOrder();
          },
          child: Text('Köp!'),
        ),
      ],
    );
  }

  Container _leftPanel(ImatDataHandler iMat) {
    return Container(
      width: 300,
      color: const Color.fromARGB(255, 154, 172, 134),
      child: Column(
        children: [
          SizedBox(height: AppTheme.paddingSmall),
          SizedBox(
            width: 132,
            child: ElevatedButton(
              onPressed: () {
                iMat.selectAllProducts();
              },
              child: Text('Visa allt'),
            ),
          ),
          SizedBox(height: AppTheme.paddingSmall),
          SizedBox(
            width: 132,
            child: ElevatedButton(
              onPressed: () {
                //print('Favoriter');
                iMat.selectFavorites();
              },
              child: Text('Favoriter'),
            ),
          ),
          SizedBox(height: AppTheme.paddingSmall),
          SizedBox(
            width: 132,
            child: ElevatedButton(
              onPressed: () {
                var products = iMat.products;
                iMat.selectSelection([
                  products[4],
                  products[45],
                  products[68],
                  products[102],
                  products[110],
                ]);
              },
              child: Text('Urval'),
            ),
          ),
          SizedBox(height: AppTheme.paddingSmall),
          SizedBox(
            width: 132,
            child: ElevatedButton(
              onPressed: () {
                //print('Frukt');
                iMat.selectSelection(
                  iMat.findProductsByCategory(ProductCategory.CABBAGE),
                );
              },
              child: Text('Grönsaker'),
            ),
          ),
          SizedBox(height: AppTheme.paddingSmall),
          SizedBox(
            width: 132,
            child: ElevatedButton(
              onPressed: () {
                //print('Söktest');
                iMat.selectSelection(iMat.findProducts('mj'));
              },
              child: Text('Söktest'),
            ),
          ),
        ],
      ),
    );
  }

  Column _header(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppTheme.paddingLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('iMat')),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    dbugPrint('Historik-knapp');
                    _showHistory(context);
                  },
                  child: Text('Köphistorik'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAccount(context);
                  },
                  child: Text('Användare'),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppTheme.paddingMedium),
      ],
    );
  }

  Widget _centerStage(BuildContext context, List<Product> products) {
    // ListView.builder has the advantage that tiles
    // are built as needed.
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductTile(products[index]);
      },
    );
  }

  void _showAccount(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountView()),
    );
  }

  void _showHistory(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryView()),
    );
  }
}
