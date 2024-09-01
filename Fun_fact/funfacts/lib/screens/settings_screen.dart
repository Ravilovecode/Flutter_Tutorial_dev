import 'package:flutter/material.dart';
import 'package:funfacts/providers/themeProvider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<Themeprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SwitchListTile(
        title: Text('Dark Mode'),
        value: themeProvider.isDarkModeChecked,
        onChanged: (value) {
          setState(() {
            themeProvider.setisDarkModeChecked(value);
          });
        },
      ),
    );
  }
}
