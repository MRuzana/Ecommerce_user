import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleWidget extends StatelessWidget {
  const GoogleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
            context.read<AuthBloc>().add(GoogleSignInEvent());
          }, 
          icon: Image.asset('lib/assets/images/google.png',
          width: 30,
          height: 30,)
        ),
        //  IconButton(
        //   onPressed: (){
        //     context.read<AuthBloc>().add(FacebookSignInEvent());
        //   }, 
        //   icon: Image.asset('lib/assets/images/facebook.png',
        //   width: 20,
        //   height: 20,)
        // ),
      ],
    );
  }
}