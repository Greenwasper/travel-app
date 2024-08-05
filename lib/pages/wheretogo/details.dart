import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WhereToGoDetails extends StatefulWidget {
  String wheretogoId;

  WhereToGoDetails({required this.wheretogoId});





  @override
  State<WhereToGoDetails> createState() => _GhanaTop10DetailsState();
}

class _GhanaTop10DetailsState extends State<WhereToGoDetails> {

  final CollectionReference _regions =
  FirebaseFirestore.instance.collection('Regions');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: _regions.doc(widget.wheretogoId).get(),
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
                      child: Text('${documentData['region']}', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Text('Capital:'),
                          Text('${documentData['capital']}', style: TextStyle(
                              fontSize: 15
                          ),),


                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Text('Area:'),
                          Text('${documentData['area']}', style: TextStyle(
                              fontSize: 15
                          ),),


                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Text('Population:'),
                          Text('${documentData['population']}', style: TextStyle(
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

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Text('Key LandMark:'),
                          Text('${documentData['key landmark']}', style: TextStyle(
                              fontSize: 15
                          ),),


                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage('${documentData['image1']}'),
                                fit: BoxFit.fill,
                              )
                          )
                      ),
                    ),



                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
