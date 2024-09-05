// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class OnboardingIncompleteState extends AuthState {}

class AuthLoadingState extends AuthState{}

class AuthenticatedState extends AuthState{

  User? user;
  AuthenticatedState({this.user});
}

class UnAuthenticatedState extends AuthState {}

class AuthErrorState extends AuthState{
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}