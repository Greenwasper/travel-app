import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/category.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/views/categories.dart';

import '../components/timeline_element.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

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
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              CustomText(text: 'Select your categories', fontSize: 25),
              SizedBox(height: 20),
              Category(),
              Category(),
              Category(),
              Category(),
              Category(),
              Category(),
              Category(),
            ]
          ),
        ),
      ),
    );
  }
}
