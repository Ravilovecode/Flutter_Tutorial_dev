import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      "Home",
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.yellow),
    ));
  }
}
