import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clothing/domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitialState()) {
 
    on<AddToCartEvent>(addToCart);
    on<FetchCartEvent>(fetchCart);
    on<DeleteCartItemEvent>(deleteCartItemEvent);
    on<IncrementQuantityEvent>(incrementQuantity);
    on<DecrementQuantityEvent>(decrementQuantity);
  }

  FutureOr<void> addToCart(AddToCartEvent event, Emitter<CartState> emit)async {
    emit(CartLoadingState());
  try {
    await cartRepository.addToCart(event.productId, event.productName, event.productPrice, event.productQuantity, event.image);
    final cartItems = await cartRepository.fetchCart(); // Get updated cart directly
    emit(CartLoadedState(cartItems)); // Emit the updated cart state
  } catch (e) {
    emit(CartErrorState(errorMessage: e.toString()));
  }
  }

  Future<void> fetchCart(FetchCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final cartItems = await cartRepository.fetchCart();
      emit(CartLoadedState(cartItems));
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> deleteCartItemEvent(DeleteCartItemEvent event, Emitter<CartState> emit)async {

    try{

      await cartRepository.deleteCartItem(event.docId);
      add(FetchCartEvent());

    }catch(e){
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }


  Future<void> incrementQuantity(IncrementQuantityEvent event, Emitter<CartState> emit) async {
  emit(CartLoadingState());
  try {
    print('Incrementing quantity for product: ${event.productId}');
    await cartRepository.updateItemQuantity(event.productId, increment: true);
    add(FetchCartEvent());
  } catch (e) {
    emit(CartErrorState(errorMessage: e.toString()));
  }
}

Future<void> decrementQuantity(DecrementQuantityEvent event, Emitter<CartState> emit) async {
  emit(CartLoadingState());
  try {
    print('Decrementing quantity for product: ${event.productId}');
    await cartRepository.updateItemQuantity(event.productId, increment: false);
    add(FetchCartEvent());
  } catch (e) {
    emit(CartErrorState(errorMessage: e.toString()));
  }
}
}
