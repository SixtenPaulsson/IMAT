import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat/shopping_cart.dart' as model;
import 'package:api_test/model/imat/util/functions.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/pages/account_view.dart';
import 'package:api_test/pages/history_view.dart';
import 'package:api_test/widgets/ShoppingCart.dart';
import 'package:api_test/widgets/cart_view.dart';
import 'package:api_test/widgets/logo.dart';
import 'package:api_test/widgets/product_tile.dart';
import 'package:api_test/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_test/widgets/LeftPanel.dart';
import 'package:api_test/widgets/CenterStage.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 20),
                const Logo(),
                const SizedBox(width: 40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Searchbar(iMat: iMat),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _showHistory(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 23),
                  ),
                  child: const Text('Köphistorik'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showAccount(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 23),
                  ),
                  child: const Text('Användare'),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 15, child: LeftPanel(iMat: iMat)),
                Expanded(
                  flex: 60,
                  child: CenterStage(
                    products: products,
                    title: iMat.currentSelectionTitle,
                  ),
                ),
                Expanded(flex: 25, child: ShoppingCart(iMat: iMat)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryView()),
    );
  }

  void _showAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AccountView()),
    );
  }
}
