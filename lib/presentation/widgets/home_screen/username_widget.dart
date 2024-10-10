import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is AuthenticatedState) {
          // Display user's name if available
          final String username = state.username ?? 'Unknown User';
          return Text(
            username,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          );
        }

        if (state is AuthErrorState) {
          return Text('Error: ${state.errorMessage}');
        }

        return const Text('User not logged in');
      },
    );
  }
}
