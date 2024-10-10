import 'package:clothing/core/constants/constants.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:clothing/presentation/widgets/home_screen/carousal_widget.dart';
import 'package:clothing/presentation/widgets/home_screen/gender_widget.dart';
import 'package:clothing/presentation/widgets/home_screen/product_title_card.dart';
import 'package:clothing/presentation/widgets/home_screen/search_widget.dart';
import 'package:clothing/presentation/widgets/home_screen/username_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




















class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
     context.read<AuthBloc>().add(CheckLoginStatusEvent());
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
                  const UsernameWidget(),
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
          const NewArrivals(),
          const AllProducts(),
        ],
      ),
    );
  }
}

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        // String cardTitle = state.products.isEmpty ? 'All Products' : 'Search Results';
         String cardTitle = 'All Products';

        //  if (state.products.isNotEmpty) {
        //   return ProductTitleCard(productData: state.products,cardTitle: cardTitle);
        // }
    //    else{
             return SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
            .collection('products')
            .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final productData = snapshot.data!.docs;
                
                return ProductTitleCard(
                  productData: productData,
                  cardTitle: cardTitle,
                );
              }
              return const Center(child: Text('No products added'));
            },
          ),
        );
        }
     
  // },
    );
  }
}

class NewArrivals extends StatelessWidget {
  const NewArrivals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        // String cardTitle = state.products.isEmpty ? 'New Arrivals' : 'Search Results';
         String cardTitle = 'New Arrivals';

        //  if (state.products.isNotEmpty) {
        //   return ProductTitleCard(productData: state.products,cardTitle: cardTitle);
        // }
        // else{
             return SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
            .collection('products')
            .orderBy('timestamp', descending: true) // Order by timestamp, most recent first
            .limit(4) 
            .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final productData = snapshot.data!.docs;
                return ProductTitleCard(
                  productData: productData,
                  cardTitle: cardTitle,
                );
              }
              return const Center(child: Text('No products added'));
            },
          ),
        );
        }
     
    //  },
    );
  }

  
}


