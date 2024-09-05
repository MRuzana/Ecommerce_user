// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarousalWidget extends StatelessWidget {
  CarousalWidget({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getBanners(context),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if(snapshot.hasData && snapshot.data!.isNotEmpty) {
           
            final bannerUrls = snapshot.data;
            return CarouselSlider(
              items: bannerUrls!
                  .map((url) =>
                      slider(image: NetworkImage(url), context: context))
                  .toList(),
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1.0,
              ),
            );
          }
          else  {
            return const Center(child: Text('No banners available'));
          } 
                          
        });
  }

  Future<List<String>> getBanners(BuildContext context) async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('banners').get();
    final banners = querySnapshot.docs.map((doc) => doc['image'] as String).toList();
    return banners;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text('Error fetching banners: $e')));
      return [];
  }
}

  Widget slider({required ImageProvider image, context}) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
