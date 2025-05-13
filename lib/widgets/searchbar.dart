import 'package:api_test/model/imat_data_handler.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final ImatDataHandler iMat;
  const Searchbar({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onSubmitted: (String value) async {
          iMat.selectSelection(iMat.findProducts(value), 'Sökresultat: $value');
        },
        decoration: InputDecoration(
          hintText: 'Sök varor',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
