import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/chat_bubble.dart';
import 'package:travel/components/message.dart';
import 'package:travel/components/custom_text.dart';

class ChatRoom extends StatefulWidget {

  final String receiverId;

  const ChatRoom({super.key, required this.receiverId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage () async {
    Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: user!.uid,
      senderEmail: user!.email!,
      receiverId: widget.receiverId,
      message: _messageController.text,
      timeStamp: timestamp
    );

    List<String> ids = [user!.uid, widget.receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    _messageController.clear();
    await FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  Stream<QuerySnapshot> getMessages () {
    List<String> ids = [user!.uid, widget.receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).collection('messages').orderBy('timeStamp', descending: false).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getMessages(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text("Error loading message");
                }

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading...");
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                });

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                    controller: _scrollController,
                    children: snapshot.data!.docs.map((doc){
                      Map data = doc.data() as Map;

                      return Container(
                        alignment: data['senderId'] == user!.uid ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          children: [
                            ChatBubble(
                              message: data['message'],
                              isSender: data['senderId'] == user!.uid,
                              timeStamp: data['timeStamp']),
                          ],
                        )
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: "Enter message..."
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: const Icon(Icons.send),
              )
            ],
          )
        ],
      ),
    );
  }
}
