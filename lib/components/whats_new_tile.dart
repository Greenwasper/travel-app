import 'package:flutter/material.dart';

import 'custom_text.dart';


class WhatsNewTile extends StatelessWidget {

  final String imagePath;
  final String title;
  final String description;

  const WhatsNewTile({super.key, required this.imagePath, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          CustomText(text: title, fontSize: 24),
          const SizedBox(height: 20),
          CustomText(text: description, fontSize: 20),
        ],
      ),
    );
  }
}
