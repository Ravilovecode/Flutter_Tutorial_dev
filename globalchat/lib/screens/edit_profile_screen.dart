import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalchat/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, dynamic>? userData = {};
  TextEditingController nameText = TextEditingController();

  var db = FirebaseFirestore.instance;

  var editProfileForm = GlobalKey<FormState>();

  void initState() {
    nameText.text = Provider.of<Userprovider>(context, listen: false).userName;
    // TODO: implement initState
    super.initState();
  }

  void updateData() {
    Map<String, dynamic> dataToUpdate = {
      "name": nameText.text,
    };
    db
        .collection("users")
        .doc(Provider.of<Userprovider>(context, listen: false).userId)
        .update(dataToUpdate);

    Provider.of<Userprovider>(context, listen: false).getUserDetails();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<Userprovider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"), actions: [
        InkWell(
          onTap: () {
            if (editProfileForm.currentState!.validate()) {
              updateData();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.check),
          ),
        )
      ]),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: editProfileForm,
            child: Column(children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                controller: nameText,
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}