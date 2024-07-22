import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class IntlField extends StatelessWidget {

  final TextEditingController controller;

  const IntlField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      hintText: '',
      initialValue: PhoneNumber(isoCode: 'GH'),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      cursorColor: Colors.black,
      inputDecoration: InputDecoration(
        label: const Text("Phone", style: TextStyle(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.black)
        ),
      ),
      onInputChanged: (phoneNumber) {
        controller.text = phoneNumber.phoneNumber!;
      },
    );
  }
}
