import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/colors.dart';
import 'package:febarproject/components/functions.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';


class ChatBubble extends StatelessWidget {

  final String message;
  final bool isSender;
  final bool inCommunity;
  final String communityName;
  final Timestamp timeStamp;

  const ChatBubble({super.key, required this.message, required this.isSender, required this.timeStamp, this.inCommunity = false, this.communityName = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            isSender ? primaryColor : Colors.blue.shade400,
            isSender ? secondaryColor : Colors.blue.shade400
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: isSender? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          inCommunity ? !isSender ? Column(
            children: [
              CustomText(text: communityName, color: secondaryColor, fontSize: 15, fontWeight: FontWeight.bold),
              const SizedBox(height: 6)
            ],
          ) : const SizedBox(height: 0) : const SizedBox(height: 0),
          Container(
            padding: inCommunity ? !isSender ? const EdgeInsets.all(10) : null : null,
            decoration: BoxDecoration(
              border: inCommunity ? !isSender ? const Border(
                top: BorderSide(color: Colors.white),
                left: BorderSide(color: Colors.white, width: 3),
                bottom: BorderSide(color: Colors.white),
                right: BorderSide(color: Colors.white, width: 3)
              ) : null : null
            ),
            child: CustomText(text: message, color: Colors.white, fontSize: 18)
          ),
          const SizedBox(height: 5),
          CustomText(text: formatDateFull(timeStamp.toDate()), color: Colors.white, fontSize: 11),
        ],
      ),
    );
  }
}
