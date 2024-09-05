import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesState(isFavourite: false)) {
    on<FavouritesEvent>((event, emit) {
      emit(FavouritesState(isFavourite: !state.isFavourite));
    });
  }
}

