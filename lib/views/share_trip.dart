import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/colors.dart';
import 'package:febarproject/components/functions.dart';
import 'package:febarproject/components/trip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_text.dart';
import '../components/message.dart';

class ShareTrip extends StatefulWidget {

  final Trip trip;

  const ShareTrip({super.key, required this.trip});

  @override
  State<ShareTrip> createState() => _ShareTripState();
}

class _ShareTripState extends State<ShareTrip> {
  final TextEditingController _searchController = TextEditingController();
  bool searchEnabled = false;

  User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List friends = [];
  Set selectedFriends = {};

  void getFriends () async {
    QuerySnapshot allUsers = await _firestore.collection('users').get();
    QueryDocumentSnapshot userInfo = allUsers.docs.firstWhere((u) {return u['email'] == user.email;});
    List friendsRaw = userInfo['friends'];

    for(var friendUid in friendsRaw){
      QueryDocumentSnapshot friendInfo = allUsers.docs.firstWhere((u) {return u['uid'] == friendUid;});
      friends.add(friendInfo);
    }

    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Trip", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CustomText(text: "Select the friends you want to share your trip with", fontSize: 18, textAlign: TextAlign.center),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(friends.length, (index) {

                  QueryDocumentSnapshot friend = friends[index];

                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    trailing: Checkbox(
                      value: selectedFriends.contains(friend['uid']),
                      onChanged: (value) {
                        if(selectedFriends.contains(friend['uid'])){
                          selectedFriends.remove(friend['uid']);
                        } else {
                          selectedFriends.add(friend['uid']);
                        }

                        setState(() {

                        });
                      },
                    ),
                    title: CustomText(text: "${friend['firstname']} ${friend['lastnamename']}"),
                    onTap: () {

                      if(selectedFriends.contains(friend['uid'])){
                        selectedFriends.remove(friend['uid']);
                      } else {
                        selectedFriends.add(friend['uid']);
                      }

                      setState(() {

                      });
                    },
                  );
                }),
              ),
            ),
          ),
          selectedFriends.isNotEmpty ? Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  List selectedFriendsList = selectedFriends.toList();

                  for (var friendUid in selectedFriendsList){
                    Timestamp timestamp = Timestamp.now();

                    Message newMessage = Message(
                      senderId: user.uid,
                      senderEmail: user.email!,
                      receiverId: friendUid,
                      message: "Hey, check out my trip!",
                      trip: widget.trip.toMap(),
                      timeStamp: timestamp
                    );

                    List<String> ids = [user.uid, friendUid];
                    ids.sort();
                    String chatRoomId = ids.join('_');

                    _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());
                  }

                  toast("Sending trips to friends");
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text("Share"),
              ),
              const SizedBox(height: 10),
            ],
          ) : const SizedBox(height: 0),
        ],
      ),
    );
  }
}
