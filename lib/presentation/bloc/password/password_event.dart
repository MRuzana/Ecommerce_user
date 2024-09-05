part of 'password_bloc.dart';

@immutable
sealed class PasswordEvent {}

class TogglePasswordVisibility extends PasswordEvent{}