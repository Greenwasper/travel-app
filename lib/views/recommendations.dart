import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:febarproject/components/recommendation_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../components/timeline_element.dart';
import '../components/trip.dart';
import '../components/trip_model.dart';
import 'base.dart';

class Recommendation extends StatefulWidget {

  final String region;
  final RangeValues rangeValues;
  final Set<String> selectedCategories;

  const Recommendation({super.key, required this.rangeValues, required this.selectedCategories, required this.region});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {

  bool gottenRecommendations = false;
  User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Set<Map> recommendationsSet = {};
  List<Map> recommendations = [];
  Set<Map> selectedLocations = {};

  void getLocations () async {
    String selectedRegion = widget.region;
    double minBudget = widget.rangeValues.start;
    double maxBudget = widget.rangeValues.end;
    Set<String> selectedCategories = widget.selectedCategories;

    print("Region: $selectedRegion");
    print("Min: $minBudget");
    print("Max: $maxBudget");
    print(selectedCategories);

    QuerySnapshot placesSnapshot = await _firestore.collection('places').get();
    List<DocumentSnapshot> places = placesSnapshot.docs;
    List allLocations = [];

    for(var place in places){
      Map placeMap = place.data() as Map;
      List locations = placeMap['locations'];
      String region = placeMap['region'];

      for(var location in locations){
        Map locationMap = location;
        locationMap['region'] = region;
        allLocations.add(locationMap);
      }
    }

    print(allLocations[0]);

    for(Map location in allLocations) {
      if (location['region'] == selectedRegion) { // Region Check
        for (var selectedCategory in selectedCategories.toList()) {
          if (location[selectedCategory.toLowerCase()] == 'Y') { // Category Check
            // if (double.parse(location['price']['min']) >= minBudget && maxBudget >= double.parse(location['price']['max'])) { // Price Check
              recommendationsSet.add(location);
            // }
          }
        }
      }
    }

    recommendations = recommendationsSet.toList();
    gottenRecommendations = true;
    print("Number of Recommendations: ${recommendations.length}");

    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue, Colors.purple[800]!])),
          ),
          // backgroundColor: Colors.blue,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white, // Change the drawer icon color to white
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const TimelineElement(
                  icon: Icons.edit,
                  label: 'Basic Input',
                ),
                const TimelineElement(
                  icon: Icons.category,
                  label: 'Categories',
                ),
                GestureDetector(
                  onTap: () async {
                    if(selectedLocations.isNotEmpty) {

                      List<Map> selectedLocationsList = selectedLocations.toList();

                      DocumentSnapshot storedTrips = await _firestore.collection('trips').doc(user.uid).get();

                      if(storedTrips.data() != null){
                        await _firestore.collection('trips').doc(user.uid).update({
                          'trips': FieldValue.arrayUnion([
                            Trip(
                              id: const Uuid().v4(),
                              name: 'Trip ${(storedTrips.data() as Map).length + 1}',
                              destinations: selectedLocationsList,
                              date: Timestamp.now()
                            ).toMap()
                          ])
                        });
                      } else{
                        await _firestore.collection('trips').doc(user.uid).set({
                          'trips': FieldValue.arrayUnion([
                            Trip(
                                id: const Uuid().v4(),
                                name: 'Trip 1',
                                destinations: selectedLocationsList,
                                date: Timestamp.now()
                            ).toMap()
                          ])
                        });
                      }

                      print("Added to db");

                      // for(var location in selectedLocations.toList()){
                      //   context.read<TripModel>().addTrip(Trip(
                      //       name: 'Trip to ${location['location']}',
                      //       destination: location
                      //   ));
                      // }

                      // Navigator.pop(context);
                      // Navigator.pop(context);

                      if(mounted){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Base(initialIndex: 2)),
                              (Route<dynamic> route) => false,
                        );
                      }
                    }
                  },
                  child: const TimelineElement(
                    icon: Icons.done,
                    label: 'Done',
                    selected: true,
                  ),
        ),
              ],
            ),
            const SizedBox(height: 30),
            const Center(child: CustomText(text: "Recommendations", fontSize: 20,)),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: gottenRecommendations ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: gottenRecommendations ? List.generate(recommendations.length, (index) {
                Map location = recommendations[index];

                // print(location['price']['max']);

                return CustomCard(
                  imageUrl: 'https://cscdc.online/travel-images/${location['location'].replaceAll(' ', '-').toLowerCase()}.jpg',
                  destination: location['location'],
                  estimatedAmount: "50",
                  // estimatedAmount: "${location['price']['max']}",
                  selected: selectedLocations.contains(location),
                  onSelectPressed: () {
                    setState(() {
                      if(selectedLocations.contains(location)){
                        selectedLocations.remove(location);
                      } else {
                        selectedLocations.add(location);
                      }
                    });
                  },
                );
              }) : [
                Column(
                  children: [
                    Lottie.asset('assets/recommendation.json', height: 300),
                    const CustomText(text: "Fetching your recommendations!"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
