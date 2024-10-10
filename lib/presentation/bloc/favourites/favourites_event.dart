part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class ToggleFavouritesEvent extends FavouritesEvent {
  final String productId;
  final String productName;
  final String price;
  final String image;
  final String productQuantity;
  final List size;
  final String stock;

  ToggleFavouritesEvent ({
  
    required this.productId,
    required this.productName,
    required this.price,
    required this.image,
    required this.productQuantity,
    required this.size,
    required this.stock
    
  });
}


class DeleteFavItemEvent extends FavouritesEvent{
  final String docId;
  DeleteFavItemEvent({required this.docId});
}

class FetchFavouritesEvent extends FavouritesEvent{
  
}
