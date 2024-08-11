import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:febarproject/components/colors.dart';
import 'package:febarproject/components/functions.dart';
import 'package:febarproject/components/trip.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'custom_text.dart';


class ChatBubble extends StatelessWidget {

  final String message;
  final bool isSender;
  final bool inCommunity;
  final String communityName;
  final Timestamp timeStamp;
  final Map tripMap;
  final String senderUid;

  const ChatBubble({super.key, required this.message, required this.isSender, required this.timeStamp, this.inCommunity = false, this.communityName = '', this.tripMap = const {}, this.senderUid = ''});

  @override
  Widget build(BuildContext context) {

    Trip trip = Trip(
        id: '',
        name: '',
        destinations: [],
        date: Timestamp.now()
    );

    if(tripMap.isNotEmpty){
      trip = Trip(
          id: tripMap['id'],
          name: tripMap['name'],
          destinations: tripMap['destination'],
          date: tripMap['date']
      );
    }

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
          tripMap.isNotEmpty ? TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Trip'),
                    content: Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: CustomText(text: trip.name, fontSize: 17)),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(trip.destinations.length, (index) {
                                Map destination = trip.destinations[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: "Destination: ${destination['location']}"),
                                      CustomText(text: "Price: ${destination['price']['max']}"),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            Row(
                              children: [
                                const CustomText(text: "Trip Date:"),
                                const SizedBox(width: 10),
                                CustomText(text: formatDate(trip.date.toDate()))
                              ],
                            ),
                          ]
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          DocumentSnapshot storedTrips = await FirebaseFirestore.instance.collection('trips').doc(senderUid).get();

                          if(storedTrips.data() != null){
                            await FirebaseFirestore.instance.collection('trips').doc(senderUid).update({
                              'trips': FieldValue.arrayUnion([
                                trip.toMap()
                              ])
                            });
                          } else{
                            await FirebaseFirestore.instance.collection('trips').doc(senderUid).set({
                              'trips': FieldValue.arrayUnion([
                                trip.toMap()
                              ])
                            });
                          }

                          toast("Added Trip");

                        },
                        child: const Text('Add', style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white
            ),
            child: const Text("View Trip"),
          ) : const SizedBox(height: 0),
          CustomText(text: formatDateFull(timeStamp.toDate()), color: Colors.white, fontSize: 11),
        ],
      ),
    );
  }
}
