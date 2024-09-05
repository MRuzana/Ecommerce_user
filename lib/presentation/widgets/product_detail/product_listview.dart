import 'package:clothing/presentation/bloc/bloc/favourites_bloc.dart';
import 'package:clothing/presentation/widgets/home_screen/size_widget.dart';
import 'package:clothing/presentation/widgets/product_detail/preview_image.dart';
import 'package:clothing/presentation/widgets/product_detail/thumbnail_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return SizedBox(
        child: FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('products').doc(productId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData && snapshot.data != null) {
          final productData = snapshot.data;
          final List<dynamic> imageList = productData!['imagePath'];
          final List<String> sizeList =
              List<String>.from(productData['size'] ?? []);
          final String productname = productData['productName'];
          final String price = productData['price'];
          final String desc = productData['productDescription'];

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreviewImage(imageList: imageList),
                const SizedBox(height: 20),
                ThumbnailImages(imageList: imageList),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizeWidget(
                        sizeList: sizeList,
                      ),
                      BlocBuilder<FavouritesBloc, FavouritesState>(
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () {
                                context.read<FavouritesBloc>().add(ToggleFavourites());
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: state.isFavourite ? Colors.red : Colors.grey,
                              ));
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productname,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        '₹$price',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    desc,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('No products added'));
      },
    ));
  }
}
