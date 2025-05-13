import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ), // Padding from the top for the "iMat" button
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
    );
  }
}
