import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      "Search",
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.yellow),
    ));
  }
}
