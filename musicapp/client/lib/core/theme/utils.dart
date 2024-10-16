import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar
    ..showSnackBar(
      SnackBar(
        content: Text(content.toString()),
        backgroundColor: Color.fromARGB(255, 219, 204, 205),
      ),
    );
}
