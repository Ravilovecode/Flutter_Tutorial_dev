import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddMoneyButton extends StatelessWidget {
  Function() addMoneyFunction;

  AddMoneyButton({super.key, required this.addMoneyFunction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 0),
          backgroundColor: Color.fromARGB(255, 25, 212, 93),
        ),
        onPressed: addMoneyFunction,
        child: Text("Deposit",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
      ),
    );
  }
}
