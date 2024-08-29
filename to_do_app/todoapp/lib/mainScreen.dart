import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:todoapp/addTodo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/widgets/todolist.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void showaddTodoBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 223, 212, 212),
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: 200.0,
              child: Addtodo(
                addTodo: addTodo,
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already exists"),
              content: Text("This todo already exists"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });

      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an list of strings to 'items' key.
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: showaddTodoBottomSheet,
          child: Icon(FeatherIcons.plus),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          foregroundColor: Colors.white,
          splashColor: const Color.fromARGB(255, 59, 70, 80),
          hoverColor: const Color.fromARGB(255, 59, 70, 80),
        ),
      ),
      drawer: Drawer(
        child: Column(children: [
          Container(
            color: const Color.fromARGB(255, 59, 70, 80),
            height: 200.0,
            width: double.infinity,
            child: Center(
              child: Text(
                "TODO APP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              launchUrl(Uri.parse("https://github.com/ravilovecode"));
            },
            leading: Icon(Icons.person),
            title: Text(
              "About Me",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              launchUrl(Uri(
                scheme: 'mailto',
                path: 'ravikumarray042@gmail.com',
              ));
            },
            leading: Icon(Icons.email),
            title: Text(
              "Contact Me",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 70, 80),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Todo App',
        ),
      ),
      body: TodoListBuilder(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
