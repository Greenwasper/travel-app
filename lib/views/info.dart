import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/custom_text.dart';
import 'package:travel/components/functions.dart';
import 'package:travel/components/logo.dart';
import 'package:travel/components/whats_new_tile.dart';
import 'package:travel/views/place_page.dart';
import 'package:video_player/video_player.dart';
import 'package:travel/components/menu_link.dart';

class Info extends StatefulWidget {

  final List locations;
  final List regions;

  const Info({super.key, required this.locations, required this.regions});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  late VideoPlayerController _vpController;
  double sliderRatio = 0.9;

  late bool drawerOpened;
  late IconData leadingIcon;

  bool isExpanded = false;

  @override
  void initState() {
    _vpController = VideoPlayerController.asset('assets/home-video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // _vpController.play();
    // _vpController.setLooping(true);

    drawerOpened = false;
    leadingIcon = Icons.menu;

    super.initState();
  }

  @override
  void dispose() {

    _vpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: primaryColor,
        leading: GestureDetector(
          child: Icon(leadingIcon),
          onTap: () {
            setState(() {
              if(drawerOpened){
                drawerOpened = false;
                leadingIcon = Icons.menu;
              }
              else{
                drawerOpened = true;
                leadingIcon = Icons.close;
              }
            });
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Logo(),
                const SizedBox(height: 30),
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _vpController.value.isInitialized ? Stack(
                    children: [
                      VideoPlayer(_vpController),
                      const Center(
                        child: CustomText(text: "Amazing Discoveries", color: Colors.white, fontSize: 30,),
                      )
                    ],
                  ) : Container(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text: "TRAVEL IN LIBERIA AND YOU’LL DISCOVER AN UNCHARTERED TERRITORY", fontSize: 28, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text: "A little-known and largely unexplored haven for adventurers, delivering on all your dreams of being free to discover one of Africa’s last frontiers.", fontSize: 20, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: sliderRatio,
                  child: Swiper(
                    itemCount: whatToDoList.length,
                    itemBuilder: (BuildContext context, int index){
                      return Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: sliderRatio,
                            child: Image.asset("assets/${whatToDoList[index]}.jpg",fit: BoxFit.cover),
                          ),
                          AspectRatio(
                            aspectRatio: sliderRatio,
                            child: Opacity(opacity: 0.5,child: Container(color: Colors.black)),
                          ),
                          Center(
                            child: CustomText(text: whatToDoList[index], color: Colors.white, fontSize: 35,),
                          )
                        ],
                      );
                    },
                    control: SwiperControl(color: primaryColor),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(text: "WHAT'S NEW", fontSize: 30),
                const SizedBox(height: 25),
                const WhatsNewTile(imagePath: 'assets/top10.png', title: "LIBERIA'S 11TH ANNUAL NATIONAL SURF COMPETITION: MAY 3-5, 2024 IN ROBERTSPORT", description: "Liberia is celebrating its 11th Annual Surf Competition from May 3-5, 2024 in Robertsport! Join us to watch Liberia's best surfers and international guests compete."),
                const SizedBox(height: 20),
                const WhatsNewTile(imagePath: 'assets/top10.png', title: "LIBERIA'S 11TH ANNUAL NATIONAL SURF COMPETITION: MAY 3-5, 2024 IN ROBERTSPORT", description: "Liberia is celebrating its 11th Annual Surf Competition from May 3-5, 2024 in Robertsport! Join us to watch Liberia's best surfers and international guests compete."),
                const SizedBox(height: 20),
                const WhatsNewTile(imagePath: 'assets/top10.png', title: "LIBERIA'S 11TH ANNUAL NATIONAL SURF COMPETITION: MAY 3-5, 2024 IN ROBERTSPORT", description: "Liberia is celebrating its 11th Annual Surf Competition from May 3-5, 2024 in Robertsport! Join us to watch Liberia's best surfers and international guests compete."),
                Container(
                  color: secondaryColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline, color: primaryColor,),
                          const SizedBox(width: 10),
                          CustomText(text: "banyanful@gmail.com", color: primaryColor,)
                        ],
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: drawerOpened ? MediaQuery.of(context).size.height : 0,
            color: secondaryColor,
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(),
                      ExpansionTile(
                          title: const CustomText(text: "GHANA TOP TEN", color: Colors.white,),
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          tilePadding: EdgeInsets.zero,
                          expandedAlignment: const Alignment(-0.88,0),
                          children: List.generate(widget.locations.length, (index) {
                            return MenuLink(label: widget.locations[index].name.toUpperCase(), navigateTo: PlacePage(locations: widget.locations, regions: widget.regions, place: widget.locations[index]));
                          })
                      ),
                      ExpansionTile(
                        title: const CustomText(text: "WHERE TO GO", color: Colors.white,),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: const Alignment(-0.88,0),
                        children: List.generate(widget.regions.length, (index) {
                          return MenuLink(label: widget.regions[index].name.toUpperCase(), navigateTo: PlacePage(locations: widget.locations, regions: widget.regions, place: widget.regions[index]));
                        }),
                      ),
                      ExpansionTile(
                        title: const CustomText(text: "WHAT TO DO", color: Colors.white,),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        tilePadding: EdgeInsets.zero,
                        expandedAlignment: const Alignment(-0.88,0),
                        children: List.generate(whatToDoList.length, (index) {
                          return MenuLink(label: whatToDoList[index].toUpperCase(), navigateTo: Info(locations: widget.locations, regions: widget.regions));
                        }),
                      ),
                      const SizedBox(height: 10),
                      MenuLink(label: 'PLAN YOUR TRIP', navigateTo: Info(locations: widget.locations, regions: widget.regions), inExpansionTile: false),
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
