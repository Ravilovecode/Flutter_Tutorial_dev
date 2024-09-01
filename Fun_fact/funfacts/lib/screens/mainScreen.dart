import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_screen.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = true;

  void getData() async {
    try {
      Response response = await Dio().get(
          'https://raw.githubusercontent.com/Ravilovecode/flutter_dummy_api/main/facts.json');
      facts = jsonDecode(response.data);
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }

  //api url
  //https://raw.githubusercontent.com/Ravilovecode/flutter_dummy_api/main/facts.json
  @override
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fun Facts'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsScreen();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: facts.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Center(
                                child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            facts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        )));
                      },
                    ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("swipe left for more facts",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ));
  }
}
