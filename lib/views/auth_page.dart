import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel/views/base.dart';
import 'package:travel/views/login.dart';

class AuthPage extends StatelessWidget {

  final List locations;
  final List regions;
  
  const AuthPage({super.key, required this.locations, required this.regions});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Base(locations: locations, regions: regions);
        } else {
          return Login(locations: locations, regions: regions);
        }
      },
    );
  }
}
