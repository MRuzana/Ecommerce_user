import 'package:bloc/bloc.dart';

part 'category_index_event.dart';
part 'category_index_state.dart';

class CategoryIndexBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryIndexBloc() : super(CategoryState()) {
   on<SelectCategoryEvent>((event, emit) {
      emit(CategoryState(selectedIndex: event.index));
    });

    on<ResetCategoryEvent>((event, emit) {
      emit(CategoryState());
    });
  }
}
