import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
   final FirebaseFirestore firestore;
  SearchBloc(this.firestore) : super(SearchState(products: [])) {
    on<SearchEvent>(searchEvent);
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter<SearchState> emit) async{
    if (event.query.isEmpty) {
      // Emit state with empty products list and empty query when search is cleared
      emit(SearchState(products: []));
      return;
    }
    try {
        QuerySnapshot snapshot = await firestore
            .collection('products')
            .where('productName', isGreaterThanOrEqualTo: event.query)
            .where('productName', isLessThanOrEqualTo: '${event.query}\uf8ff')
            .get();

        final products = snapshot.docs;
        print('search products : $products');
        
        emit(SearchState(products: products));
      } catch (e) {
        emit(SearchState(products: []));
        print('Error searching products: $e');
      }
    
  }
}
