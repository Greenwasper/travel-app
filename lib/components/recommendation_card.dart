import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final bool selected;
  final String imageUrl;
  final String destination;
  final String estimatedAmount;
  final void Function() onSelectPressed;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.destination,
    required this.estimatedAmount,
    required this.selected,
    required this.onSelectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: selected ? Colors.blue[100] : Colors.blue[70],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              errorBuilder: (context, error, stackTrace) {
                // return Image.asset('assets/default-recommendation.jpg');
                return const SizedBox(width: 0);
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.cloud,
                      color: Colors.yellow,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Destination: $destination",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Estimated Amount: $estimatedAmount",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onSelectPressed();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue,
                    ),
                    child: !selected ? const Center(
                      child: Text(
                        "ADD TO CALENDAR",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ) : Icon(Icons.check, color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
