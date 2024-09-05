import 'package:clothing/presentation/bloc/product_gallery/product_gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({
    super.key,
    required this.imageList,
  });

  final List imageList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProductGalleryBloc, ProductGalleryState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is ProductImageSelected) {
            selectedIndex = state.selectedIndex;
          }
          return SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                imageList[selectedIndex],
                fit: BoxFit.contain,
                width: double.infinity,
              ));
        },
      ),
    );
  }
}
