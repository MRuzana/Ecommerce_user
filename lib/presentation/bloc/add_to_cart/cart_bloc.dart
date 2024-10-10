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
    on<ClearCartEvent>(clearCart);
  }

  FutureOr<void> addToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      await cartRepository.addToCart(event.productId, event.productName,
          event.productPrice, event.productQuantity, event.image,event.size,event.stock);
      final cartItems =
          await cartRepository.fetchCart(); // Get updated cart directly
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

//   Future<void> deleteCartItemEvent(
//     DeleteCartItemEvent event, Emitter<CartState> emit) async {
//   if (state is CartLoadedState) {
//     final currentState = state as CartLoadedState;
//     final updatedCartItems = List<Map<String, dynamic>>.from(currentState.cartItems);

//     // Remove the cart item locally
//     updatedCartItems.removeWhere((item) => item['productId'] == event.docId);

//     // Emit the updated state with the remaining items
//     emit(CartLoadedState(updatedCartItems));

//     // Update the repository by deleting the item
//     try {
//       await cartRepository.deleteCartItem(event.docId);
//     } catch (e) {
//       emit(CartErrorState(errorMessage: e.toString()));
//     }
//   }
// }

  Future<void> deleteCartItemEvent(
  DeleteCartItemEvent event, Emitter<CartState> emit) async {
  if (state is CartLoadedState) {
    final currentState = state as CartLoadedState;
    final updatedCartItems = List<Map<String, dynamic>>.from(currentState.cartItems);

    // Remove the cart item locally
    updatedCartItems.removeWhere((item) => item['cartId'] == event.cartId);

    // Emit the updated state with the remaining items temporarily (optional)
    // This allows for immediate UI feedback while deletion is happening in the background.
    emit(CartLoadedState(updatedCartItems));

    try {
      // First delete the item from Firebase or your backend
      await cartRepository.deleteCartItem(event.cartId);

      // // After confirming deletion, re-fetch the cart items from the backend
      // final fetchedCartItems = await cartRepository.fetchCart(); // Ensure this fetches updated data

      // // Emit the new state with updated cart items
      // emit(CartLoadedState(fetchedCartItems));
    } catch (e) {
      // Emit an error state if deletion fails
      emit(CartErrorState(errorMessage: e.toString()));

      // Optionally, re-fetch the cart items to restore the state before deletion
      final fetchedCartItems = await cartRepository.fetchCart();
      emit(CartLoadedState(fetchedCartItems));
    }
  }
}

  Future<void> incrementQuantity(
    IncrementQuantityEvent event, Emitter<CartState> emit) async {
  if (state is CartLoadedState) {
    final currentState = state as CartLoadedState;
    final updatedCartItems = List<Map<String, dynamic>>.from(currentState.cartItems);

    // Find the cart item to update
    final index = updatedCartItems.indexWhere((item) => item['productId'] == event.productId);
    if (index != -1) {
      // Update the quantity locally
      final updatedItem = Map<String, dynamic>.from(updatedCartItems[index]);
      int currentQuantity = int.parse(updatedItem['quantity']);
      updatedItem['quantity'] = (currentQuantity + 1).toString();
      updatedCartItems[index] = updatedItem;

      // Emit the updated state without showing loading
      emit(CartLoadedState(updatedCartItems));

      // Update the cart item in the repository (Firebase or local storage)
      try {
        await cartRepository.updateItemQuantity(event.productId, increment: true);
      } catch (e) {
        emit(CartErrorState(errorMessage: e.toString()));
      }
    }
  }
}

Future<void> decrementQuantity(
    DecrementQuantityEvent event, Emitter<CartState> emit) async {
  if (state is CartLoadedState) {
    final currentState = state as CartLoadedState;
    final updatedCartItems = List<Map<String, dynamic>>.from(currentState.cartItems);

    // Find the cart item to update
    final index = updatedCartItems.indexWhere((item) => item['productId'] == event.productId);
    if (index != -1) {
      // Update the quantity locally
      final updatedItem = Map<String, dynamic>.from(updatedCartItems[index]);
      int currentQuantity = int.parse(updatedItem['quantity']);
      if (currentQuantity > 1) {
        updatedItem['quantity'] = (currentQuantity - 1).toString();
        updatedCartItems[index] = updatedItem;

        // Emit the updated state without showing loading
        emit(CartLoadedState(updatedCartItems));

        // Update the cart item in the repository
        try {
          await cartRepository.updateItemQuantity(event.productId, increment: false);
        } catch (e) {
          emit(CartErrorState(errorMessage: e.toString()));
        }
      }
    }
  }
}

  // Future<void> incrementQuantity(
  //     IncrementQuantityEvent event, Emitter<CartState> emit) async {
  //   emit(CartLoadingState());
  //   try {
      
  //     await cartRepository.updateItemQuantity(event.productId, increment: true);
  //     add(FetchCartEvent());
  //   } catch (e) {
  //     emit(CartErrorState(errorMessage: e.toString()));
  //   }
  // }

  // Future<void> decrementQuantity(
  //     DecrementQuantityEvent event, Emitter<CartState> emit) async {
  //   emit(CartLoadingState());
  //   try {
  //     print('Decrementing quantity for product: ${event.productId}');
  //     await cartRepository.updateItemQuantity(event.productId,
  //         increment: false);
  //     add(FetchCartEvent());
  //   } catch (e) {
  //     emit(CartErrorState(errorMessage: e.toString()));
  //   }
  // }

  FutureOr<void> clearCart(event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      await cartRepository.clearCart(); // Clear all items in the cart
      emit(CartLoadedState([])); // Emit an empty cart state
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }
}
