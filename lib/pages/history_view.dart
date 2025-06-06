import 'package:api_test/app_theme.dart';
import 'package:api_test/model/imat/order.dart';
import 'package:api_test/model/imat/shopping_item.dart';
import 'package:api_test/model/imat_data_handler.dart';
import 'package:api_test/pages/account_view.dart';
import 'package:api_test/pages/main_view.dart';
import 'package:api_test/widgets/ShoppingCart.dart';
import 'package:api_test/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Stateful eftersom man behöver komma ihåg vilken order som är vald
// När den valda ordern ändras så ritas gränssnittet om pga
// anropet till setState
class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Order? _selectedOrder;

  @override
  Widget build(BuildContext context) {
    // Provider.of eftersom denna vy inte behöver veta något om
    // ändringar i iMats data. Den visar bara det som finns nu
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);

    // Hämta datan som ska visas
    var orders = iMat.orders;
    //Försöker välja en order från början
    if (_selectedOrder == null) {
      //ba ifall man inte valt
      if (orders.isNotEmpty) {
        _selectedOrder = orders[orders.length - 1]; //väljer senaste
      }
    }
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(context),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  //height: 600,
                  // Creates the list to the left.
                  // When a user taps on an item the function _selectOrder is called
                  // The Material widget is need to make hovering pliancy effects visible
                  child: Material(
                    color: AppTheme.colorScheme.secondaryContainer,
                    child: _ordersList(context, orders, _selectOrder),
                  ),
                ),
                // Creates the view to the right showing the
                // currently selected order.
                Expanded(
                  flex: 60,
                  child: Container(
                    color: Colors.white,
                    child: _orderDetails(_selectedOrder, iMat),
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

  Widget _header(BuildContext context) {
    return Container(
      color: AppTheme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Logo(),
          const SizedBox(width: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => _showMainview(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 23),
            ),
            child: const Text('Handla'),
          ),
          const SizedBox(width: 10),
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
    );
  }

  Widget _ordersList(BuildContext context, List<Order> orders, Function onTap) {
    final reversedOrders = orders.reversed.toList();
    return ListView.separated(
      itemCount: reversedOrders.length,
      itemBuilder: (context, index) => _orderInfo(reversedOrders[index], onTap),
      separatorBuilder:
          (context, index) => Divider(height: 1, color: Colors.blueGrey),
    );
  }

  Widget _orderInfo(Order order, Function onTap) {
    return ListTile(
      onTap: () => onTap(order),
      title: Text(_formatDateTime(order.date)),
    );
  }

  Widget _producttile(ShoppingItem item, ImatDataHandler imat) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: imat.getImage(item.product),
            ),
            Expanded(child: Text('${item.product.name}, ${item.amount}')),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppTheme.colorScheme.tertiary,
                  ),
                ),
                onPressed: () {
                  setState(() {});

                  imat.shoppingCartUpdate(
                    ShoppingItem(item.product, amount: 1),
                    delta: 1,
                  );
                },
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            /*Expanded(
              child: Container(
                color: AppTheme.colorScheme.onPrimary,
              

                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {});

                    imat.shoppingCartUpdate(
                      ShoppingItem(item.product, amount: 1),
                      delta: 1,
                    );
                  },
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  _selectOrder(Order order) {
    setState(() {
      //dbugPrint('select order ${order.orderNumber}');
      _selectedOrder = order;
    });
  }

  // This uses the package intl
  String _formatDateTime(DateTime dt) {
    final formatter = DateFormat('yyyy-MM-dd, HH:mm');
    return "Produkter den " + (formatter.format(dt));
  }

  // THe view to the right.
  // When the history is shown the first time
  // order will be null.
  // In the null case the function returns SizedBox.shrink()
  // which is a what to use to create an empty widget.
  Widget _orderDetails(Order? order, ImatDataHandler imat) {
    if (order != null) {
      return ListView(
        children: [
          Text(
            "Tidigare köp",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Välj tidigare köp till vänster eller tryck handla för att gå tillbaka",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            _formatDateTime(order.date),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: AppTheme.paddingSmall),
          for (final item in order.items) _producttile(item, imat),

          SizedBox(height: AppTheme.paddingSmall),
          Text(
            'Totalt: ${order.getTotal().toStringAsFixed(2)}kr',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }
}

void _showHistory(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HistoryView()),
  );
}

void _showMainview(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MainView()),
  );
}

void _showAccount(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AccountView()),
  );
}
