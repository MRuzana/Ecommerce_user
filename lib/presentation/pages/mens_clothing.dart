import 'package:clothing/presentation/bloc/category_index/category_index_bloc.dart';
import 'package:clothing/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:clothing/presentation/widgets/home_screen/product_title_card.dart';
import 'package:clothing/presentation/widgets/home_screen/search_widget.dart';
import 'package:clothing/presentation/widgets/mens_clothing/mens_category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MensClothing extends StatelessWidget {
  const MensClothing({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryIndexBloc>().add(ResetCategoryEvent()); 
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(230), // Adjust the height as needed
          child: AppBar(
           title: const Center(child: Text('Men',style: TextStyle(color: Colors.white ),)),
           iconTheme: const IconThemeData(
            color: Colors.white,),
            leading: IconButton(onPressed: (){

            context.read<ProductSearchBloc>().add(ClearFilterEvent());
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/home');

          }, icon: const Icon(Icons.arrow_back)),
            actions: [          
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(onPressed: (){                
                context.read<ProductSearchBloc>().add(ClearFilterEvent()); 
                context.read<CategoryIndexBloc>().add(ResetCategoryEvent());    
              }, icon: const Icon(Icons.refresh,color: Colors.white,)),
            )
          ],

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
                    mensCategoryWidget(context), // Adjust the space as needed
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const MenListView());
  }
}

class MenListView extends StatelessWidget {
  const MenListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(

      builder: (context, state) {

         String cardTitle = state.products.isEmpty ? 'New Arrivals' : 'Search Results';
         if (state.products.isNotEmpty) {
          return ProductTitleCard(productData: state.products,cardTitle: cardTitle);
        }
        else{
           return SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('products')
                .where('categoryType', isEqualTo: 'Men')
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
                  cardTitle: 'All Products',
                );
              }
              return const Center(child: Text('No products added'));
            },
          ),
        );
        }
       
      },
    );
  }
}
