import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/pages/checkout/checkout.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchCartEvent());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        title: const Center(
          child: Text('Cart'),
        ),
        
        backgroundColor: const Color.fromARGB(255, 233, 225, 225),

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
                      return const Center(child: Text('Your cart is empty.'));
                    }

                    // Calculate total quantity and total sum
                    int totalQuantity = getTotalQuantity(state);
                    double totalSum = getTotalSum(state);

                    return Column(
                      children: [
                        CartItem(state: state),
                        CartItemTotal(
                            totalQuantity: totalQuantity, totalSum: totalSum),
                      ],
                    );
                  }
                   else if (state is CartErrorState) {
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

class CartItemTotal extends StatelessWidget {
  const CartItemTotal({
    super.key,
    required this.totalQuantity,
    required this.totalSum,
  });

  final int totalQuantity;
  final double totalSum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$totalQuantity items in cart', // Display total quantity
            style: const TextStyle(fontSize: 18.0),
          ),
          Text(
            'Sub total price : ₹${totalSum.toStringAsFixed(2)}', // Display total sum
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20),
          button(
            buttonText: 'CHECK OUT',
            color: Colors.red,
            buttonPressed: () {
              
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Checkout(
                  totalQuantity: totalQuantity,
                  totalSum: totalSum,
                )));
            },
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.state});
  final dynamic state;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.cartItems.length,
        itemBuilder: (context, index) {
          final item = state.cartItems[index];
          String img = item['image'] ?? '';

          String productId = item['productId'] ?? '';

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/productDetail', arguments: productId);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 135,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80.0,
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: img.isNotEmpty
                                  ? Image.network(img)
                                  : Container(),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['productName'] ?? 'Unknown Product'),
                              const SizedBox(height: 5.0),
                              Text('₹${item['price'] ?? '0'}'),
                              Text(
                                '₹${int.parse(item['price']) * int.parse(item['quantity'])} ',
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(DecrementQuantityEvent(
                                  productId: item['productId']));
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${item['quantity'] ?? 1}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(IncrementQuantityEvent(
                                  productId: item['productId']));
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(DeleteCartItemEvent(docId: productId));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
