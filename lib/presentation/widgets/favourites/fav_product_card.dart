// ignore_for_file: use_build_context_synchronously

import 'package:clothing/data/repositories/cart_repository_impl.dart';
import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final String productId;
  final List size;
  final String quantity;
  final String stock;

  const FavProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.productId,
    required this.size,
    required this.quantity,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/productDetail', arguments: productId);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error, size: 50));
                    },
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<FavouritesBloc>()
                          .add(DeleteFavItemEvent(docId: productId));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₹$price',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                await _showSizeBottomSheet(
                    context, cartBloc, scaffoldMessenger, stock);
              },
              child: Center(
                child: Text(
                  "ADD TO CART",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color.fromARGB(255, 19, 110, 22),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSizeBottomSheet(BuildContext context, CartBloc cartBloc,
      ScaffoldMessengerState scaffoldMessenger, String stock) async {
    String? selectedSize;
    // CartRepositoryImplementation cartRepositoryImplementation =
    //     CartRepositoryImplementation();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Size",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: size.map<Widget>((sizeOption) {
                      bool isSelected = selectedSize == sizeOption;
                      return ChoiceChip(
                        label: Text(sizeOption,
                            style: const TextStyle(color: Colors.black)),
                        selected: isSelected,
                        selectedColor: Colors.green,
                        backgroundColor: Colors.white,
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              selectedSize = sizeOption;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                     
                        // Check if stock is 0
                        if (int.parse(stock) == 0) {
                          Fluttertoast.showToast(
                            msg: "Product is currently not available",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );

                          return; // Return early if product is out of stock
                        }

                        // If stock is available, check if size is selected
                        if (selectedSize != null) {
                          Navigator.pop(context);
                          await cartMethod(context, cartBloc, selectedSize!,
                              scaffoldMessenger); // Pass selected size
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please select a size.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      },
                      child: const Text('DONE',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> cartMethod(BuildContext context, CartBloc cartBloc,
      String selectedSize, ScaffoldMessengerState scaffoldMessenger) async {
    final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    CartRepositoryImplementation cartRepositoryImplementation =
        CartRepositoryImplementation();

    // Get product details using the provided context
    Map<String, dynamic>? productDetails =
        await cartRepositoryImplementation.getProductById(productId);

    if (productDetails == null) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text('Product details could not be retrieved.')),
      );
      return;
    }

    String name = productDetails['productName'];
    String price = productDetails['price'];
    List<dynamic> imageUrl = productDetails['imagePath'];
    String image = imageUrl[0];
    String stock = productDetails['stock'];

    bool isInCart =
        await cartRepositoryImplementation.isProductInCart(productId);

    if (isInCart) {
      scaffoldMessenger.showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
          content: Text('Product is already in the cart')));
    } else {
      cartBloc.add(AddToCartEvent(
        productId: productId,
        productName: name,
        productPrice: price,
        productQuantity: '1',
        image: image,
        size: selectedSize,
        stock: stock,
      ));
      scaffoldMessenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(10),
        content: Text('Item added to cart on $formattedDate',
            style: const TextStyle(color: Colors.white)),
      ));
    }
  }
}
