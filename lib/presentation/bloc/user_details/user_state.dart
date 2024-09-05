part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoadingState extends UserState{}

class UserLoadedState extends UserState{
  final String name;
  final String email;

  UserLoadedState(this.name, this.email);
}

class UserErrorState extends UserState{
  final String errorMessage;
  UserErrorState({
    required this.errorMessage
  });
}
