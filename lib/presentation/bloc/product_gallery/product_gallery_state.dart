part of 'product_gallery_bloc.dart';

@immutable
sealed class ProductGalleryState {}

final class ProductGalleryInitial extends ProductGalleryState {}

class ProductImageSelected extends ProductGalleryState{
  final int selectedIndex;
  ProductImageSelected(this.selectedIndex);
}