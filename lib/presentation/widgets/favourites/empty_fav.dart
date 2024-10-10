import 'package:flutter/material.dart';

class EmptyFavoutites extends StatelessWidget {
  const EmptyFavoutites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/favourites.png',
           
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20 ),
          const Text(
              "Keep track of the products you are interested in by clicking ❤️"),           
        ],
      ),
    );
  }
}