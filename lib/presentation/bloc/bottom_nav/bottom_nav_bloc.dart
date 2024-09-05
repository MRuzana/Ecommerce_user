import 'package:bloc/bloc.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<OnNavigationEvent, NavigationStates> {
  BottomNavBloc() : super(NavigationStates()) {
    on<OnNavigationEvent>((event, emit) {
      return emit(NavigationStates(pageIndex: event.newIndex));
    });
  }
}
