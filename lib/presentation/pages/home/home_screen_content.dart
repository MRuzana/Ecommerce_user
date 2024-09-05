import 'package:clothing/core/constants/constants.dart';
import 'package:clothing/presentation/widgets/home_screen/carousal_widget.dart';
import 'package:clothing/presentation/widgets/home_screen/gender_widget.dart';
import 'package:clothing/presentation/widgets/home_screen/product_title_card.dart';
import 'package:clothing/presentation/widgets/home_screen/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(230), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homescreenTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text(
                    'Ruzana',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 20), // Adjust the space as needed
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const SearchWidget(),
                  ),
                  const SizedBox(height: 30), // Adjust the space as needed
                  const GenderWidget()
                ],
              ),
            ),
          ),
        ),
      ),

      body: ListView(
        children: [
          CarousalWidget(),
          const SizedBox(height: 25,),
          ProductListView(firestore: firestore),              
        ],
      ),     
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('products').snapshots(),
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





















