import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkbox_event.dart';
part 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckBoxState> {
  CheckboxBloc() : super(CheckBoxState(isChecked: false)) {
    on<CheckboxEvent>((event, emit) {
      emit(CheckBoxState(isChecked: !state.isChecked));
    });
  }
}
