import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  String? initialValue;
  final List<String> items;
  final void Function(String?)? onChanged;
  final double paddinghorizontal;

  CustomDropdown({
    Key? key,
    required this.labelText,
    this.initialValue,
    required this.items,
    required this.onChanged,
    required this.paddinghorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddinghorizontal),
      child: DropdownButtonFormField<String>(
        value: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: labelText,
          // labelText: labelText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 156, 156, 156),
          ),
          border: OutlineInputBorder(),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
