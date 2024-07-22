import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/form_field.dart';
import 'package:travel/components/functions.dart';

import '../components/loader.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool passwordObscured = false;

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    Uri url = Uri.parse('https://cscdc.online/apis/travel_app_register.php');

    String res = '';

    Map<String, String> body = {
      'first_name': _firstName.text,
      'last_name': _lastName.text,
      'email': _email.text,
      'phone_number': _phoneNumber.text,
      'password': _password.text
    };

    try{
      http.Response response = await http.post(url, body: body).timeout(const Duration(seconds: 10));
      res = json.decode(response.body)[0];
    } catch (e) {
      print(e);
    }

    if (res == 'success') {
      if(mounted){
        toast("Saved");
        Navigator.pop(context);
      }
    } else {
      toast("An error occurred");
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
                  child: CustomText(text: 'Register', color: Colors.white, fontSize: 40),
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
                              controller: _email,
                              labelText: "Email",
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () async {
                                await register();
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Base(locations: widget.locations, regions: widget.regions)));
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
                                    child: CustomText(text: "REGISTER", color: Colors.white, fontSize: 20),
                                  )
                              ),
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
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
