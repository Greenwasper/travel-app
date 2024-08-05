import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:febarproject/components/recommendation_card.dart';
import 'package:lottie/lottie.dart';

import '../components/timeline_element.dart';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Set<Map> recommendationsSet = {};
  List<Map> recommendations = [];

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
            if (location['price']['min'] >= minBudget && maxBudget >= location['price']['max']) { // Price Check
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
            const SizedBox(height: 30),
            const Center(child: CustomText(text: "Recommendations", fontSize: 20,)),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: gottenRecommendations ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: gottenRecommendations ? List.generate(recommendations.length, (index) {
                Map location = recommendations[index];

                return CustomCard(
                  imageUrl: 'https://cscdc.online/travel-images/${location['location'].replaceAll(' ', '-').toLowerCase()}.jpg',
                  destination: location['location'],
                  estimatedAmount: location['price']['max'].toString(),
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
