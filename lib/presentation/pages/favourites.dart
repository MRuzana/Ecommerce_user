import 'package:clothing/presentation/widgets/favourites/favourites_title_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 233, 225, 225),
        appBar: AppBar(
          title: const Center(child: Text('Favourites',style: TextStyle(
            color:Colors.white, 
            
          ),)),
          backgroundColor: Colors.red,
  //         iconTheme: IconThemeData(
  //         color: Theme.of(context).brightness == Brightness.dark
  //           ? Colors.black // Back button color in dark mode
  //           : Colors.black, // Back button color in light mode
  // ),
         
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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
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
