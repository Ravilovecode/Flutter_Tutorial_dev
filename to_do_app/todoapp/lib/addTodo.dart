import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  void Function({required String todoText}) addTodo;

  Addtodo({super.key, required this.addTodo});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("ADD todo"),
        TextField(
          onSubmitted: (value) {
            if (todoText.text.isNotEmpty) {
              widget.addTodo(todoText: todoText.text);
            }

            todoText.clear();
          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            hintText: "Enter Todo",
            labelText: "Todo",
            border: OutlineInputBorder(),
            icon: Icon(Icons.add),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 20.0,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (todoText.text.isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
              }

              todoText.clear();
            },
            child: Text("ADD"))
      ],
    );
  }
}


//new chiz