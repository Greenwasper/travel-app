import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/views/chatroom.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return user != null ? Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs.map((doc){
              Map data = doc.data() as Map;
              if(user!.email != doc['email']){
                return ListTile(
                  title: CustomText(text: data['email']),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(receiverId: doc['uid'])));
                  },
                );
              }
              return const SizedBox(height: 0);
            }).toList(),
          );
        },
      ),
    ) : const Center(child: CustomText(text: "Login to use chat feature"),);
  }
}
