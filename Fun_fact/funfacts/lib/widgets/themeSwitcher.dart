import 'package:flutter/material.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Theme Mode ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Switch(
            value: ischecked,
            onChanged: (value) {
              setState(() {
                ischecked = value;
              });
            },
          ),
          SizedBox(width: 10),
          Text(ischecked ? "Dark Mode" : "Light Mode"),
        ],
      ),
    );
  }
}
