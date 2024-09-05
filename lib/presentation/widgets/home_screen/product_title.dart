import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
    );
  }
}