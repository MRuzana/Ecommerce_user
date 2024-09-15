import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ShippingAdddress{
  Future<void>saveAddress(String name,String address,String pin,String state,String phoneNumber);
  Stream<QuerySnapshot>fetchAddress();
  Future<void>deleteAddress(String documentId);
  Future<void>editAddress(String documentId,String name,String address,String pin,String state,String phoneNumber);
}