import 'package:flutter/material.dart';
import 'package:spotify/screens/app.dart';
import 'package:spotify/screens/home.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Spotify Player",
    home: MyApp(),
  ));
}
