import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../components/colors.dart';
import '../components/custom_text.dart';
import '../components/form_field.dart';
import '../components/loader.dart';
import '../components/password_field.dart';


class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool passwordObscured = true;

  void register () async {
    bool isError = false;
    // UserCredential? userCredentials;

    setState(() {
      isLoading = true;
    });

    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim()
      );

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': _username.text,
        'firstname': _firstName.text,
        'lastnamename': _lastName.text,
        'country': '',
        'phonenumber': _phoneNumber.text,
        'activeproposals': '',
        'archivedinterviews': '',
        'archivedproposals': '',
        'availablebalance': '',
        'offers': '',
        'pendingbalance': '',
        'submittedproposals': '',
        'email': userCredential.user!.email
      });

      isError = false;

      if(mounted){
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      isError = true;
      setState(() {
        isLoading = false;
      });

      print(e.code);

      // if (e.code == 'invalid-email') {
      //   // Invalid email format, remember to trim
      //   toast("Invalid Email Format");
      // } else if (e.code == 'invalid-credential') {
      //   // Incorrect email or password
      //   toast("Incorrect Email or Password");
      // }
    }

    if(!isError){
      // FirebaseFirestore.instance.collection('users').doc(userCredentials!.user!.uid).set({
      //   'uid': userCredentials.user!.uid,
      //   'email': userCredentials.user!.email,
      //   'first_name': _firstName.text,
      //   'last_name': _lastName.text,
      //   'user_name': _username.text
      // });
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
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -30,
                  child: Image.asset('assets/edge2.png', fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: -65,
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
                              const SizedBox(height: 10),
                              const CustomText(text: "Register", fontSize: 31, color: Colors.blue),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Field(
                                      controller: _firstName,
                                      labelText: "First Name",
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Expanded(
                                      child: Field(
                                        controller: _lastName,
                                        labelText: "Last Name",
                                      ),
                                    ),
                                  )
                                ]
                              ),
                              const SizedBox(height: 20),
                              Field(
                                controller: _username,
                                labelText: "Username",
                                textInputType: TextInputType.name,
                              ),

                              const SizedBox(height: 20),

                              Field(
                                controller: _email,
                                labelText: "Email",
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20),
                              // IntlField(controller: _phoneNumber),
                              // const SizedBox(height: 20),
                              PasswordField(
                                controller: _password,
                                passwordObscured: passwordObscured,
                                setPasswordObscured: setPasswordObscured,
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  register();
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
                                      child: CustomText(text: "Register", color: Colors.white, fontSize: 17),
                                    )
                                ),
                              ),
                            ]
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
