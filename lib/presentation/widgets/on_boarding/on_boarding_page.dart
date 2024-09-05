import 'package:clothing/core/constants/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, 
    required this.title, 
    required this.subTitle, 
    required this.image,
    required this.pageIndex,
    required this.context
  });

  final String title,subTitle,image;
  final int pageIndex;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding,
      child: Column(
        
        children: [
          Image(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            image: AssetImage(image)
          ),
          Text(title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          defaultHeight,
          Text(subTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}