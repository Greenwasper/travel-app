import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/views/community.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_text.dart';
import 'chatroom.dart';


class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  User user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _searchController = TextEditingController();
  bool searchEnabled = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchEnabled = !searchEnabled;
              });
            },
            icon: searchEnabled ? const Icon(Icons.close) : const Icon(Icons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
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

          return SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: searchEnabled,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value){
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Column(
                  children: snapshot.data!.docs.map((doc){
                    Map data = doc.data() as Map;
                    if(user.email != doc['email']){

                      if(searchEnabled){
                        return "${data['firstname']} ${data['lastnamename']}".toLowerCase().contains(_searchController.text.toLowerCase()) ? Column(
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: CustomText(text: "${data['firstname']} ${data['lastnamename']}"),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(receiverId: doc['uid'], receiverName: "${data['firstname']} ${data['lastnamename']}")));
                              },
                            ),
                            const Divider(),
                          ],
                        ) : SizedBox();
                      }

                      return Column(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: CustomText(text: "${data['firstname']} ${data['lastnamename']}"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(receiverId: doc['uid'], receiverName: "${data['firstname']} ${data['lastnamename']}")));
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    }
                    return const SizedBox(height: 0);
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Community()));
        },
        child: const Icon(Icons.groups),
      ),
    );
  }
}
