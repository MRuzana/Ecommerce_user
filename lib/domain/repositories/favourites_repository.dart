abstract class FavouritesRepository{
  Future<void>addToFavourites(String productId,String productName,String price,String image,String quantity,List size,String stock);
  Future<void>deleteFavItem(String docId);
   Future<Map<String, bool>>getFavourites();
}