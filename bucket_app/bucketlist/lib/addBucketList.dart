import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddbucketListScreen extends StatefulWidget {
  int newIndex;
  AddbucketListScreen({super.key, required this.newIndex});

  @override
  State<AddbucketListScreen> createState() => _AddbucketListScreenState();
}

class _AddbucketListScreenState extends State<AddbucketListScreen> {
  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "completed": false,
        "cost": 10000,
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJOK-1spybg1oUFQ_aLDNE_umf10ZngjJ8Qg&s",
        "item": "Visit Nepal"
      };
      Response response = await Dio().patch(
          "https://flutterapitesting-b0a5b-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bucket List"),
      ),
      body: ElevatedButton(onPressed: addData, child: Text("Add Bucket List")),
    );
  }
}
