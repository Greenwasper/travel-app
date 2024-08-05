import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/pages/ghanatop10/details.dart';
import 'package:febarproject/pages/whatsanew/details.dart';
import 'package:febarproject/pages/whattodo/details.dart';
import 'package:febarproject/pages/wheretogo/details.dart';
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
                        return  ListView(
                          children: snapshot.data!.docs.map((document){
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return GhanaTop10Details(ghanatop10Id: document.id,);
                                  }));
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10)

                                  ),
                                  child: Center(child: Text("${document["name"]}")),
                                ),
                              ),
                            );

                          }).toList(),
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                });

      },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Popular Cities')),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return FutureBuilder<QuerySnapshot>(
                      future: _regions.get(),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        }


                        if(snapshot.connectionState == ConnectionState.done){
                          return  ListView(
                            children: snapshot.data!.docs.map((document){
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WhereToGoDetails(wheretogoId: document.id,);
                                    }));
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10)

                                    ),
                                    child: Center(child: Text("${document["region"]}")),
                                  ),
                                ),
                              );

                            }).toList(),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  });

                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Where To Go')),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return FutureBuilder<QuerySnapshot>(
                      future: _popularcities.get(),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        }


                        if(snapshot.connectionState == ConnectionState.done){
                          return  ListView(
                            children: snapshot.data!.docs.map((document){
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WhatToDoDetails(whattodoId: document.id,);
                                    }));
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10)

                                    ),
                                    child: Center(child: Text("${document["name"]}")),
                                  ),
                                ),
                              );

                            }).toList(),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  });

                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Top Attractions')),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return FutureBuilder<QuerySnapshot>(
                      future: _regions.get(),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        }


                        if(snapshot.connectionState == ConnectionState.done){
                          return  ListView(
                            children: snapshot.data!.docs.map((document){
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return WhatsNewDetails(whatsnewId: document.id,);
                                    }));
                                  },
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10)

                                    ),
                                    child: Center(child: Text("${document["capital"]}")),
                                  ),
                                ),
                              );

                            }).toList(),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  });

                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('What New')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
