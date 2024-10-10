import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is AuthenticatedState) {
            print('AuthenticatedState received with username: ${state.username}, email: ${state.email}'); // Additional logging

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.username ?? 'No username',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
                Text(
                  state.email ?? 'No email',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
              ],
            );
          } else if (state is AuthErrorState) {
            return Text('Error: ${state.errorMessage}');
          }

          return const Text('Unknown state');
        },
      ),
    );
  }
}

// class UserDetails extends StatelessWidget {
//   const UserDetails({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthLoadingState) {
//             return const CircularProgressIndicator();
//           } else if (state is AuthenticatedState) {
          
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   state.username!,
//                   style: const TextStyle(
//                       color: Colors.white, fontSize: 15),
//                 ),
//                 Text(
//                   state.email!,
//                   style: const TextStyle(
//                       color: Color.fromARGB(255, 82, 82, 82), fontSize: 15),
//                 ),
//               ],
//             );
//           } else if (state is AuthErrorState) {
//             state.errorMessage;
//           }
    
//           return const Text('Unknown state');
//         },
//       ),
//     );
//   }
// }  
