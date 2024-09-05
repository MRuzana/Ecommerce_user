import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
     bottom: kBottomNavigationBarHeight + 80,
    
      child: SmoothPageIndicator(
        onDotClicked: (index) {
          pageController.animateToPage(
            index, 
            duration: const Duration(microseconds: 300), 
            curve: Curves.easeInOut);
        },
        controller: pageController, 
        count: 3,
        effect: const ExpandingDotsEffect(dotHeight: 6),
      ),
    );
  }
}



