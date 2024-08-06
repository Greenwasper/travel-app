import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';
import '../components/colors.dart';
import '../components/message.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  User user = FirebaseAuth.instance.currentUser!;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  Map userInfo = {};
  String name = '';

  void getUserInfo () async {
    DocumentSnapshot userInfoSnapshot = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    userInfo = userInfoSnapshot.data() as Map;

    name = "${userInfo['firstname']} ${userInfo['lastnamename']}";

    setState(() {

    });
  }

  Stream<QuerySnapshot> getMessages () {
    return FirebaseFirestore.instance.collection('community').orderBy('timeStamp', descending: false).snapshots();
  }

  Future<void> sendMessage () async {
    Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: user.uid,
        senderEmail: user.email!,
        senderName: name,
        receiverId: '',
        message: _messageController.text,
        timeStamp: timestamp
    );

    _messageController.clear();
    await FirebaseFirestore.instance.collection('community').add(newMessage.toMap());
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
          ),
          title: const Text('Community Chat', style: const TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(
            color: Colors.white, // Change the drawer icon color to white
          ),
          elevation: 0,
        ),
      ),
      body: userInfo.isEmpty ?
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ) :
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.2,
                image: AssetImage('assets/chat_wallpaper2.webp'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: getMessages(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return const Text("Error loading messages");
                  }

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      controller: _scrollController,
                      children: snapshot.data!.docs.map((doc){
                        Map data = doc.data() as Map;

                        return Container(
                          alignment: data['senderId'] == user.uid ? Alignment.centerRight : Alignment.centerLeft,
                          child: Column(
                            children: [
                              ChatBubble(
                                inCommunity: true,
                                communityName: data['name'],
                                message: data['message'],
                                isSender: data['senderId'] == user.uid,
                                timeStamp: data['timeStamp']
                              ),
                            ],
                          )
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(letterSpacing: 0.1),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter message...",
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none
                        ),
                        suffixIcon: GestureDetector(
                          onTap: sendMessage,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: const Icon(Icons.send, color: Colors.white),
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
