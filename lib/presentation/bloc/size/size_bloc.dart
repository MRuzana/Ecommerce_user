import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'size_event.dart';
part 'size_state.dart';


class SizeBloc extends Bloc<SizeEvent, SizeState> {
  SizeBloc() : super(SizeState(null)) {
    on<ToggleSize>((event, emit) {
    
       if (state.selectedSize == event.size) {
        emit(SizeState(null)); 
      } else {
        emit(SizeState(event.size)); 
        // Select the new size
      }
    });
   
  }
}
