import 'package:flutter/material.dart';

Widget button({
  required String buttonText,
  required void Function() buttonPressed,
  Color? color,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
        onPressed: buttonPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        )),
  );
}
