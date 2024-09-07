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
      "sender_id": Provider.of<Userprovider>(context, listen: false).userId,
      "chatroom_id": widget.chatroomID,
      "timestamp": FieldValue.serverTimestamp(),
    };

    messageText.clear();

    try {
      await db.collection("messages").add(messageToSend);
    } catch (error) {
      print(error);
    }
  }

  Widget singleChatItem(
      {required String sender_name,
      required String text,
      required String sender_id}) {
    return Column(
      crossAxisAlignment:
          sender_id == Provider.of<Userprovider>(context, listen: false).userId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            sender_name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: sender_id ==
                      Provider.of<Userprovider>(context, listen: false).userId
                  ? Color.fromARGB(255, 207, 49, 207)
                  : Color.fromARGB(200, 17, 16, 17),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: sender_id ==
                          Provider.of<Userprovider>(context, listen: false)
                              .userId
                      ? Colors.white
                      : Colors.white),
            )),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      backgroundColor: Color.fromARGB(0, 120, 142, 228),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text(snapshot.error.toString());
              }

              var allMessages = snapshot.data?.docs ?? [];

              if (allMessages.isEmpty) {
                return Center(
                  child: Text("No Messages"),
                );
              }

              return ListView.builder(
                  reverse: true,
                  itemCount: allMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: singleChatItem(
                          sender_name: allMessages[index]["sender_name"],
                          text: allMessages[index]["text"],
                          sender_id: allMessages[index]["sender_id"]),
                    );
                  });
            },
            stream: db
                .collection("messages")
                .where("chatroom_id", isEqualTo: widget.chatroomID)
                .orderBy("timestamp", descending: true)
                .snapshots(),
          )),
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
