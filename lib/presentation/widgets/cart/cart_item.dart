import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/widgets/delete_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          String size = item['size'] ?? '';

          int stock = int.parse(item['stock']) - int.parse(item['quantity']);
          String cartId = item['cartId'];
          print('cartId $cartId');

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/productDetail',
                  arguments: productId);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 145,
                decoration: BoxDecoration(
                   color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Text color in dark mode
            : const Color.fromARGB(255, 239, 238, 238), 
                  //color: Colors.white,
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
                                  ? Image.network(img,fit: BoxFit.cover,)
                                  : Container(),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['productName'] ?? 'Unknown Product', style: const TextStyle(color: Colors.black),),
                              Text('Size : $size', style: const TextStyle(color: Colors.black),),
                              Text('₹${item['price'] ?? '0'}', style: const TextStyle(color: Colors.black),),
                              Text(
                                '₹${int.parse(item['price']) * int.parse(item['quantity'])}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                              context.read<CartBloc>().add(
                                  DecrementQuantityEvent(
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
                              if (int.parse(item['quantity']) <
                                  int.parse(item['stock'])) {
                                context.read<CartBloc>().add(
                                    IncrementQuantityEvent(
                                        productId: item['productId']));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    margin: EdgeInsets.all(10),
                                    content: Text(
                                        'Cannot add more, stock limit reached'),
                                  ),
                                );
                              }
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
                  trailing: Column(
                    children: [
                      Text(
                        int.parse(item['quantity']) <= int.parse(item['stock'])
                         ? '$stock item left'
                            : 'Out of stock',
                        style: const TextStyle(fontSize: 14,color: Colors.black),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            // deleteAlert(context, productId);
                             deleteAlert(context, cartId);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }

    deleteAlert(BuildContext context, String cartId) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(onDelete: () async {
            try {
              context.read<CartBloc>().add(DeleteCartItemEvent(cartId: cartId));            
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  margin: EdgeInsets.all(10),                 
                  content: Text('product deleted successfully!'),
                ),
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  margin: const EdgeInsets.all(10),             
                  content: Text('Failed to delete product: $e'),
                ),
              );
            }
          });
        });
  }
}
