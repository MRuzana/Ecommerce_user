import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/widgets/cart/cart_item.dart';
import 'package:clothing/presentation/widgets/cart/cart_item_total.dart';
import 'package:clothing/presentation/widgets/cart/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchCartEvent());
    return Scaffold(
    //  backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        title: const Center(
          child: Text('Cart',style: TextStyle(
         
            color:  Colors.white, 
          ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CartLoadedState) {
                    if (state.cartItems.isEmpty) {              
                      return const EmptyCart();
                    }
                    // Calculate total quantity and total sum
                    int totalQuantity = getTotalQuantity(state);
                    double totalSum = getTotalSum(state);

                    return Column(
                      children: [
                        CartItem(state: state),
                        CartItemTotal(
                            totalQuantity: totalQuantity, 
                            totalSum: totalSum,
                            state: state,
                          
                        ),
                      ],
                    );
                  } else if (state is CartErrorState) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  } else {
                    return const Center(child: Text('No items in cart.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getTotalSum(CartLoadedState state) {
    double totalSum = state.cartItems.fold(0.0, (sum, item) {
      int quantity = int.tryParse(item['quantity']) ?? 1;
      double price = double.tryParse(item['price']) ?? 0;
      return sum + (price * quantity);
    });
    return totalSum;
  }

  int getTotalQuantity(CartLoadedState state) {
    int totalQuantity = state.cartItems.fold(0, (sum, item) {
      int quantity = int.tryParse(item['quantity']) ?? 1;
      return sum + quantity;
    });
    return totalQuantity;
  }
}






