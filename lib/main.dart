import 'dart:convert';

import 'package:febarproject/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';

import 'components/functions.dart';
import 'components/location.dart';
import 'components/region.dart';
import 'components/trip_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => TripModel(),
      child: const MyApp(),
    )
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make status bar transparent
    systemNavigationBarColor: Colors.transparent, // Make navigation bar transparent
    systemNavigationBarIconBrightness: Brightness.light, // Ensure icons are visible
    statusBarIconBrightness: Brightness.light, // Ensure icons are visible
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Travel App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AuthPage()
      // home: ChatScreen()
    );
  }
}

