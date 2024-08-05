import 'package:flutter/material.dart';

import 'custom_text.dart';

class TimelineElement extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const TimelineElement({super.key, required this.icon, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade100 : Colors.transparent,
        // color: selected ? Colors.blue.shade500 : Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: selected ? Colors.black : Colors.black),
          // Icon(icon, size: 30, color: selected ? Colors.white : Colors.black),
          const SizedBox(height: 10),
          CustomText(text: label, color: selected ? Colors.black : Colors.black),
          // CustomText(text: label, color: selected ? Colors.white : Colors.black),
        ],
      ),
    );
  }
}