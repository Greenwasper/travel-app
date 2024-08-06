import 'package:febarproject/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:febarproject/components/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Contact Us", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
        ),
        // backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [primaryColor, secondaryColor])
                  ),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.3,
                        child: SvgPicture.asset('assets/contact.svg'),
                      ),
                      const SizedBox(height: 30),
                      // CustomText(text: "Get in touch!", fontSize: 25, color: Colors.white,)
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [primaryColor, secondaryColor])
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const CustomText(text: "GET IN TOUCH!", fontSize: 25),
                          const SizedBox(height: 5),
                          const CustomText(text: "If you have any questions feel free to ask!", fontSize: 15),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              labelText: 'Message',
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final name = _nameController.text;
                                final email = _emailController.text;
                                final message = _messageController.text;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Thank You'),
                                      content: Text('Your message has been sent!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                // Optionally, clear the fields
                                _nameController.clear();
                                _emailController.clear();
                                _messageController.clear();
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 100,
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
                                child: CustomText(text: "Send", color: Colors.white, fontSize: 17),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
