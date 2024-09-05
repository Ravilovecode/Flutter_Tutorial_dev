import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Userprovider extends ChangeNotifier {
  String userName = "Dummy username";
  String userEmail = "dummy mail";
  String userId = "dummy id";

  var db = FirebaseFirestore.instance;

  void getUserDetails() async {
    var authUser = FirebaseAuth.instance.currentUser!;
    var data = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((dataSnapshot) {
      userName = dataSnapshot.data()?["name"] ?? "Dummy username";
      userEmail = dataSnapshot.data()?["email"] ?? "dummy mail";
      userId = dataSnapshot.data()?["id"] ?? "dummy id";
      notifyListeners();
    });
    print(data.data());
  }
}
