import 'package:api_test/app_theme.dart';
import 'package:api_test/pages/history_view.dart';
import 'package:api_test/pages/main_view.dart';
import 'package:api_test/widgets/card_details.dart';
import 'package:api_test/widgets/customer_details.dart';
import 'package:api_test/widgets/logo.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  int _step = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [_header(context), _customerDetails()]),
    );
  }

  void _goBack() {
    setState(() {
      _step = 0;
    });
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _mains();
      case 1:
        return CustomerDetails(
          action: () {
            _goBack();
          },
        );
      case 2:
        return CardDetails(
          voidCallback: () {
            _goBack();
          },
        );
      default:
        return const SizedBox();
    }
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

  Widget _customerDetails() {
    return Expanded(
      child: Container(
        color: AppTheme.colorScheme.secondaryContainer,
        child: Padding(
          padding: EdgeInsets.only(
            left: 300,
            right: 300,
            top: AppTheme.paddingMedium,
            bottom: AppTheme.paddingMedium,
          ),

          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ändra dina Uppgifter här:',
                        style: TextStyle(fontSize: AppTheme.paddingLarge),
                      ),

                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppTheme.colorScheme.onPrimary,
                            border: Border.all(
                              color: AppTheme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(AppTheme.paddingMedium),
                          child: Expanded(child: _buildStep()),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mains() {
    return Row(
      spacing: AppTheme.paddingMedium,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "Här kan du ändra din användar-information, tryck på knapparna nedanför för att redigera eller på handla för att gå tillbaka",
              ),
              //Text("Gå till användare"),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      () => {
                        setState(() {
                          _step = 1;
                        }),
                      },
                  child: Text("Gå till användare"),
                ),
              ),
              SizedBox(height: AppTheme.paddingMedium),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      () => {
                        setState(() {
                          _step = 2;
                        }),
                      },
                  child: Text("Gå till kort"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
}
