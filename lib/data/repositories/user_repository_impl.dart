import 'package:clothing/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImplementation implements UserRepository{

  @override
  Future<Map <String,String>> getCurrentUser() async {

     User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No user signed in');
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception('User not found in Firestore');
    }

    String? name = userDoc.get('name');
    String? email = user.email;


   return {'name' : name! ,'email':email!};
  }

}