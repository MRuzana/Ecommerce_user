import 'package:bloc/bloc.dart';
import 'package:clothing/presentation/bloc/onBoarding/on_boarding_event.dart';
import 'package:clothing/presentation/bloc/onBoarding/on_boarding_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvents, OnBoardingStates> {
  OnBoardingBloc() : super(OnBoardingStates()) {
    on<OnBoardingEvents>((event, emit) {
        return emit(OnBoardingStates(pageIndex: state.pageIndex));
      },
    );
  }
}
