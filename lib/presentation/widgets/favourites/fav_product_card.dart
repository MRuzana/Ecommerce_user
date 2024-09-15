// ignore_for_file: use_build_context_synchronously

import 'package:clothing/data/repositories/cart_repository_impl.dart';
import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/bloc/favourites/favourites_bloc.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FavProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final String productId;
  const FavProductCard(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.price,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product detail page
        Navigator.pushNamed(context, '/productDetail', arguments: productId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Close Button
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    ),
                  ),
                  // Close (Delete) Button
                  Positioned(
                    top: -8,
                    right: -8,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        context
                            .read<FavouritesBloc>()
                            .add(DeleteFavItemEvent(docId: productId));
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Product Information
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  button(
                      buttonText: "ADD TO CART",
                      color: const Color.fromARGB(255, 206, 205, 205),
                      buttonPressed: () async {
                        final formattedDate =
                            DateFormat('MMM d, yyyy').format(DateTime.now());
                        await cartMethod(context, formattedDate); // Add to cart
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cartMethod(BuildContext context, String formattedDate) async {
    CartRepositoryImplementation cartRepositoryImplementation =
        CartRepositoryImplementation();
    Map<String, dynamic>? productDetails =
        await cartRepositoryImplementation.getProductById(productId);

    String name = productDetails!['productName'];
    String price = productDetails['price'];
    List<dynamic> imageUrl = productDetails['imagePath'];
    String image = imageUrl[0];

    bool isInCart =
        await cartRepositoryImplementation.isProductInCart(productId);

    if (isInCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product is already in the cart')),
      );
    } else {
      context.read<CartBloc>().add(AddToCartEvent(
            productId: productId,
            productName: name,
            productPrice: price,
            productQuantity: 1.toString(),
            image: image,
          ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            margin: const EdgeInsets.all(10),
            content: Text(
              'Item added to cart on $formattedDate',
              style: const TextStyle(color: Colors.white),
            )),
      );
    }
  }
}
