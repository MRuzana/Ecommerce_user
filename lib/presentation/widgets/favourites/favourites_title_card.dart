import 'package:clothing/presentation/widgets/favourites/fav_product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavouritesTitleCard extends StatelessWidget {
  final List<QueryDocumentSnapshot>? productData;

  const FavouritesTitleCard({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two products per row
        crossAxisSpacing: 15, // Space between columns
        mainAxisSpacing: 15 , // Space between rows
        childAspectRatio: 0.77, // Adjust the size ratio of each item
      ),
      itemCount: productData!.length,
      itemBuilder: (context, index) {
        final product = productData![index];
        final productName = product['productName'];
        final price = product['price'];
        final productId = product.id;
        final image = product['image'];
        final List sizes = product['size'];
        final String quantity = product['quantity'];
        final String stock = product['stock'];

        return FavProductCard( // Using the Grid-based product card
          imageUrl: image,
          productName: productName,
          price: price,
          productId: productId,
          size: sizes,
          quantity: quantity,
          stock: stock,
          
        );
      },
    );
  }
}







