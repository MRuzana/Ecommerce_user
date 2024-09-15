import 'package:clothing/presentation/widgets/favourites/favourites_title_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
         
        ),
        body: const SafeArea(
          child: Padding(padding: EdgeInsets.all(10),
          child: FavouriteContent(),
        )));
  }
}

class FavouriteContent extends StatelessWidget {
  const FavouriteContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? user = _firebaseAuth.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .doc(user!.uid) // Replace with the actual user id
            .collection('favourites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final productData = snapshot.data!.docs;
            return FavouritesTitleCard(
              productData: productData,
            );
          }
          return const Center(child: Text('No products added'));
        },
      ),
    );
  }
}
