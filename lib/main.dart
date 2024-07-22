import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel/components/functions.dart';
import 'package:http/http.dart' as http;
import 'package:travel/components/location.dart';
import 'package:travel/components/region.dart';
import 'package:travel/views/auth_page.dart';
import 'package:travel/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel/views/test.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  Uri url = Uri.parse('https://cscdc.online/apis/travel_app_data.php');
  List data = [[], []];

  try{
    http.Response response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'}).timeout(const Duration(seconds: 15));
    data = json.decode(response.body);
  } catch (e) {
    print(e);
  }

  List locationsFromDB = data[0];
  List regionsFromDB = data[1];

  List<Location> locations = [];
  List regions = [];

  for(var location in locationsFromDB){

    String label = location['label'];
    int imageNumber = int.parse(location['imageNumber']);

    String mainImagePath = "$imagePathUrl/locations/$label/$label-main.jpg";

    List<String> imagePaths = [];

    for(int i=1;i<=imageNumber;i++){
      imagePaths.add("$imagePathUrl/locations/$label/$label-$i.jpg");
    }

    locations.add(Location(
      name: location['name'],
      label: label,
      description: location['description'],
      mainImagePath: mainImagePath,
      imagePaths: imagePaths
    ));
  }

  for(var region in regionsFromDB){

    String label = region['label'];
    int imageNumber = int.parse(region['imageNumber']);

    String mainImagePath = "$imagePathUrl/regions/$label/$label-main.jpg";

    List<String> imagePaths = [];

    for(int i=1;i<=imageNumber;i++){
      imagePaths.add("$imagePathUrl/regions/$label/$label-$i.jpg");
    }

    regions.add(Region(
        name: region['name'],
        label: label,
        description: region['description'],
        mainImagePath: mainImagePath,
        imagePaths: imagePaths
    ));
  }

  runApp(MyApp(locations: locations, regions: regions));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make status bar transparent
    systemNavigationBarColor: Colors.transparent, // Make navigation bar transparent
    systemNavigationBarIconBrightness: Brightness.light, // Ensure icons are visible
    statusBarIconBrightness: Brightness.light, // Ensure icons are visible
  ));
}

class MyApp extends StatelessWidget {

  final List locations;
  final List regions;

  const MyApp({super.key, required this.locations, required this.regions});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AuthPage(locations: locations, regions: regions)
      // home: ChatScreen()
    );
  }
}

