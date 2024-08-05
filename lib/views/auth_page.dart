import 'package:febarproject/authentications/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'base.dart';
import 'login.dart';

class AuthPage extends StatelessWidget {
  
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Base();
        } else {
          // return Login(locations: locations, regions: regions);
          return LoginScreen();
        }
      },
    );
  }
}
