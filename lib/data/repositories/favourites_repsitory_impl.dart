import 'package:clothing/domain/repositories/favourites_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesRepositoryImplementation implements FavouritesRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<void> addToFavourites(String productId, String productName, String price, String image)async {
     try{
      User? user = _firebaseAuth.currentUser;
       if (user != null) {
        DocumentReference cartRef = _firestore.collection('users')
        .doc(user.uid)
        .collection('favourites')
        .doc(productId);

        await cartRef.set({
          'productName': productName,
          'price': price,
          'image':image
        });

      } else {
        throw Exception('No user is logged in.');
      }
    }
    catch(e){
      throw Exception('Failed to add to favourites: $e');
    }
  }
  
  @override
  Future<void> deleteFavItem(String docId) async {
     User? user = _firebaseAuth.currentUser;
   try {
      await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('favourites') 
      .doc(docId)
      .delete();
    } catch (e) {
      print('error : $e');
      throw Exception('Failed to remove product. Please try again');
    }
  }
  
  @override
  Future<Map<String, bool>> getFavourites() async{
    User? user = _firebaseAuth.currentUser;
    try {
      // Get the collection of favourite items from Firestore
      final snapshot = await _firestore
      .collection('users')
      .doc(user!.uid)
      .collection('favourites')
      .get();
      
      // Create a Map<String, bool> to store favourites with productId as the key
      final favouritesMap = <String, bool>{};

      // Iterate through the documents in the collection
      for (var doc in snapshot.docs) {
        favouritesMap[doc.id] = true; // Add the productId to the map with a value of true
      }

      return favouritesMap;
    } catch (e) {
      print('Error fetching favourites: $e');
      return {};
    }
  }
}