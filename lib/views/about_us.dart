import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';
import '../components/custom_text.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
        ),
        // backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder<QuerySnapshot>(
          future: _firestore.collection('About us').get(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            }

            if(snapshot.connectionState == ConnectionState.done){
              return ListView(
                children: snapshot.data!.docs.map((document){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Center(child: Image.asset('assets/logo.png', width: 120)),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 10),
                          CustomText(text: 'About Us',fontSize: 27, fontWeight: FontWeight.w600),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: document['About us'], color: Colors.black.withOpacity(0.8), fontSize: 16),
                      const SizedBox(height: 15),

                      const Row(
                        children: [
                          Icon(Icons.person, color: Colors.green),
                          SizedBox(width: 10),
                          CustomText(text: 'Who We Are',fontSize: 27, fontWeight: FontWeight.w600),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: document['Who We Are'], color: Colors.black.withOpacity(0.8), fontSize: 16),
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.yellow.shade800),
                          const SizedBox(width: 10),
                          const CustomText(text: 'Our Vision',fontSize: 27, fontWeight: FontWeight.w600),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: document['Our Vision'], color: Colors.black.withOpacity(0.8), fontSize: 16),
                      const SizedBox(height: 15),

                      const Row(
                        children: [
                          Icon(Icons.timeline, color: Colors.purple),
                          SizedBox(width: 10),
                          CustomText(text: 'What We Do',fontSize: 27, fontWeight: FontWeight.w600),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: document['What We Do'], color: Colors.black.withOpacity(0.8), fontSize: 16),
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Icon(Icons.volunteer_activism, color: Colors.red.shade300),
                          const SizedBox(width: 10),
                          const CustomText(text: 'Our Commitment',fontSize: 27, fontWeight: FontWeight.w600),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: document['Our Commitment'], color: Colors.black.withOpacity(0.8), fontSize: 16),
                      const SizedBox(height: 15),
                    ],
                  );
                }).toList(),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
