import 'package:api_test/app_theme.dart';
import 'package:api_test/pages/history_view.dart';
import 'package:api_test/pages/main_view.dart';
import 'package:api_test/widgets/card_details.dart';
import 'package:api_test/widgets/customer_details.dart';
import 'package:api_test/widgets/logo.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(context),
          SizedBox(height: AppTheme.paddingSmall),
          _customerDetails(),
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
            onPressed: () => _showMainview(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 23),
            ),
            child: const Text('Handla'),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _customerDetails() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Användaruppgifter:',
                  style: TextStyle(fontSize: AppTheme.paddingLarge),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorScheme.inversePrimary,
                    border: Border.all(
                      color: AppTheme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(AppTheme.paddingMedium),
                  child: CustomerDetails(),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kortdetaljer:',
                  style: TextStyle(fontSize: AppTheme.paddingLarge),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorScheme.inversePrimary,
                    border: Border.all(
                      color: AppTheme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(AppTheme.paddingMedium),
                  child: CardDetails(),
                ),
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

  void _showMainview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainView()),
    );
  }
}
