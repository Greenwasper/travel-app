import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WhatsNewDetails extends StatefulWidget {
  String whatsnewId;

  WhatsNewDetails({required this.whatsnewId});





  @override
  State<WhatsNewDetails> createState() => _GhanaTop10DetailsState();
}

class _GhanaTop10DetailsState extends State<WhatsNewDetails> {

  final CollectionReference _regions =
  FirebaseFirestore.instance.collection('Regions');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: FutureBuilder(
        future: _regions.doc(widget.whatsnewId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text("${snapshot.hasError}");
          }

          if(snapshot.connectionState == ConnectionState.done){
            DocumentSnapshot<Object?> documentData = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text('${documentData['area']}', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text('Author:'),
                        Text('${documentData['area']}', style: TextStyle(
                            fontSize: 15
                        ),),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage('${documentData['image']}'),
                              fit: BoxFit.fill,
                            )
                        )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('${documentData['description']}'),
                  ),



                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
