import 'package:clothing/presentation/bloc/product_gallery/product_gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThumbnailImages extends StatelessWidget {
  const ThumbnailImages({
    super.key,
    required this.imageList,
  });

  final List imageList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80, // Set a fixed height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context
                    .read<ProductGalleryBloc>()
                    .add(SelectImage(index));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: 80,
                  height:
                      80, // Constrain the height of the thumbnail
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1 ,
                      color: (context.watch<ProductGalleryBloc>().state is ProductImageSelected &&
                             (context.watch<ProductGalleryBloc>().state as ProductImageSelected).selectedIndex == index)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      imageList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
