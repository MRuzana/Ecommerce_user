// ignore_for_file: use_build_context_synchronously

import 'package:clothing/data/repositories/cart_repository_impl.dart';
import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/bloc/size/size_bloc.dart';
import 'package:clothing/presentation/pages/checkout/checkout.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/product_detail/product_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
                buttonPressed: () async {
                  final String? selectedSize =
                      context.read<SizeBloc>().state.selectedSize;

                  if (selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(10),
                        content: Text('Please select a size.'),
                      ),
                    );
                    return;
                  }

                  CartRepositoryImplementation cartRepositoryImplementation =
                      CartRepositoryImplementation();
                  Map<String, dynamic>? productDetails =
                      await cartRepositoryImplementation
                          .getProductById(productId);

                  // String name = productDetails!['productName'];
                  // String price = productDetails['price'];
                  // List<dynamic> imageUrl = productDetails['imagePath'];
                  // String image = imageUrl[0];
                  String stock = productDetails!['stock'];
                  if (int.parse(stock) == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.all(10),
                          content: Text('Product is currently not available')),
                    );
                    return;
                  }

                  showQuantityBottomSheet(context, productId, selectedSize);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cartMethod(BuildContext context, String formattedDate) async {
    final String? selectedSize = context.read<SizeBloc>().state.selectedSize;
    print('inside carmethod $productId');
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
          content: Text('Please select a size before adding to the cart.'),
        ),
      );
      return;
    }

    CartRepositoryImplementation cartRepositoryImplementation =
        CartRepositoryImplementation();
    Map<String, dynamic>? productDetails =
        await cartRepositoryImplementation.getProductById(productId);

    String name = productDetails!['productName'];
    String price = productDetails['price'];
    List<dynamic> imageUrl = productDetails['imagePath'];
    String image = imageUrl[0];
    String stock = productDetails['stock'];
   // String cartId = productDetails['cartId'];
   // print('product_id $product_id');

    bool isInCart =
        await cartRepositoryImplementation.isProductInCart(productId);

    if (isInCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(10),
            content: Text('Product is already in the cart')),
      );
    } else if (int.parse(stock) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(10),
            content: Text('Product is currently not available')),
      );
    } else {
      context.read<CartBloc>().add(AddToCartEvent(
          productId: productId,
          productName: name,
          productPrice: price,
          productQuantity: 1.toString(),
          image: image,
          size: selectedSize,
          stock: stock));
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

  void showQuantityBottomSheet(
      BuildContext context, String productId, String selectedSize) async {
    // Fetch product details
    CartRepositoryImplementation cartRepo = CartRepositoryImplementation();
    final productDetails = await cartRepo.getProductById(productId);

    String stock = productDetails!['stock'];
    String price = productDetails['price'];
    int quantity = 1; // Initialize quantity as an integer for better handling
    List<dynamic> imageList = productDetails['imagePath'];

    String name = productDetails['productName'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Select Quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            // Decrement the quantity
                            setState(() {
                              quantity--;
                            });
                            context.read<CartBloc>().add(
                                  DecrementQuantityEvent(productId: productId),
                                );
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '$quantity', // Display the updated quantity
                        style: const TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          if (quantity < int.parse(stock)) {
                            // Increment the quantity
                            setState(() {
                              quantity++;
                            });
                            context.read<CartBloc>().add(
                                  IncrementQuantityEvent(productId: productId),
                                );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Cannot add more, stock limit reached',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
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
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Map<String, dynamic> updatedProduct = {
                          'productName': name,
                          'price': price,
                          'quantity': quantity.toString(),
                          'size': selectedSize,
                          'image': imageList[0],
                          'productId':productId
                        };

                        print('updated product : $updatedProduct');

                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Checkout(
                                  totalQuantity: quantity,
                                  totalSum: quantity * double.parse(price),
                                  productDetails: updatedProduct,
                                )));
                      },
                      child: const Text(
                        'DONE',
                        style: TextStyle(color: Colors.white),
                      ),
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
}
