// ignore_for_file: use_build_context_synchronously

import 'package:clothing/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,required this.pageIndex,required this.pageController
  });

  final int pageIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: defaultSpace,
      bottom: kBottomNavigationBarHeight + 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder()
        ),
        onPressed: ()async{
            if (pageIndex == 2) {
            await completeOnboarding();
            Navigator.pushNamed(context, '/login');
          } else {
            pageController.animateToPage(
              pageIndex + 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
            );
          }
        },
        child: const Icon(Iconsax.arrow_right_3)
      )
    );
  }
   Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
  }
} 
