import 'package:febarproject/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../components/trip.dart';
import '../components/trip_model.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();

    for(var controller in controllers.entries){
      controller.value.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripModel>(
      builder: (context, value, child) {

        for(var trip in value.trips){
          controllers[trip.destination['location']] = TextEditingController();
        }

        return value.trips.isEmpty ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/empty.json', controller: _animationController),
              const SizedBox(height: 20),
              const CustomText(text: "You haven't planned any trips", fontSize: 17,),
            ],
          ),
        ):
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomText(text: "Your Trips", fontSize: 25),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(value.trips.length, (index) {
                    Trip trip = value.trips[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.blue, width: 3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: CustomText(text: trip.name, fontSize: 17)),
                            const SizedBox(height: 10),
                            CustomText(text: "Destination: ${trip.destination['location']}"),
                            CustomText(text: "Price: ${trip.destination['price']['max']}"),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const CustomText(text: "Trip Date:"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: controllers[trip.destination['location']],
                                    decoration: const InputDecoration(
                                      hintText: 'Enter trip date',
                                      border: UnderlineInputBorder(),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2024),
                                        lastDate: DateTime(2026),
                                      );
                                      if (date != null) {
                                        print("${date.day.toString()}/${date.month.toString()}/${date.year.toString()}");
                                        setState(() {
                                          controllers[trip.destination['location']]!.text = "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ]
                      ),
                    );
                  }),
                )
              ]
            ),
          ),
        );
      },
    );
  }
}
