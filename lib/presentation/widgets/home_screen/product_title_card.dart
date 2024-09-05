import 'package:clothing/presentation/widgets/home_screen/product_title.dart';
import 'package:clothing/presentation/widgets/home_screen/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductTitleCard extends StatelessWidget {
  final String cardTitle;
  final List<QueryDocumentSnapshot>? productData;
  const ProductTitleCard({
    super.key,
    required this.productData,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          ProductTitle(title: cardTitle),
          const SizedBox(height: 10,),
          LimitedBox(
            maxHeight: 200,
            child: ListView.builder(
              itemCount: productData!.length,
              itemBuilder: (context, index) {
                final product = productData![index];
                final productName = product['productName'];
                final price = product['price'];
                final productId = product.id;
                final List<dynamic> imageList = product['imagePath'];
                return ProductCard(imageUrl: imageList[0],productName: productName,price: price, productId: productId,);
              },
              scrollDirection: Axis.horizontal,
              
            ),
          ),
        ],
      ),
    );
  }
}