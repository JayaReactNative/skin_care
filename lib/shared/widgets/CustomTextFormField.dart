import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final VoidCallback onTap;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool obscureText; // Added obscureText parameter
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final bool autoValidate;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.onTap,
    required this.keyboardType,
    required this.readOnly,
    this.obscureText = false, // Made obscureText parameter optional and default to false
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.autoValidate = false, // Added autoValidate parameter with default value false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      autovalidateMode: autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      obscureText: obscureText, // Set obscureText property of the TextFormField
      decoration: InputDecoration(
        hintText: hintText,
        hintFadeDuration: Duration(seconds: 8),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        hintStyle: TextStyle(
            fontFamily: 'Poppins Regular',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xffA5A5A5)
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffE3E3E3))
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon, // Added prefixIcon to the InputDecoration
      ),
    );
  }
}
