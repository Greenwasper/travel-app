import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/views/community.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  bool searchEnabled = false;

  @override
  void initState() {
    super.initState();
    // getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  child: CustomText(text: "Home",),
                ),
                Tab(
                  child: CustomText(text: "Friends",),
                ),
                Tab(
                  child: CustomText(text: "Requests",),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Add Friends"),
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

                        QueryDocumentSnapshot userInfo = snapshot.data!.docs.firstWhere((u) {return u['email'] == user.email;});
                        List requests = userInfo['requests'];
                        List friends = userInfo['friends'];

                        print(friends);

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
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {

                                              });
                                            },
                                            icon: const Icon(Icons.search),
                                          ),
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
                                            onTap: () async {

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
                                          onTap: () async {

                                            // await _firestore.collection('users').doc(doc['uid']).get();

                                            bool hasRequested = requests.contains(doc['uid']);
                                            bool isFriend = friends.contains(doc['uid']);

                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Add Friend'),
                                                  content: Text(isFriend ? '${data['firstname']} ${data['lastnamename']} is already your friend' : hasRequested ? 'You have already requested to be friends with ${data['firstname']} ${data['lastnamename']}' : 'Add ${data['firstname']} ${data['lastnamename']} as a friend?'),
                                                  actions: isFriend ? [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ] : hasRequested ? [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ] :
                                                  [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        _firestore.collection('users').doc(doc['uid']).update({
                                                          'requests': FieldValue.arrayUnion([user.uid])
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Add', style: TextStyle(color: Colors.green)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
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
                  ),
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Chats"),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
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

                        QueryDocumentSnapshot userInfo = snapshot.data!.docs.firstWhere((u) {return u['email'] == user.email;});
                        List friends = userInfo['friends'];

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
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {

                                              });
                                            },
                                            icon: const Icon(Icons.search),
                                          ),
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
                                  if(user.email != doc['email'] && friends.contains(doc['uid'])){

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
                                      ) : const SizedBox();
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
                  ),
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Requests"),
                      centerTitle: true,
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

                        QueryDocumentSnapshot userInfo = snapshot.data!.docs.firstWhere((u) {return u['email'] == user.email;});
                        List requests = userInfo['requests'];

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: snapshot.data!.docs.map((doc){
                                  Map data = doc.data() as Map;
                                  if(user.email != doc['email'] && requests.contains(doc['uid'])){

                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: const CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                          title: CustomText(text: "${data['firstname']} ${data['lastnamename']}"),
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Add Friend'),
                                                  content: Text('Accept friend request from ${data['firstname']} ${data['lastnamename']}'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {

                                                        requests

                                                      },
                                                      child: const Text('Accept', style: TextStyle(color: Colors.green)),
                                                    ),
                                                  ]
                                                );
                                              },
                                            );
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
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Community()));
          },
          child: const Icon(Icons.groups),
        ),
      ),
    );
  }
}
