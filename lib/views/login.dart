import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/form_field.dart';
import 'package:travel/components/intl_field.dart';
import 'package:travel/components/loader.dart';
import 'package:travel/views/register.dart';
import 'package:travel/views/base.dart';
import 'package:travel/components/functions.dart';
import 'package:travel/components/password_field.dart';

class Login extends StatefulWidget {

  final List locations;
  final List regions;

  const Login({super.key, required this.locations, required this.regions});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passwordObscured = true;

  void login () async {
    bool isError = false;
    UserCredential? userCredentials;

    setState(() {
      isLoading = true;
    });

    try {
      userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text
      );
    } on FirebaseAuthException catch (e) {
      isError = true;
      setState(() {
        isLoading = false;
      });

      print(e.code);

      if (e.code == 'invalid-email') {
        // Invalid email format, remember to trim
        toast("Invalid Email Format");
      } else if (e.code == 'invalid-credential') {
        // Incorrect email or password
        toast("Incorrect Email or Password");
      }
    }

    if(!isError){
      FirebaseFirestore.instance.collection('users').doc(userCredentials!.user!.uid).set({
        'uid': userCredentials.user!.uid,
        'email': userCredentials.user!.email,
        'first_name': 'Default First Name',
        'last_name': 'Default Last Name'
      }, SetOptions(merge: true));
    }
  }

  void setPasswordObscured () {
    if(passwordObscured){
      setState(() {
        passwordObscured = false;
      });
    } else {
      setState(() {
        passwordObscured = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                child: Image.asset('assets/edge2.png', fit: BoxFit.cover),
              ),
              Positioned(
                bottom: -40,
                child: Image.asset('assets/edge.png', fit: BoxFit.cover),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const CustomText(text: "Login", fontSize: 31, color: Colors.blue),
                        const SizedBox(height: 30),
                        // IntlField(controller: _phoneNumber),
                        Field(
                          controller: _email,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Email",
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          controller: _password,
                          passwordObscured: passwordObscured,
                          setPasswordObscured: setPasswordObscured,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            login();
                          },
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                gradient: LinearGradient(
                                    colors: [
                                      primaryColor,
                                      secondaryColor
                                    ]
                                )
                            ),
                            child: const Center(
                              child: CustomText(text: "Login", color: Colors.white, fontSize: 17),
                            )
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText(text: "Don't have an account?"),
                            ),
                            Expanded(
                              child: Divider(),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: const BorderSide(color: Colors.grey, width: 2.0),
                              ),
                            ),
                            child: const CustomText(text: "Sign Up", fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  )
                )
              ),
            ],
          ),
          isLoading ? const Loader() : const SizedBox(height: 0)
        ],
      )
    );
  }
}
