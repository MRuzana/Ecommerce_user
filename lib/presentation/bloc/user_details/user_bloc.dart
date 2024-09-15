import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clothing/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUserDetails>(fetchUserDetails);
  }

  FutureOr<void> fetchUserDetails(FetchUserDetails event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try{
      final userdetails = await userRepository.getCurrentUser();
      emit(UserLoadedState(userdetails['name']!, userdetails['email']!));

    }
    catch(e){
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }
}  
