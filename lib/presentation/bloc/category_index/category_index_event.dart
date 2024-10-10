part of 'category_index_bloc.dart';

abstract class CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final int index;

  SelectCategoryEvent(this.index);
}

class ResetCategoryEvent extends CategoryEvent {}
