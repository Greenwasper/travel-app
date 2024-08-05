import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class WhatToDoDetails extends StatefulWidget {
  String whattodoId;

  WhatToDoDetails({required this.whattodoId});





  @override
  State<WhatToDoDetails> createState() => _WhatToDoDetailsState();
}

class _WhatToDoDetailsState extends State<WhatToDoDetails> {

  final CollectionReference _popularcities =
  FirebaseFirestore.instance.collection('Popular Cities');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: _popularcities.doc(widget.whattodoId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError){
              return Text("${snapshot.hasError}");
            }

            if(snapshot.connectionState == ConnectionState.done){
              DocumentSnapshot<Object?> documentData = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  children: [


                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        children: [
                          Image.network(
                            '${documentData['image1']}',
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            '${documentData['image2']}',
                            fit: BoxFit.cover,
                          ),
                          Image.network(
                            '${documentData['image3']}',
                            fit: BoxFit.cover,
                          ),

                          Image.network(
                            '${documentData['image4']}',
                            fit: BoxFit.cover,
                          ),

                        ],

                        /// Called whenever the page in the center of the viewport changes.
                        onPageChanged: (value) {
                          print('Page changed: $value');
                        },


                        autoPlayInterval: 3000,


                        isLoop: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text('${documentData['name']}', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                    ),







                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text('${documentData['description']}'),
                    )

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
