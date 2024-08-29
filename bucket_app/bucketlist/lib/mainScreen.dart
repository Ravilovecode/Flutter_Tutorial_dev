import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:bucketlist/addBucketList.dart';
import 'package:bucketlist/viewItem.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  String error = '';

  Future<void> getData() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      var response = await Dio().get(
          "https://flutterapitesting-b0a5b-default-rtdb.firebaseio.com/bucketlist.json");

      if (response.data != null) {
        setState(() {
          bucketListData = List.from(response.data);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'No data found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching data';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData(); // Load data when the widget is initialized
  }

//error widget
  Widget errorWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning, color: Colors.red),
        Text("Error getting bucket list", style: TextStyle(color: Colors.red)),
        ElevatedButton(
            onPressed: () {
              getData();
            },
            child: Text("Retry"))
      ],
    ));
  }

  //list widget

  Widget listWidget() {
    List<dynamic> filteredList = bucketListData
        .where((element) => !(element?["completed"] ?? false))
        .toList();
    return filteredList.length < 1
        ? Center(
            child: Text("No Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ((bucketListData[index] is Map) &&
                        (!(bucketListData[index]?["completed"] ?? false)))
                    ? ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewItemScreen(
                              index: index,
                              title: bucketListData[index]["item"] ??
                                  "Unknown Item",
                              image: bucketListData[index]["image"] ??
                                  "Unknown Image",
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            bucketListData[index]?["image"] ??
                                "", // Handle null image URLs
                          ),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Handle image loading error
                            print("Error loading image: $exception");
                          },
                        ),
                        title: Text(bucketListData[index]?["item"] ??
                            "Unknown Item"), // Handle null item names
                        trailing: Text(
                            bucketListData[index]?["cost"]?.toString() ??
                                "N/A"), // Handle null cost values
                      )
                    : SizedBox(),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddbucketListScreen(
              newIndex: bucketListData.length,
            );
          }));
        },
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 228, 217, 238),
      appBar: AppBar(
        title: Text("Bucket List"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getData(); // Reload data when the refresh button is pressed
            },
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : error.isNotEmpty
              ? errorWidget() // Show error message
              : RefreshIndicator(
                  onRefresh: () async {
                    await getData();
                  },
                  child: listWidget(),
                ),
    );
  }
}
