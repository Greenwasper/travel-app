

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SettingsEditProfile extends StatefulWidget {
  const SettingsEditProfile({super.key});

  @override
  State<SettingsEditProfile> createState() => _SettingsEditProfileState();
}

class _SettingsEditProfileState extends State<SettingsEditProfile> {

  bool _obscureText = true;

  final CollectionReference _users =
  FirebaseFirestore.instance.collection('users');








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: FutureBuilder<QuerySnapshot>(
        future: _users.get(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('${snapshot.error}');
          }


          if(snapshot.connectionState == ConnectionState.done){
            return  Column(
              children: snapshot.data!.docs.map((document){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [







                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: InputBorder.none,

                              icon: Icon(Icons.accessibility),

                              hintText: '${document['user_name']}'//"Name: $first_name"
                          ),

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                border: InputBorder.none,

                                hintText: '${document['phonenumber']}'//"Name: $first_name"

                            ),

                          )
                      ),

                      SizedBox(
                        height: 20,
                      ),


                      Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                icon: Icon(Icons.mail),
                                border: InputBorder.none,

                                hintText: '${document['email']}'//"Name: $first_name"






                            ),

                          )
                      ),

                      SizedBox(
                        height: 20,
                      ),


                      Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureText,
                          )



                      ),

                      SizedBox(
                        height: 20,
                      ),


                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.indigo
                                    ])
                            ),
                            child: Center(child: Text('Edit Profile', style: TextStyle(
                                color: Colors.white

                            ),)),
                          ),
                        ],
                      )


                    ],
                  ),
                );

              }).toList(),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NewNew extends StatefulWidget {
  const NewNew({super.key});

  @override
  State<NewNew> createState() => _NewNewState();
}

class _NewNewState extends State<NewNew> {

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [





            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: InputBorder.none,

                    icon: Icon(Icons.accessibility),

                    hintText: 'Username Here...'//"Name: $first_name"






                ),

              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      border: InputBorder.none,

                      hintText: '+23361717166'//"Name: $first_name"

                  ),

                )
            ),

            SizedBox(
              height: 20,
            ),


            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      border: InputBorder.none,

                      hintText: 'email Here...'//"Name: $first_name"






                  ),

                )
            ),

            SizedBox(
              height: 20,
            ),


            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                )



            ),

            SizedBox(
              height: 20,
            ),


            Column(
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.indigo
                          ])
                  ),
                  child: Center(child: Text('Edit Profile', style: TextStyle(
                      color: Colors.white

                  ),)),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}

