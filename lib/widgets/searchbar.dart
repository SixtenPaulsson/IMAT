import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key});

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
