import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String imagePathUrl = "https://cscdc.online/travel-images";

Map<String, String> whatToDoMap = {
  'sightseeing': 'sightseeing.png',
  'beaches': 'beaches.png',
  'vacation': 'vacation.png',
  'touring': 'touring.png'
};

List<String> whatToDoList = ['Sightseeing', 'Beaches', 'Vacation', 'Touring'];

void toast (msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey.shade800,
    textColor: Colors.white,
    fontSize: 16.0
  );
}