part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}
class  ToggleFavourites extends FavouritesEvent{}