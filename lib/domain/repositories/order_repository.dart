import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Orders{
  
  Stream<QuerySnapshot>fetchOrder();
  Future<Map<String,dynamic>>getOrderDetails(String orderId);
  Future<DocumentSnapshot>fetchAddressById(String shippingAddresId);
}