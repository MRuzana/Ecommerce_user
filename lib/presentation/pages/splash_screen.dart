import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (state is UnAuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else if (state is OnboardingIncompleteState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onBoarding', (route) => false);
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'lib/assets/images/logo.png',
            // width: 200,
            // height: 200,
          ),
        ),
      ),
    );
  }
}


















// class SplashWrapper extends StatelessWidget {
//   const SplashWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(   
//       create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
//       child: const SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         print('Current Auth State: $state'); 
//         if(state is AuthenticatedState){
//           Navigator.pushReplacementNamed(context, '/home');
//         }
//         else if(state is UnAuthenticatedState){
//           Navigator.pushReplacementNamed(context, '/login');
//         }
//         else if(state is OnboardingIncompleteState){
//           Navigator.pushReplacementNamed(context, '/onBoarding');
//         }
//         else if(state is AuthErrorState){
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.errorMessage)),
//           );
//         }
//       },
//       child: Scaffold(
//          body: SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Image.asset(
//             width: 60,
//             height: 60,
          
//               'lib/assets/images/logo.png'
//             ),
//         ),
//       ),
//     );
//   }
// }
