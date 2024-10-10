import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'productsearch_bloc_event.dart';
part 'productsearch_bloc_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
   final FirebaseFirestore firestore;
  ProductSearchBloc(this.firestore) : super(ProductSearchState(products: [])) {
    on<SearchByProductEvent>(searchByProductEvent);
    on<FilterByCategoryEvent>(filterByCategoryEvent);
    on<ClearFilterEvent>(clearFilterEvent);
    
  }

  FutureOr<void> searchByProductEvent(
    SearchByProductEvent event, Emitter<ProductSearchState> emit) async {
  
  // Handle empty query scenario
  if (event.query.isEmpty) {
    // Emit state with an empty product list when the search query is cleared
    emit(ProductSearchState(products: []));
    return;
  }

  try {
    // Perform Firestore query to search products by productName
    QuerySnapshot snapshot = await firestore
        .collection('products')
        .where('productName', isGreaterThanOrEqualTo: event.query)
        .where('productName', isLessThanOrEqualTo: '${event.query}\uf8ff')
        .get();

    // Fetch the list of products from the query result
    final products = snapshot.docs;

    // Check if no products were found
    if (products.isEmpty) {
      emit(ProductSearchState(products: [])); // Emit state with an empty list
      print('No products found for query: ${event.query}');
    } else {
      // Emit state with the list of matching products
      emit(ProductSearchState(products: products));
    }
  } catch (e) {
    // Emit state with an empty list in case of error
    emit(ProductSearchState(products: []));
    print('Error searching products: $e');
  }
}


  FutureOr<void> filterByCategoryEvent(FilterByCategoryEvent event, Emitter<ProductSearchState> emit) async {
     if (event.category.isEmpty) {
      // Emit state with empty products list and empty query when search is cleared
      emit(ProductSearchState(products: []));
      return;
    }
    try {
          QuerySnapshot snapshot = await firestore
            .collection('products')
            .where('categoryName', isEqualTo: event.category)
            .get();

        final products = snapshot.docs;
       
         if (products.isEmpty) {
      // Emit state with no products found message
      emit(ProductSearchState(products: []));
    } else {
      emit(ProductSearchState(products: products));
    }
      } catch (e) {
        emit(ProductSearchState(products: []));
        print('Error searching products: $e');
      }
  }

  FutureOr<void> clearFilterEvent(ClearFilterEvent event, Emitter<ProductSearchState> emit) async {
      emit(ProductSearchState(products: []));
  }
}





 
