import 'package:clothing/presentation/widgets/home_screen/product_title_card.dart';
import 'package:clothing/presentation/widgets/home_screen/search_widget.dart';
import 'package:clothing/presentation/widgets/womens_clothing/womens_category_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WomensClothing extends StatelessWidget {
  const WomensClothing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(230), // Adjust the height as needed
        child: AppBar(
          title: const Text('Women'),
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50), // Adjust the space as needed
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const SearchWidget(),
                    ),
                  ),

                  womensCategoryWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const WomenListView(),
    );
  }
}


class WomenListView extends StatelessWidget {
  const WomenListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore =FirebaseFirestore.instance;
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
      stream:  firestore.collection('products').where('categoryType', isEqualTo: 'Women').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData &&
            snapshot.data!.docs.isNotEmpty) {
          final productData = snapshot.data!.docs;
          return ProductTitleCard(
            productData: productData,
            cardTitle: 'New Arrivals',
          );
        }
        return const Center(child: Text('No products added'));
      },
    ),
    );
  }
}
