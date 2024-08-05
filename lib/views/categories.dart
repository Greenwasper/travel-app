import 'package:febarproject/views/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:febarproject/components/category.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:febarproject/components/colors.dart';
import 'package:febarproject/views/categories.dart';

import '../components/timeline_element.dart';

class Categories extends StatefulWidget {

  final String region;
  final RangeValues rangeValues;

  const Categories({super.key, required this.rangeValues, required this.region});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<String> categories = [
    'Arts Culture',
    'Beaches',
    'History',
    'Leisure',
    'Luxury',
    'Safari',
    'Shopping',
    'Sightseeing'
  ];

  Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple[800]!
                    ]
                )
            ),
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
        child: Container(
          padding: const EdgeInsets.all(16),
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
                    selected: true,
                  ),
                  TimelineElement(
                    icon: Icons.done,
                    label: 'Done',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const CustomText(text: 'Select your categories', fontSize: 25),
              const SizedBox(height: 20),
              Column(
                children: List.generate(categories.length, (index) {
                  return Category(
                    title: categories[index],
                    selected: selectedCategories.contains(categories[index]),
                    onSelectPressed: () {
                      setState(() {
                        selectedCategories.add(categories[index]);
                      });
                    },
                    onRemovedPressed: () {
                      setState(() {
                        selectedCategories.remove(categories[index]);
                      });
                    },
                  );
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Recommendation(region: widget.region, rangeValues: widget.rangeValues, selectedCategories: selectedCategories)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text("Continue"),
              )
            ]
          ),
        ),
      ),
    );
  }
}
