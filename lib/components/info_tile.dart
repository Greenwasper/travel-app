import 'package:flutter/material.dart';

import 'custom_text.dart';

class InfoTile extends StatelessWidget {

  final String label;
  final IconData icon;
  final Color iconBackgroundColor;

  const InfoTile({super.key, required this.label, this.icon = Icons.location_on, this.iconBackgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: iconBackgroundColor,
                child: Icon(icon, color: Colors.white)
              ),
              const SizedBox(width: 15),
              CustomText(text: label, fontSize: 20),
            ],
          ),
        ],
      ),
    );
  }
}
