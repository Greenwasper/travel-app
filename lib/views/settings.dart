import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/loader.dart';
import 'package:travel/components/switch_tile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLoading = false;

  List<bool> tileValues = [false];

  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = '';

  @override
  void initState() {
    // TODO: implement initState
    if(user == null){
      userEmail = 'Not logged in';
    } else {
      userEmail = user!.email!;
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
                      CustomText(text: "Bryan Anyanful", color: Colors.white, fontSize: 30, textAlign: TextAlign.center,),
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
