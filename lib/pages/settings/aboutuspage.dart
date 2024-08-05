import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Aboutuspage extends StatefulWidget {
  const Aboutuspage({super.key});

  @override
  State<Aboutuspage> createState() => _AboutuspageState();
}

class _AboutuspageState extends State<Aboutuspage> {

  final CollectionReference _aboutus =
  FirebaseFirestore.instance.collection('About us');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<QuerySnapshot>(
              future: _aboutus.get(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }


                if(snapshot.connectionState == ConnectionState.done){
                  return  ListView(
                    children: snapshot.data!.docs.map((document){
                      return Column(
                        children: [

                          Text('About Us', style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold
                          ),),

                          Text('${document['About us']}'),


                          Text('Who We Are', style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                          ),),

                          Text('${document['Who We Are']}'),

                          Text('Our Vision', style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                          ),),

                          Text('${document['Our Vision']}'),

                          Text('What We Do', style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                          ),),

                          Text('${document['What We Do']}'),

                          Text('Our Commitment', style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold
                          ),),

                          Text('${document['Our Commitment']}'),




                        ],
                      );

                    }).toList(),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        )
    );
  }
}
