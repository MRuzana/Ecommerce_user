import 'package:clothing/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              hintStyle: TextStyle(
                  color: Colors.black // Hint text color for light mode
                  ),
            ),
            onChanged: (query) {
              if (query.isEmpty) {
                // Emit an empty search query to revert to the default product list
                context
                    .read<ProductSearchBloc>()
                    .add(SearchByProductEvent(query: query));
              } else {
                // Trigger search when query is not empty
                context
                    .read<ProductSearchBloc>()
                    .add(SearchByProductEvent(query: query));
              }
            },
          ),
        ),
      ],
    );
  }
}
