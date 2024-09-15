part of 'cart_bloc.dart';

abstract class CartEvent{}

class AddToCartEvent extends CartEvent{
  final String productId;
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String image; 

  AddToCartEvent({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.image
  });
}

class FetchCartEvent extends CartEvent {}

class DeleteCartItemEvent extends CartEvent{
  final String docId;
  DeleteCartItemEvent({required this.docId});
}

class IncrementQuantityEvent extends CartEvent {
  final String productId;

  IncrementQuantityEvent({required this.productId});
}

class DecrementQuantityEvent extends CartEvent {
  final String productId;

  DecrementQuantityEvent({required this.productId});
}