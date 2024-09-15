part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class ToggleFavouritesEvent extends FavouritesEvent {
  final String productId;
  final String productName;
  final String price;
  final String image;

  ToggleFavouritesEvent ({
    required this.productId,
    required this.productName,
    required this.price,
    required this.image,
  });
}

class DeleteFavItemEvent extends FavouritesEvent{
  final String docId;
  DeleteFavItemEvent({required this.docId});
}

class FetchFavouritesEvent extends FavouritesEvent{
  
}
