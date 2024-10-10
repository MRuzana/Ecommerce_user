import 'package:clothing/presentation/bloc/size/size_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SizeWidget extends StatelessWidget {
  const SizeWidget({
    super.key,
    this.sizeList,
    this.onSizeSelected
  });

  final List<String>? sizeList;
  final ValueChanged<String>? onSizeSelected;

  @override
  Widget build(BuildContext context) {
    // Ensure sizeList is not null to avoid errors
    if (sizeList == null || sizeList!.isEmpty) {
      return const Text('No sizes available');
    }

    return BlocBuilder<SizeBloc, SizeState>(
      builder: (context, state) {
        return Row(
          children: sizeList!.map((size) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: sizeOption(context, size, state.selectedSize),
          )).toList(),
        );
      },
    );
  }
  Widget sizeOption(BuildContext context, String size, String? selectedSize) {
     bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
       context.read<SizeBloc>().add(ToggleSize(size: size));
        if (onSizeSelected != null) {
          onSizeSelected!(size);
        }
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? Colors.green : const Color.fromARGB(255, 254, 254, 253),
          border: Border.all(width: 1,color: Colors.grey)
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontSize: 18 ,
              color: isSelected ? Colors.white : Colors.black,
              
            ),
          ),
        ),
      ),
    );
  }
}














// class SizeWidget extends StatelessWidget {
//   const SizeWidget({
//     super.key,
//     this.sizeList,
//   });

//   final List<String>? sizeList;

//   @override
//   Widget build(BuildContext context) {
//     // Ensure sizeList is not null to avoid errors
//     if (sizeList == null || sizeList!.isEmpty) {
//       return const Text('No sizes available');
//     }

//     return BlocBuilder<SizeBloc, SizeState>(
//       builder: (context, state) {
//         return Row(
//           children: sizeList!.map((size) => Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: sizeOption(context, size, state.selectedSizes),
//           )).toList(),
//         );
//       },
//     );
//   }
//   Widget sizeOption(BuildContext context, String size, List<String> selectedSizes) {
//     bool isSelected = selectedSizes.contains(size);

//     return GestureDetector(
//       onTap: () {
//        context.read<SizeBloc>().add(ToggleSize(size: size));
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//           color: isSelected ? Colors.green : const Color.fromARGB(255, 254, 254, 253),
//           border: Border.all(width: 1,color: Colors.grey)
//         ),
//         child: Center(
//           child: Text(
//             size,
//             style: TextStyle(
//               fontSize: 18 ,
//               color: isSelected ? Colors.white : Colors.black,
              
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }