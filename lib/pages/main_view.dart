import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/product.dart';
import 'package:api_test/model/imat/shopping_cart.dart' as model;
import 'package:api_test/model/imat/util/functions.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/pages/account_view.dart';
import 'package:api_test/pages/history_view.dart';
import 'package:api_test/widgets/ShoppingCart.dart';
import 'package:api_test/widgets/cart_view.dart';
import 'package:api_test/widgets/product_tile.dart';
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
            color: Colors.lightBlue, // Set light blue background for the header
            height: 150, // Increase the height of the header
            child: Column(
              children: [
                _header(context),
              ],
            ),
          ),
          Expanded(
            flex: 86,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 12,
                  child: LeftPanel(iMat: iMat),
                ),
                Expanded(
                  flex: 63,
                  child: CenterStage(products: products),
                ),
                Expanded(
                  flex: 25,
                  child: ShoppingCart(iMat: iMat),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Column _header(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.lightBlue, // Set light blue background
          height: 150, // Increased height for the header
          padding: EdgeInsets.symmetric(horizontal: 20), // Add padding for spacing
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10), // Padding from the top for the "iMat" button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White button background
                      foregroundColor: Colors.black, // Black text color
                      textStyle: TextStyle(
                        fontSize: 48, // Larger font size for "iMat"
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('iMat'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10), // Padding from the top for the right buttons
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          dbugPrint('Historik-knapp');
                          _showHistory(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // White button background
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
                          backgroundColor: Colors.white, // White button background
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10), // Padding from the bottom for the search bar
                  child: SizedBox(
                    width: 900, // Set a fixed width for the search bar to make it smaller in length
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Sök varor',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
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
