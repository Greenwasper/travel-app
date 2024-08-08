import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:febarproject/components/info_tile.dart';
import 'package:febarproject/components/location_tile.dart';
import 'package:febarproject/pages/ghanatop10/details.dart';
import 'package:febarproject/pages/whatsanew/details.dart';
import 'package:febarproject/pages/whattodo/details.dart';
import 'package:febarproject/pages/wheretogo/details.dart';
import 'package:febarproject/views/info.dart';
import 'package:flutter/material.dart';

class LastMenu extends StatefulWidget {
  const LastMenu({super.key});

  @override
  State<LastMenu> createState() => _LastMenuState();
}

class _LastMenuState extends State<LastMenu> {

  final CollectionReference _regions =
  FirebaseFirestore.instance.collection('Regions');

  final CollectionReference _topattractions =
  FirebaseFirestore.instance.collection('Top Attractions');

  final CollectionReference _popularcities =
  FirebaseFirestore.instance.collection('Popular Cities');




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Center(child: CustomText(text: "Info", fontSize: 25)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return FutureBuilder<QuerySnapshot>(
                    future: _topattractions.get(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return  Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView(
                            children: snapshot.data!.docs.map((document){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return GhanaTop10Details(ghanatop10Id: document.id,);
                                  }));
                                },
                                child: LocationTile(label: document["name"], icon: Icons.location_city, iconBackgroundColor: Colors.green)
                              );
                            }).toList(),
                          ),
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });
              },
              child: const InfoTile(label: 'Popular Cities', icon: Icons.location_city, iconBackgroundColor: Colors.green,)
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return FutureBuilder<QuerySnapshot>(
                    future: _regions.get(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return  Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView(
                            children: snapshot.data!.docs.map((document){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return WhereToGoDetails(wheretogoId: document.id,);
                                  }));
                                },
                                child: LocationTile(label: document["region"], icon: Icons.map_outlined, iconBackgroundColor: Colors.blue,)
                              );

                            }).toList(),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });
              },
              child: const InfoTile(label: "Where To Go", icon: Icons.map_outlined, iconBackgroundColor: Colors.blue,)
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return FutureBuilder<QuerySnapshot>(
                    future: _popularcities.get(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return  Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView(
                            children: snapshot.data!.docs.map((document){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return WhatToDoDetails(whattodoId: document.id,);
                                  }));
                                },
                                child: LocationTile(label: document["name"], icon: Icons.plus_one, iconBackgroundColor: Colors.yellow.shade800,)
                              );

                            }).toList(),
                          ),
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });

              },
              child: InfoTile(label: 'Top Attractions', icon: Icons.plus_one, iconBackgroundColor: Colors.yellow.shade800)
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context){
                  return FutureBuilder<QuerySnapshot>(
                    future: _regions.get(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }

                      if(snapshot.connectionState == ConnectionState.done){
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView(
                            children: snapshot.data!.docs.map((document){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return WhatsNewDetails(whatsnewId: document.id,);
                                  }));
                                },
                                child: LocationTile(label: document["capital"], icon: Icons.newspaper_outlined, iconBackgroundColor: Colors.red,)
                              );

                            }).toList(),
                          ),
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });

              },
              child: const InfoTile(label: "What's New", icon: Icons.newspaper_outlined, iconBackgroundColor: Colors.red)
            ),
          ],
        ),
      ),
    );
  }
}
