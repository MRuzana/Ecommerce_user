import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState(isVisible: false)) {
    on<TogglePasswordVisibility>((event, emit) {
      emit(PasswordState(isVisible: !state.isVisible));
    });
  }
}
