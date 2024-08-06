import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String senderEmail;
  String receiverId;
  String senderName;
  final String message;
  final Timestamp timeStamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    this.senderName = '',
    required this.message,
    required this.timeStamp
  });

  Map<String, dynamic> toMap () {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'name': senderName,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp
    };
  }
}