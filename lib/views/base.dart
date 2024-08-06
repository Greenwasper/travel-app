
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:febarproject/pages/wheretogo.dart';
import 'package:febarproject/views/place_page.dart';
import 'package:febarproject/views/settings.dart';
import 'package:febarproject/views/trips.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';
import '../components/custom_text.dart';
import '../components/functions.dart';
import '../components/menu_link.dart';
import 'chat.dart';
import 'home.dart';
import 'info.dart';

class Base extends StatefulWidget {

  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  int _selectedIndex = 0;
  List<Widget> _pages = [];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _pages = <Widget>[
      Home(),
      Chat(),
      Trips(),
      LastMenu()
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple[800]!
                ]
              )
            ),
          ),
          // backgroundColor: Colors.blue,
          title: const Text("TravelApp", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white, // Change the drawer icon color to white
          ),
          elevation: 0,
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.person, color: Colors.white),
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
          //     },
          //   )
          // ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  _bottomNavigationKey.currentState!.setPage(_selectedIndex);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact Us'),
              onTap: () {
                // Handle the Contact Us tap here
                Navigator.pop(context); // Close the drawer
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
