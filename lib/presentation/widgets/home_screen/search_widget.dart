import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
            ),
            onChanged: (value) {
              // Handle search logic here
            },
          ),
        ),
      ],
    );
  }
}