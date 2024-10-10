import 'package:clothing/domain/repositories/shipping_address_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShippingAddressImplementation implements ShippingAdddress {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Future<void> saveAddress(String name, String address, String pin,
      String state, String phoneNumber) async {

    User? user = _firebaseAuth.currentUser;    
    try {
      await _firestore
      .collection('users')
      .doc(user!.uid)
      .collection('addresses')
      .add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'address': address,
        'state': state,
        'postalCode': pin,
        'phone': phoneNumber,
        'isDefaultAddress': false
      });
    } catch (e) {
      throw Exception('Failed to save address: $e');
    }
  }

  @override
  Stream<QuerySnapshot> fetchAddress() {
    User? user = _firebaseAuth.currentUser;
    try {
      return _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('addresses')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    } catch (e) {
      throw Exception('Failed to fetch the address. Please try again : $e');
    }
  }

  @override
  Future<void> deleteAddress(String documentId) async {
    User? user = _firebaseAuth.currentUser;
    try {
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('addresses') // Ensure this is the correct collection
          .doc(documentId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete the address. Please try again : $e');
    }
  }

  @override
  Future<void> editAddress(String documentId, String name, String address,
      String pin, String state, String phoneNumber) async {

    User? user = _firebaseAuth.currentUser;    
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('addresses')
          .doc(documentId)
          .update({
        'name': name,
        'address': address,
        'postalCode': pin,
        'state': state,
        'phoneNumber': phoneNumber,
      });
      print('Address updated successfully');
    } catch (e) {
      throw Exception('Failed to update the address : $e');
    }
  }

   Future<Map<String, dynamic>> getAddressById(String documentId) async {
    try {
      DocumentSnapshot addressDoc = await FirebaseFirestore.instance
          .collection('addresses') // Replace with your collection name
          .doc(documentId)
          .get();

      if (!addressDoc.exists) {
        throw Exception('Address not found');
      }

      return addressDoc.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch address: $e');
    }
  }
}
