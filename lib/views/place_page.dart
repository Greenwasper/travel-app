import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/logo.dart';
import 'package:travel/views/base.dart';
import 'package:travel/components/location.dart';
import 'package:travel/components/custom_text.dart';

class PlacePage extends StatefulWidget {
  final List locations;
  final List regions;

  final dynamic place;

  const PlacePage({super.key, required this.place, required this.locations, required this.regions});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {

  double imageRatio = 16 / 9;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(child: Logo()),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: imageRatio,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: imageRatio,
                    child: Image.network(widget.place.mainImagePath, fit: BoxFit.cover),
                  ),
                  AspectRatio(
                    aspectRatio: imageRatio,
                    child: Opacity(opacity: 0.5, child: Container(color: Colors.black,)),
                  ),
                  Center(
                    child: Text(widget.place.name, style: const TextStyle(color: Colors.white, fontSize: 40), textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: widget.place.name, fontSize: 30),
                  const SizedBox(height: 15),
                  CustomText(text: widget.place.description, fontSize: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(widget.place.imagePaths.length, (index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: AspectRatio(
                    aspectRatio: imageRatio,
                    child: Image.network(widget.place.imagePaths[index], fit: BoxFit.cover),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
