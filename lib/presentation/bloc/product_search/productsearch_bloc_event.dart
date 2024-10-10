part of 'product_search_bloc.dart';

class ProductSearchEvent{}

class FilterByCategoryEvent extends ProductSearchEvent {
  final String category;

  FilterByCategoryEvent({required this.category});
}

// Event for searching by query (product name)
class SearchByProductEvent extends ProductSearchEvent {
  final String query;

  SearchByProductEvent({required this.query});
}

class ClearFilterEvent extends ProductSearchEvent {}

