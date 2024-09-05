part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUserDetails extends UserEvent{
  final String userId;
  FetchUserDetails({
    required this.userId
  });
}
