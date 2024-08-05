import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/pages/settings/about%20us.dart';
import 'package:febarproject/pages/settings/editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';
import '../components/custom_text.dart';
import '../components/loader.dart';
import '../components/switch_tile.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = false;

  List<bool> tileValues = [false];

  User? user = FirebaseAuth.instance.currentUser;
  Map userInfo = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userEmail = '';
  String? first_name = '';

  void getUserInfo () async {
    DocumentSnapshot userInfoSnapshot = await _firestore.collection('users').doc(user!.uid).get();
    userInfo = userInfoSnapshot.data() as Map;
    print(userInfo);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if(user == null){
      userEmail = 'Not logged in';
      Navigator.pop(context);
    } else {
      userEmail = user!.email!;
      first_name = user!.displayName;
      getUserInfo();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple[800]!
              ]
            )
          ),
        ),
        // backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        elevation: 0,
      ),


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [


            Center(child: userInfo.isEmpty ? const Text('Loading...') : Text(userInfo['firstname'])),

            CircleAvatar(
              radius: 60,
              child: Icon(Icons.add_a_photo),
            ),


            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SettingsEditProfile();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text('Edit Profile', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AboutUs();
                  }));
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text('Settings', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  height: 60,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text('LogOut', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
            )


          ],
        ),
      )
    );
  }
}


/*
class OldSettings extends StatefulWidget {
  const OldSettings({super.key});

  @override
  State<OldSettings> createState() => _OldSettingsState();
}

class _OldSettingsState extends State<OldSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.purple[800]!
                  ]
              )
          ),
        ),
        // backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            secondaryColor
                          ]
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        ),
                        SizedBox(height: 10),
                        CustomText(text: "Name: $first_name", color: Colors.white, fontSize: 30, textAlign: TextAlign.center,),
                        SizedBox(height: 10),
                        CustomText(text: "Email: $userEmail", color: Colors.white, fontSize: 18),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            if(mounted){
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.red.shade400,
                                        Colors.red.shade400,
                                      ]
                                  )
                              ),
                              child: const Center(
                                child: CustomText(text: "Logout", color: Colors.white, fontSize: 17),
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 280),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          CustomText(text: "Settings", fontSize: 30),
                          SizedBox(height: 20),
                          Column(
                            children: List.generate(tileValues.length, (index) {
                              return CustomSwitchTile(
                                title: "Enable Notifications",
                                subtitle: "Receive Notifications",
                                icon: Icons.notifications,
                                iconBackgroundColor: Colors.pink,
                                value: tileValues[index],
                                onChanged: (value) {
                                  setState(() {
                                    tileValues[index] = value;
                                  });
                                },
                              );
                            }),
                          ),
                        ]
                    ),
                  ),
                ),
              )
            ],
          ),
          isLoading ? const Loader() : const SizedBox(height: 0)
        ],
      ),
    );
  }
}

*/

