import 'package:flutter/material.dart';

class YourLibrary extends StatelessWidget {
  const YourLibrary({super.key});

  Widget createAppBAr(String mesage) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      foregroundColor: Color.fromARGB(255, 223, 136, 231),
      title: Text(mesage),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.library_music)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Color.fromARGB(255, 93, 102, 109),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          createAppBAr("Your Library"),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
