import 'package:clothing/core/constants/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,required this.pageIndex
  });

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    
    return Visibility(
      visible: pageIndex!=2,
      child: Positioned(
        top: kToolbarHeight,
        right: defaultSpace,
      
        child: TextButton(
        onPressed: () { 
          Navigator.pushNamed(context, '/login');
         
         }, 
        child: const Text('SKIP'),
      )),
    );
  }
}