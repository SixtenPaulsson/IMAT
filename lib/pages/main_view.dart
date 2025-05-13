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
          Expanded(
            flex: 15,
            child: Container(
              color:
                  Colors.lightBlue, // Set light blue background for the header
              child: Column(children: [_header(context)]),
            ),
          ),
          Expanded(
            flex: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 15, child: LeftPanel(iMat: iMat)),
                Expanded(flex: 60, child: CenterStage(products: products)),
                Expanded(flex: 25, child: ShoppingCart(iMat: iMat)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _header(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    return Column(
      children: [
        Container(
          color: Colors.lightBlue, // Set light blue background
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ), // Add padding for spacing
          child: Stack(
            children: [
              Expanded(flex: 15, child: Logo()),
              Expanded(flex: 60, child: Searchbar(iMat: iMat)),
              Expanded(
                flex: 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ), // Padding from the top for the right buttons
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            dbugPrint('Historik-knapp');
                            _showHistory(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // White button background
                            foregroundColor: Colors.black, // Black text color
                            textStyle: TextStyle(
                              fontSize: 23, // Larger font size for buttons
                            ),
                          ),
                          child: Text('Köphistorik'),
                        ),
                        SizedBox(width: 10), // Add spacing between buttons
                        ElevatedButton(
                          onPressed: () {
                            _showAccount(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // White button background
                            foregroundColor: Colors.black, // Black text color
                            textStyle: TextStyle(
                              fontSize: 23, // Larger font size for buttons
                            ),
                          ),
                          child: Text('Användare'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
