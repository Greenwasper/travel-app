import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_text.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  List<TextEditingController> nameControllers = [
    TextEditingController(text: "inqdi"),
    TextEditingController(text: ""),
    TextEditingController(text: ""),
  ];
  List<TextEditingController> emailControllers = [
    TextEditingController(text: ""),
    TextEditingController(text: ""),
    TextEditingController(text: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              CustomText(text: "Group Name", fontSize: 20),
              TextFormField(),
              SizedBox(height: 50),
              CustomText(text: "Add Members", fontSize: 20),
              Column(
                children: List.generate(nameControllers.length, (index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameControllers[index],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextFormField(
                          controller: emailControllers[index],
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            nameControllers.removeAt(index);
                            emailControllers.removeAt(index);
                          });
                        },
                      )
                    ],
                  );
                }),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(

                ),
                onPressed: () {
                  setState(() {
                    nameControllers.add(TextEditingController());
                    emailControllers.add(TextEditingController());
                  });
                },
                child: CustomText(text: "Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
