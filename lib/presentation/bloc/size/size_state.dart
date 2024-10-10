part of 'size_bloc.dart';

class SizeState {
  final String? selectedSize;

  SizeState(this.selectedSize);

   SizeState copyWith({String? selectedSize}) {
    return SizeState(selectedSize ?? this.selectedSize);
  }
}





