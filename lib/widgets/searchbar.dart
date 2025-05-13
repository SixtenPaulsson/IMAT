import 'package:api_test/model/imat_data_handler.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final ImatDataHandler iMat;
  const Searchbar({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ), // Padding from the bottom for the search bar
        child: SizedBox(
          width:
              400, // Set a fixed width for the search bar to make it smaller in length
          child: TextField(
            onSubmitted: (String value) async {
              iMat.selectSelection(iMat.findProducts(value));
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
        ),
      ),
    );
  }
}
