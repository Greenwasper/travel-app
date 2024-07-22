import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/functions.dart';
import 'package:travel/views/chat.dart';
import 'package:travel/views/home.dart';
import 'package:travel/views/place_page.dart';
import 'package:travel/views/plan.dart';
import 'package:travel/views/settings.dart';
import 'package:travel/views/info.dart';
import 'package:travel/views/login_old.dart';

import '../components/menu_link.dart';

class Base extends StatefulWidget {

  final List locations;
  final List regions;

  const Base({super.key, required this.locations, required this.regions});

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
      Info(locations: widget.locations, regions: widget.regions),
      Info(locations: widget.locations, regions: widget.regions),
    ];

    super.initState();
  }

  void _onItemTapped(int index) {
    if(index != 4){
      setState(() {
        _selectedIndex = index;
      });
    } else {
      showInfo(context);
    }
  }

  void showInfo (BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const CustomText(text: "Ghana Top Ten", fontSize: 17),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.yellow.shade800,
                    child: const Icon(Icons.plus_one, color: Colors.white),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: List.generate(widget.locations.length, (index) {
                    return MenuLink(label: widget.locations[index].name, navigateTo: PlacePage(locations: widget.locations, regions: widget.regions, place: widget.locations[index]));
                  })
                ),
                ExpansionTile(
                  title: const CustomText(text: "Where To Go", fontSize: 17),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.map_outlined, color: Colors.white),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: List.generate(widget.regions.length, (index) {
                    return MenuLink(label: widget.regions[index].name, navigateTo: PlacePage(locations: widget.locations, regions: widget.regions, place: widget.regions[index]));
                  })
                ),
                ExpansionTile(
                  title: const CustomText(text: "What To Do", fontSize: 17),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.accessibility, color: Colors.white),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: List.generate(whatToDoList.length, (index) {
                    return MenuLink(label: whatToDoList[index], navigateTo: Info(locations: widget.locations, regions: widget.regions));
                  }),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.newspaper_outlined, color: Colors.white),
                        ),
                        SizedBox(width: 17),
                        CustomText(text: "What New", fontSize: 17)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    ).then((value){
      _bottomNavigationKey.currentState!.setPage(_selectedIndex);
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
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
                // Handle the Home tap here
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle the Settings tap here
                Navigator.pop(context); // Close the drawer
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
      body: Stack(
        children: [
          _pages[_selectedIndex],
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Container(
          //     color: Colors.white,
          //     width: MediaQuery.of(context).size.width,
          //     height: 200,
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: [
          //           ExpansionTile(
          //             leading: Icon(Icons.notifications),
          //             title: Text("qido"),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
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
              Icon(Icons.bookmark, color: _selectedIndex == 2 ? Colors.blue : Colors.white),
              Icon(Icons.question_mark, color: _selectedIndex == 3 ? Colors.blue : Colors.white),
            ],
          ),
        ],
      )
    );
  }
}
