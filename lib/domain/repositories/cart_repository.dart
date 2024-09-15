abstract class CartRepository{
  Future<void>addToCart(String productId,String productName,String price,String productQuantity,String image);
  Future<List<Map<String, dynamic>>> fetchCart();
  Future<void>deleteCartItem(String docId);
  Future<void>updateItemQuantity(String productId, {required bool increment});
}