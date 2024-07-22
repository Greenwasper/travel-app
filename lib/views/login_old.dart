import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/loader.dart';
import 'package:travel/views/register_old.dart';
import 'package:travel/views/base.dart';
import 'package:travel/components/functions.dart';

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
  final TextEditingController _password = TextEditingController();
  bool passwordObscured = true;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse('https://cscdc.online/apis/travel_app_login.php');

    List res = [];

    Map<String, String> body = {
      'phone_number': _phoneNumber.text,
      'password': _password.text
    };

    try{
      http.Response response = await http.post(url, body: body).timeout(const Duration(seconds: 10));
      res = json.decode(response.body);
      if (res.isNotEmpty) {
        if(mounted){
          toast("Logged In");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base(locations: widget.locations, regions: widget.regions)));
        }
      } else {
        toast("Invalid Credentials");
      }
    } catch (e) {
      print(e);
      toast('An error occurred');
    }

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.purple[800]!
                        ]
                    )
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 70, left: 20),
                  child: CustomText(text: 'Welcome', color: Colors.white, fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 120),
                        Column(
                          children: [
                            InternationalPhoneNumberInput(
                              hintText: '',
                              initialValue: PhoneNumber(isoCode: 'GH'),
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              cursorColor: Colors.black,
                              inputDecoration: const InputDecoration(
                                label: Text("Phone", style: TextStyle(color: Colors.black)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                              ),
                              onInputChanged: (phoneNumber) {
                                _phoneNumber.text = phoneNumber.phoneNumber!;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _password,
                              obscureText: passwordObscured,
                              autocorrect: false,
                              enableSuggestions: false,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                    onPressed: () {
                                      if(passwordObscured){
                                        setState(() {
                                          passwordObscured = false;
                                        });
                                      } else {
                                        setState(() {
                                          passwordObscured = true;
                                        });
                                      }
                                    },
                                    icon: Icon(passwordObscured ? Icons.visibility_off : Icons.visibility, size: 20,)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                label: const Text("Password", style: TextStyle(color: Colors.black)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const CustomText(text: "Forgot Password?", fontSize: 16,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                await login();
                              },
                              child: Container(
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.purple[800]!
                                          ]
                                      )
                                  ),
                                  child: const Center(
                                    child: CustomText(text: "SIGN IN", color: Colors.white, fontSize: 20),
                                  )
                              ),
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomText(text: "Don't have an account?", fontSize: 16),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                  ),
                                ),
                                child: const CustomText(text: "Sign Up", fontSize: 17),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          isLoading ? const Loader() : const SizedBox(height: 0)
        ],
      ),
    );
  }
}
