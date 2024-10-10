import 'package:clothing/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// class UserRepositoryImplementation implements UserRepository {

//   @override
//   Future<Map<String, String?>> getCurrentUser() async {
//     // Get the current Firebase user
//     User? user = FirebaseAuth.instance.currentUser;

//     // Check if the user is authenticated
//     if (user == null) {
//       throw Exception('No user signed in');
//     }

//     // Fetch the user's document from Firestore
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();

//     // Check if the document exists in Firestore
//     if (!userDoc.exists) {
//       throw Exception('User not found in Firestore');
//     }

//     // Safely retrieve the user's name, email, and phone number
//     String? name = userDoc.get('name') as String?;
//     String? email = user.email;
//     String? phone = user.phoneNumber;

//     // Return the user information. Email and phone can be null, so returning nullable strings
//     return {
//       'name': name ?? 'Unknown Name',   // Fallback value if name is null
//       'email': email,                   // Email can be null if not set
//       'phoneNumber': phone              // Phone can be null if not set
//     };
//   }
// }

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

      String? name = userDoc.get('name') as String?;
      String? email = userDoc.get('email') as String?;
      String? phone = userDoc.get('phoneNumber') as String?;
   return {'name' : name! ,'email':email!, 'phoneNumber':phone!};
  }

}