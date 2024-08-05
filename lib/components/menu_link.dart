import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'custom_text.dart';

class MenuLink extends StatelessWidget {

  final bool inExpansionTile;
  final String label;
  final Widget navigateTo;

  const MenuLink({super.key, required this.label, required this.navigateTo, this.inExpansionTile = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: inExpansionTile ? const EdgeInsets.only(left: 25, top: 15, bottom: 15) : EdgeInsets.zero,
                child: CustomText(text: label, fontSize: 16),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => navigateTo));
        },
      ),
    );
  }
}
