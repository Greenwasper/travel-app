import 'package:flutter/material.dart';

import 'custom_text.dart';

class EditableField extends StatelessWidget {



  const EditableField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: "First Name", fontSize: 12),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _firstName,
                enabled: isEditingFirstName,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: isEditingFirstName ? const UnderlineInputBorder() : null,
                  focusedBorder: isEditingFirstName ?  const UnderlineInputBorder() : null,
                ),
              ),
            ),
            const SizedBox(width: 10),
            isEditingFirstName ?
            IconButton(
              onPressed: (){
                setState(() {
                  isEditingFirstName = false;
                });
              },
              icon: Icon(Icons.check),
              color: Colors.black,
            ) :
            IconButton(
              onPressed: (){
                setState(() {
                  isEditingFirstName = true;
                });
              },
              icon: Icon(Icons.edit),
              color: Colors.black,
            )
          ],
        )
      ],
    );
  }
}
