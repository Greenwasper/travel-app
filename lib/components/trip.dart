import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Trip {
  String id;
  String name;
  Map destination;
  Timestamp date;

  Trip({required this.name, required this.destination, required this.date, required this.id});

  Map toMap () {
    return {
      'id': id,
      'name': name,
      'destination': destination,
      'date': date
    };
  }
}