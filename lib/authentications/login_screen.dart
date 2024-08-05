import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _countryController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _activeproposalsController = TextEditingController();
  final _archivedinterviewsController = TextEditingController();
  final _archivedproposalsController = TextEditingController();
  final _availablebalanceController = TextEditingController();
  final _offersController = TextEditingController();
  final _pendingbalanceController = TextEditingController();
  final _submittedproposalsController = TextEditingController();
  bool _isSignup = false;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    _countryController.dispose();
    _phonenumberController.dispose();
    _activeproposalsController.dispose();
    _archivedinterviewsController.dispose();
    _archivedproposalsController.dispose();
    _availablebalanceController.dispose();
    _offersController.dispose();
    _pendingbalanceController.dispose();
    _submittedproposalsController.dispose();
  }

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      }, SetOptions(merge: true));
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Container(),
      //   ),
      // );
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': _usernameController.text,
        'firstname': _firstnameController.text,
        'lastnamename': _lastnameController.text,
        'country': _countryController.text,
        'phonenumber': _phonenumberController.text,
        'activeproposals': _activeproposalsController.text,
        'archivedinterviews': _archivedinterviewsController.text,
        'archivedproposals': _archivedproposalsController.text,
        'availablebalance': _availablebalanceController.text,
        'offers': _offersController.text,
        'pendingbalance': _pendingbalanceController.text,
        'submittedproposals': _submittedproposalsController.text,
        'email': userCredential.user!.email
      });
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Container(),
      //   ),
      // );
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignup ? 'Sign Up' : 'Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              if (_isSignup)
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              if (_isSignup)

              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              if (_isSignup)

              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(labelText: 'Firstname'),
              ),
              if (_isSignup)

              TextField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              if (_isSignup)

              TextField(
                controller: _phonenumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              if (_isSignup)
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSignup ? _signUp : _signIn,
                child: Text(_isSignup ? 'Sign Up' : 'Login'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignup = !_isSignup;
                  });
                },
                child: Text(_isSignup ? 'Already have an account? Login' : 'Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
