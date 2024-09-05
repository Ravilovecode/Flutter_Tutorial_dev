import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/providers/userProvider.dart';
import 'package:globalchat/screens/edit_profile_screen.dart';
import 'package:globalchat/screens/profile_screen%20copy.dart';
import 'package:globalchat/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  var Scaffoldkey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> chatrooms = [];

  void getChatrooms() {
    db.collection("chatrooms").get().then((dataSnapshot) {
      for (var singleChatroomData in dataSnapshot.docs) {
        chatrooms.add(singleChatroomData.data());
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getChatrooms();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<Userprovider>(context);

    return Scaffold(
        key: Scaffoldkey,
        appBar: AppBar(
          title: const Text("Global chat"),
          leading: InkWell(
            onTap: () {
              Scaffoldkey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircleAvatar(
                radius: 20,
                child: Text(userProvider.userName[0]),
              ),
            ),
          ),
        ),
        drawer: Drawer(
            child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                leading: CircleAvatar(
                  child: Text(userProvider.userName[0]),
                ),
                title: Text(userProvider.userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(userProvider.userEmail),
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                      (route) {
                    return false;
                  });
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              )
            ],
          ),
        )),
        body: ListView.builder(
            itemCount: chatrooms.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey[900],
                  child: Text(chatrooms[index]["chatroom_name"][0],
                      style: TextStyle(color: Colors.white)),
                ),
                title: Text(chatrooms[index]["chatroom_name"] ?? ""),
                subtitle: Text(chatrooms[index]["desc"] ?? ""),
              );
            }));
  }
}
