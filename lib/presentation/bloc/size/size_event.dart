part of 'size_bloc.dart';

@immutable
sealed class SizeEvent {}

class ToggleSize extends SizeEvent{
  final String size;
  ToggleSize({required this.size});
}

