import 'package:flutter/material.dart';

class Category extends StatelessWidget {

  final String title;
  final bool selected;
  final void Function()? onSelectPressed;
  final void Function()? onRemovedPressed;

  const Category({super.key, this.title = "Heading", required this.selected, required this.onSelectPressed, required this.onRemovedPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: selected ? Colors.green : Colors.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                selected ? "$title (Selected)" : title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onRemovedPressed,
                child: const Text('Remove'),
              ),
              ElevatedButton(
                onPressed: onSelectPressed,
                child: const Text('Select'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}