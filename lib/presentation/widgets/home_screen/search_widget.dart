import 'package:clothing/presentation/bloc/search/search_bloc_bloc.dart';
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
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
            ),
            onChanged: (query) {
               if (query.isEmpty) {
          // Emit an empty search query to revert to the default product list
          context.read<SearchBloc>().add(SearchEvent(''));
        } else {
          // Trigger search when query is not empty
          context.read<SearchBloc>().add(SearchEvent(query));
        }
            },
          ),
        ),
      ],
    );
  }
}