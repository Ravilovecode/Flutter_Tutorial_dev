import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;

  ViewItemScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.index});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(
      context,
    );
    try {
      Response response = await Dio().delete(
          "https://flutterapitesting-b0a5b-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  Future<void> markAsComplete() async {
    Navigator.pop(context, "refresh");
    try {
      Map<String, dynamic> data = {"completed": true};
      Response response = await Dio().patch(
          "https://flutterapitesting-b0a5b-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
          data: data);
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text("Are you sure to delete?"),
                        actions: [
                          InkWell(
                              child: Text("cancel"),
                              onTap: () {
                                Navigator.pop(context);
                              }),
                          InkWell(
                              child: Text("Confirm"),
                              onTap: () {
                                //delete data
                                deleteData();
                              }),
                        ]);
                  });
            }
            if (value == 2) {
              markAsComplete();
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("Delete")),
              PopupMenuItem(value: 2, child: Text("Mark as Done"))
            ];
          })
        ],
        title: Text("${widget.title}"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.index.toString()),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
