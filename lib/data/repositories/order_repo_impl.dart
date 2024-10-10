import 'package:clothing/domain/repositories/order_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderRepositoryImplementation implements Orders {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  @override
  Stream<QuerySnapshot<Object?>> fetchOrder() {
    User? user = _firebaseAuth.currentUser;
    try {
      return _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('orders')
          .snapshots();
    } catch (e) {
      throw Exception('Failed to fetch the address. Please try again : $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    User? user = _firebaseAuth.currentUser;
    try {
      // Reference to the orders collection for a specific user
      final ordersCollection = _firestore
          .collection('users')
          .doc(user!.uid) // User ID from current user
          .collection('orders');

      // Query the collection to find the document with the specific orderId
      QuerySnapshot querySnapshot =
          await ordersCollection.where('order_id', isEqualTo: orderId).get();

      // If a matching document is found, return its data
      if (querySnapshot.docs.isNotEmpty) {
        final orderData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        return orderData;
      } else {
        throw Exception('No order found with ID: $orderId');
      }
    } catch (e) {
      throw Exception('Failed to fetch order: $e');
    }
  }


  @override
  Future<DocumentSnapshot> fetchAddressById(String addressId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
   User? user = _firebaseAuth.currentUser;

  try {
    DocumentSnapshot addressDoc = await firestore
    .collection('users')
    .doc(user!.uid)
    .collection('addresses')
    .doc(addressId)
    .get();

    if (addressDoc.exists) {
      // Address document exists
      return addressDoc;
    } else {
      throw Exception('Address not found');
    }
  } catch (e) {
    throw Exception('Failed to fetch address: $e');
  }
}
}
