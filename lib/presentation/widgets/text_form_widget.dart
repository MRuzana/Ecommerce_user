import 'package:flutter/material.dart';

Widget textField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
  required Widget prefixIcon,
  Widget? suffixIcon,
  bool isObscured = false,
  

}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isObscured,
    decoration: InputDecoration(
      border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ),
    validator: validator,
    autovalidateMode: autovalidateMode, 
  );
}
