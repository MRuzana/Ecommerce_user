// ignore_for_file: use_build_context_synchronously

import 'package:clothing/presentation/bloc/category_index/category_index_bloc.dart';
import 'package:clothing/presentation/bloc/product_search/product_search_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget mensCategoryWidget(BuildContext context) {
  return SizedBox(
    height: 65,
    child: FutureBuilder(
        future: getMensCategory(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final categoryList = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList!.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<CategoryIndexBloc, CategoryState>(
                    builder: (context, state) {

                      bool isSelected = index == state.selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<CategoryIndexBloc>()
                              .add(SelectCategoryEvent(index));

                          context.read<ProductSearchBloc>().add(
                              FilterByCategoryEvent(
                                  category: categoryList[index]));
                        },
                        child: IntrinsicWidth(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isSelected ? Colors.grey : Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 13, right: 13),
                                child: Center(
                                  child: Text(
                                    categoryList.isNotEmpty
                                        ? categoryList[index]
                                        : '',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
          } else {
            return const Center(child: Text('No categories available'));
          }
        }),
  );
}

Future<List<String>> getMensCategory(BuildContext context) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot snapshot = await firestore
        .collection('categories')
        .where('type', isEqualTo: 'Men')
        .get();
    final categoryList =
        snapshot.docs.map((doc) => doc['name'] as String).toList();
    return categoryList;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error fetching categories: $e')));
    return [];
  }
}
