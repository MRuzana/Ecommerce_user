import 'package:clothing/domain/repositories/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepositoryImplementation implements CartRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<void> addToCart(String productId,String productName,String price,String quantity,String image) async {
    try{
      User? user = _firebaseAuth.currentUser;
       if (user != null) {
        DocumentReference cartRef = _firestore.collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(productId);

        await cartRef.set({
          'productName': productName,
          'price': price,
          'quantity': quantity,
          'image':image
        });

      } else {
        throw Exception('No user is logged in.');
      }
    }
    catch(e){
      throw Exception('Failed to add to cart: $e');
    }
    
  }
  
  @override
  Future<List<Map<String, dynamic>>> fetchCart()async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        QuerySnapshot cartSnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

        return cartSnapshot.docs.map((doc) {
          return {
            'productId': doc.id,
            'productName': doc['productName'],
            'price': doc['price'],
            'quantity': doc['quantity'],
            'image': doc['image']
          };
        }).toList();
      } else {
        throw Exception('No user is logged in.');
      }
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }


  // Check if the product already exists in the cart
  Future<bool> isProductInCart(String productId) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot productDoc = await _firestore.collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(productId)
          .get();

        return productDoc.exists;
      } else {
        throw Exception('No user is logged in.');
      }
    } catch (e) {
      throw Exception('Error checking cart: $e');
    }
  }

  // Fetch product by productId
  Future<Map<String, dynamic>?> getProductById(String productId) async {
    try {
      DocumentSnapshot productSnapshot = await _firestore
          .collection('products') // Collection name
          .doc(productId)          // Fetch the document by productId
          .get();

      if (productSnapshot.exists) {
        return productSnapshot.data() as Map<String, dynamic>?;
      } else {
        print("Product not found");
        return null;
      }
    } catch (e) {
      print("Error fetching product: $e");
      return null;
    }
  }
  
  @override
  Future<void> deleteCartItem(String docId)async {
    User? user = _firebaseAuth.currentUser;
   try {
      await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('cart') 
      .doc(docId)
      .delete();
    } catch (e) {
      print('error : $e');
      throw Exception('Failed to delete product. Please try again');
    }
  }
  
  @override
  Future<void> updateItemQuantity(String productId, {required bool increment}) async{
    User? user = _firebaseAuth.currentUser;
    var item = await FirebaseFirestore
    .instance
    .collection('users')
    .doc(user!.uid)
    .collection('cart')
    .doc(productId)
    .get();

    if (item.exists) {
      int currentQuantity = int.tryParse(item['quantity']) ?? 1;
      int newQuantity = increment ? currentQuantity + 1 : currentQuantity - 1;

      // Ensure quantity doesn't drop below 1
      if (newQuantity > 0) {
        await FirebaseFirestore.instance.collection('users')
          .doc(user.uid).collection('cart').doc(productId).update({
          'quantity': newQuantity.toString(),
        });
      }
    }
  }
}