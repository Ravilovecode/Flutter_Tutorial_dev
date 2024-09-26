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
  List<Color> colors = [
    const Color.fromARGB(255, 199, 45, 37),
    Colors.blue,
    Colors.green,
    const Color.fromARGB(255, 228, 224, 187),
    Colors.purple,
    Colors.orange
  ];

  Widget scrollList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (index) {
          return Container(
            width: 100, // or any other fixed width
            height: 50, // or any other fixed height
            color: Colors.grey,
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text("Container $index"),
            ),
          );
        }),
      ),
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 0,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) /
            ((90 + 40) *
                (MediaQuery.of(context).size.width / 2) /
                (MediaQuery.of(context).size.width - 20)),
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              color: colors[index],
            ),
            Container(
              height: 25,
              color: colors[index],
              alignment: Alignment.center,
              child: Text("Item $index"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Music App")),
          body: Column(
            children: [
              Expanded(
                child: buildGrid(),
              ),
              Expanded(
                child: scrollList(),
              ),
            ],
          )),
    );
  }
}
