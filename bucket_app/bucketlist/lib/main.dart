import 'package:bucketlist/addBucketList.dart';
import 'package:bucketlist/mainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) {
          return Mainscreen();
        },
        "/add": (context) {
          final int newIndex =
              ModalRoute.of(context)!.settings.arguments as int;
          return AddbucketListScreen(newIndex: newIndex);
        },
      },
      initialRoute: "/home",
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
