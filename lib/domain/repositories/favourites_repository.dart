abstract class FavouritesRepository{
  Future<void>addToFavourites(String productId,String productName,String price,String image);
  Future<void>deleteFavItem(String docId);
   Future<Map<String, bool>>getFavourites();
}