import 'package:clothing/presentation/widgets/home_screen/product_title_card.dart';
import 'package:clothing/presentation/widgets/home_screen/search_widget.dart';
import 'package:clothing/presentation/widgets/mens_clothing/mens_category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MensClothing extends StatelessWidget {
  const MensClothing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(230), // Adjust the height as needed
        child: AppBar(
          title: const Text('Men'),
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  const SizedBox(height: 50 ), // Adjust the space as needed
                  Padding(
                    padding: const EdgeInsets.all(20 ),
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
                  mensCategoryWidget(context), // Adjust the space as needed
                  
                ],
              ),
            ),
          ),
        ),
      ),



      body: MenListView()
    );
  }
}

class MenListView extends StatelessWidget {
  const MenListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore =FirebaseFirestore.instance;
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
      stream:  firestore.collection('products').where('categoryType', isEqualTo: 'Men').snapshots(),
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