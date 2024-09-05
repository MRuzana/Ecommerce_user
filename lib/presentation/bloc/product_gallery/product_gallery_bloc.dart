import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_gallery_event.dart';
part 'product_gallery_state.dart';

class ProductGalleryBloc extends Bloc<ProductGalleryEvent, ProductGalleryState> {
  ProductGalleryBloc() : super(ProductGalleryInitial()) {
    on<SelectImage>((event, emit) {
      emit(ProductImageSelected(event.selectedIndex));
    },);
  }
}
