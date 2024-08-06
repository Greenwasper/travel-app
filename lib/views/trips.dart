import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:febarproject/components/functions.dart';
import 'package:febarproject/components/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/trip.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> with SingleTickerProviderStateMixin{

  bool isLoading = true;

  late AnimationController _animationController;
  User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, TextEditingController> controllers = {};
  Map<String, DateTime> selectedDates = {};

  List trips = [];

  void getTrips () async {
    DocumentSnapshot storedTrips = await _firestore.collection('trips').doc(user.uid).get();

    if(storedTrips.data() == null || (storedTrips.data() as Map).isEmpty){

    } else{
      print(storedTrips.data());

      trips = (storedTrips.data() as Map)['trips'];

      for(var trip in trips){
        DateTime date = trip['date'].toDate();
        controllers[trip['id']] = TextEditingController(text: formatDate(date));
        selectedDates[trip['id']] = date;
      }
    }

    setState(() {
      _animationController.forward();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );

    getTrips();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();

    for(var controller in controllers.entries){
      controller.value.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading ? trips.isEmpty ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/empty.json', controller: _animationController),
          const SizedBox(height: 20),
          const CustomText(text: "You haven't planned any trips", fontSize: 17,),
        ],
      ),
    ):
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomText(text: "Your Trips", fontSize: 25),
              const SizedBox(height: 20),
              Column(
                children: List.generate(trips.length, (index) {
                  Trip trip = Trip(
                    id: trips[index]['id'],
                    name: trips[index]['name'],
                    destination: trips[index]['destination'],
                    date: trips[index]['date']
                  );

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue, width: 3),
                    ),
                    child: Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: CustomText(text: trip.name, fontSize: 17)),
                              const SizedBox(height: 10),
                              CustomText(text: "Destination: ${trip.destination['location']}"),
                              CustomText(text: "Price: ${trip.destination['price']['max']}"),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const CustomText(text: "Trip Date:"),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: controllers[trip.id],
                                      decoration: const InputDecoration(
                                        hintText: 'Enter trip date',
                                        border: UnderlineInputBorder(),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: selectedDates[trip.id],
                                          firstDate: DateTime(2024),
                                          lastDate: DateTime(2026),
                                        );
                                        if (date != null) {

                                          List updatedTrips = trips.map((map) {
                                            if (map['id'] == trip.id) {
                                              return {
                                                ...map,
                                                'date': Timestamp.fromDate(date)
                                              };
                                            }
                                            return map;
                                          }).toList();

                                          await _firestore.collection('trips').doc(user.uid).update({
                                            'trips': updatedTrips
                                          });

                                          setState(() {
                                            selectedDates[trip.id] = date;
                                            controllers[trip.id]!.text = formatDate(date);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]
                        ),
                        const Positioned(
                          top: 7,
                          right: 7,
                          child: Icon(Icons.location_on_outlined, size: 40, color: Colors.blue,),
                        )
                      ],
                    ),
                  );
                }),
              )
            ]
        ),
      ),
    ) : Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
