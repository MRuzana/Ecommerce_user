part of 'product_gallery_bloc.dart';

@immutable
sealed class ProductGalleryEvent {}


class SelectImage extends ProductGalleryEvent{
  final int selectedIndex;

  SelectImage(this.selectedIndex);

}