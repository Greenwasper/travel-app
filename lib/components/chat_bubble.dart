import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';


class ChatBubble extends StatelessWidget {

  final String message;
  final bool isSender;
  final Timestamp timeStamp;

  const ChatBubble({super.key, required this.message, required this.isSender, required this.timeStamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [
              Colors.blue,
              isSender? Colors.purple[800]! : Colors.blue
            ]
        )
      ),
      child: Column(
        crossAxisAlignment: isSender? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          CustomText(text: message, color: Colors.white, fontSize: 18),
          const SizedBox(height: 5),
          CustomText(text: "${timeStamp.toDate().hour}:${timeStamp.toDate().minute}", color: Colors.white, fontSize: 12),
        ],
      ),
    );
  }
}
