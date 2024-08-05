import 'package:febarproject/components/trip.dart';
import 'package:flutter/material.dart';

class TripModel extends ChangeNotifier {
  List<Trip> trips = [];

  void addTrip (Trip t){
    trips.add(t);
    notifyListeners();
  }
}