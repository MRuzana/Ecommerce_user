import 'package:clothing/presentation/bloc/onBoarding/on_boarding_bloc.dart';
import 'package:clothing/presentation/bloc/onBoarding/on_boarding_event.dart';
import 'package:clothing/presentation/bloc/onBoarding/on_boarding_state.dart';
import 'package:clothing/presentation/widgets/on_boarding/on_boarding_dot_navigation.dart';
import 'package:clothing/presentation/widgets/on_boarding/on_boarding_next.dart';
import 'package:clothing/presentation/widgets/on_boarding/on_boarding_page.dart';
import 'package:clothing/presentation/widgets/on_boarding/on_boarding_skip.dart';
import 'package:clothing/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatelessWidget {

  final PageController pageController = PageController(initialPage: 0);
  OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: BlocBuilder<OnBoardingBloc, OnBoardingStates>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) {
                state.pageIndex = value;
                BlocProvider.of<OnBoardingBloc>(context).add(OnBoardingEvents());
              },
              children:  [
                OnBoardingPage(
                  pageIndex: 0,
                  context: context,
                  title: onBoardingTitle1,
                  subTitle: onBoardingSubTitle1,
                  image: 'lib/assets/images/onBoarding1.gif'
                ),
                OnBoardingPage(
                  pageIndex: 1,
                  context: context,
                  title: onBoardingTitle2,
                  subTitle: onBoardingSubTitle2,
                  image: 'lib/assets/images/onBoarding2.gif'
                ),
                OnBoardingPage(
                  pageIndex: 2,
                  context: context,
                  title: onBoardingTitle3,
                  subTitle: onBoardingSubTitle3,
                  image: 'lib/assets/images/onBoarding3.gif'
                ),
              ],
            ),
            OnBoardingSkip(pageIndex: state.pageIndex),
            OnBoardingDotNavigation(pageController: pageController),
            OnBoardingNextButton(pageIndex: state.pageIndex,pageController: pageController,)
          ],
        );
        },
      ),
    );
  }
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
  }
}

