import 'package:clothing/data/repositories/cart_repository_impl.dart';
import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/product_detail/product_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

CartRepositoryImplementation cartRepositoryImplementation =
    CartRepositoryImplementation();

class ProductDetail extends StatelessWidget {
  final String productId;

  const ProductDetail({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductListView(productId: productId),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: button(
                buttonText: 'ADD TO CART',
                color: Colors.red,
                buttonPressed: () async {
                  await cartMethod(context, formattedDate);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: button(
                buttonText: 'BUY NOW',
                color: Colors.green,
                buttonPressed: () {},
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
        SnackBar(content: Text('Product is already in the cart')),
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
