import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    required this.labletext,
    required this.validater,
    // required this.initialValue,
    // this.maxlength,

    required this.controller,
    this.readOnly = false,
  });
  String labletext;
  // String initialValue;
  // int? maxlength;
  bool readOnly;
  Function(String value) validater;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        // maxLength: maxlength,
        // initialValue: initialValue,
        validator: (value) => validater(value!),
        decoration: InputDecoration(
          labelText: labletext,
          labelStyle: TextStyle(
              fontSize: 15, color: Color.fromARGB(255, 156, 156, 156)),
        ),
      ),
    );
  }
}
