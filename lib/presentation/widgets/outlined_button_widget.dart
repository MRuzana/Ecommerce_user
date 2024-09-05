import 'package:flutter/material.dart';

Widget outlinedButton({
  required String buttonText,
  required void Function() buttonPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
        onPressed: buttonPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black),
        )),
  );
}
