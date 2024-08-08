import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:febarproject/components/recommendation_card.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import '../components/colors.dart';
import '../components/timeline_element.dart';
import '../components/trip.dart';
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
  double totalPrice = 0;

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

    // print(allLocations[0]);

    for(Map location in allLocations) {
      if (location['region'] == selectedRegion) { // Region Check
        for (var selectedCategory in selectedCategories.toList()) {
          if (location[selectedCategory.toLowerCase()] == 'Y') { // Category Check
            if (location['price']['min'].toDouble() >= minBudget && maxBudget >= location['price']['max'].toDouble()) { // Price Check
              recommendationsSet.add(location);
            }
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimelineElement(
                  icon: Icons.edit,
                  label: 'Basic Input',
                ),
                TimelineElement(
                  icon: Icons.category,
                  label: 'Categories',
                ),
                TimelineElement(
                  icon: Icons.done,
                  label: 'Done',
                  selected: true,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Center(child: CustomText(text: "Recommendations", fontSize: 25)),
            const SizedBox(height: 1),
            Center(child: CustomText(text: "Your Budget: ${widget.rangeValues.end}", fontSize: 17)),
            const SizedBox(height: 1),
            Center(child: CustomText(text: "Selected Destinations Price: $totalPrice", fontSize: 17)),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: gottenRecommendations ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: gottenRecommendations ? List.generate(recommendations.length, (index) {
                Map location = recommendations[index];

                // print(location['price']['max']);

                return CustomCard(
                  imageUrl: 'https://cscdc.online/travel-images/${location['location'].replaceAll(' ', '-').toLowerCase()}.jpg',
                  destination: location['location'],
                  // estimatedAmount: "50",
                  estimatedAmount: "${location['price']['max']}",
                  selected: selectedLocations.contains(location),
                  onSelectPressed: () async {
                    totalPrice = 0;

                    if(selectedLocations.contains(location)){
                      selectedLocations.remove(location);
                    } else {
                      selectedLocations.add(location);
                    }
                    totalPrice = selectedLocations.fold(0.0, (acc, item) {
                      return acc + (item['price']['max']);
                    });

                    if(totalPrice > widget.rangeValues.end){
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Be Careful!', style: TextStyle(color: Colors.red.shade300)),
                            content: const Text('The selected trips have passed your expected budget! Make sure you cut your coat according to your size!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();  // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      totalPrice = 0;

                      selectedLocations.remove(location);

                      totalPrice = selectedLocations.fold(0.0, (acc, item) {
                        return acc + (item['price']['max']);
                      });
                    }

                    setState(() {

                    });
                  },
                );
              }) : [
                Column(
                  children: [
                    Lottie.asset('assets/recommendation.json', height: 300),
                    const CustomText(text: "Fetching your recommendations!", fontSize: 18),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: gottenRecommendations && selectedLocations.isNotEmpty,
              child: ElevatedButton(
                onPressed: () async {
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

                    if(mounted){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Base(initialIndex: 2)),
                            (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
