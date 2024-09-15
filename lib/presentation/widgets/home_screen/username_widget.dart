import 'package:clothing/presentation/bloc/user_details/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final userId = FirebaseAuth.instance.currentUser!.uid;
    context.read<UserBloc>().add(FetchUserDetails(userId: userId));
    
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        // if(state is UserLoadingState){
        //   return const CircularProgressIndicator();
        // }
        if(state is UserLoadedState){
          return Text(
          state.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        );
        }
        else if(state is UserErrorState){
          return Text(state.errorMessage);
        }  
        return const Text('Unknown state');                                        
      },
    );
  }
}