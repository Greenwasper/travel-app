import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:febarproject/components/custom_text.dart';
import 'package:febarproject/pages/wheretogo.dart';
import 'package:febarproject/views/contact_us.dart';
import 'package:febarproject/views/settings.dart';
import 'package:febarproject/views/trips.dart';
import 'package:febarproject/views/about_us.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';
import 'chat.dart';
import 'home.dart';

class Base extends StatefulWidget {

  final int initialIndex;

  const Base({super.key, this.initialIndex = 0});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  late int _selectedIndex;
  List<Widget> _pages = [];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    _pages = <Widget>[
      const Home(),
      const Chat(),
      const Trips(),
      const LastMenu()
    ];

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                secondaryColor
              ]
            )
          ),
        ),
        title: const Text("BudgetWise", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 70, bottom: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    secondaryColor
                  ]
                )
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(height: 14),
                  const CustomText(text: 'BudgetWise', fontSize: 24, color: Colors.white),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  _bottomNavigationKey.currentState!.setPage(_selectedIndex);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUs()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Colors.blue,
          //           Colors.purple[800]!
          //         ]
          //       )
          //     ),
          //   ),
          // ),
          CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _selectedIndex,
            height: 60,
            backgroundColor: Colors.transparent,
            color: Colors.blue,
            animationDuration: const Duration(milliseconds: 400),
            buttonBackgroundColor: Colors.white,
            onTap: _onItemTapped,
            items: [
              Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue : Colors.white),
              Icon(Icons.chat, color: _selectedIndex == 1 ? Colors.blue : Colors.white),
              Icon(Icons.map, color: _selectedIndex == 2 ? Colors.blue : Colors.white),
              Icon(Icons.question_mark, color: _selectedIndex == 3 ? Colors.blue : Colors.white),
            ],
          ),
        ],
      )
    );
  }
}
