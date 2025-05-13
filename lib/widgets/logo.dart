import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const Text(
      'iMat',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
=======
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
>>>>>>> ab9d09de904d22c2374b076acb9be675fd9d7dcd
      ),
    );
  }
}
