import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomName;
  String chatroomID;

  ChatroomScreen(
      {super.key, required this.chatroomName, required this.chatroomID});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController messageText = TextEditingController();

  var db = FirebaseFirestore.instance;
  Future<void> sendMessage() async {
    if (messageText.text.isEmpty) {
      return;
    }
    Map<String, dynamic> messageToSend = {
      "text": messageText.text,
      "sender_name": Provider.of<Userprovider>(context, listen: false).userName,
      "chatroom_id": widget.chatroomID,
      "timestamp": FieldValue.serverTimestamp(),
    };

    try {
      await db.collection("messages").add(messageToSend);
    } catch (error) {
      print(error);
    }

    messageText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(44, 47, 59, 1.0),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageText,
                    decoration: InputDecoration(
                        hintText: "Enter Message", border: InputBorder.none),
                  )),
                  InkWell(
                    child: Icon(Icons.send),
                    onTap: () {
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
