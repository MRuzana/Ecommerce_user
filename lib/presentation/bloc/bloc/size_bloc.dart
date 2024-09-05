import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'size_event.dart';
part 'size_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  SizeBloc() : super(SizeState([])) {
    on<ToggleSize>((event, emit) {
      List<String> updatedSizes = List.from(state.selectedSizes);
      if (updatedSizes.contains(event.size)) {
        updatedSizes.remove(event.size);
      } else {
        updatedSizes.add(event.size);
      }
      emit(SizeState(updatedSizes));
    });
  }
}
