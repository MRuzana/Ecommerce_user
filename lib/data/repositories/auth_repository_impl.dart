// import 'package:clothing/domain/repositories/auth_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepoImplementation implements AuthRrepository {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Future<User?> getCurrentUser() async {
//     return _auth.currentUser;
//   }

//   @override
//   Future<User?> signUp(String username, String password, String email, String phoneNumber) async {
//     try {
//       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       final user = userCredential.user;

//       if (user != null) {
//         await user.sendEmailVerification();
//         await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
//           "uid": user.uid,
//           "email": user.email!.trim(),
//           "name": username.trim(),
//           "phoneNumber": phoneNumber.trim() ,
//           "createdAt": Timestamp.now(),
//         });
//       }

//       return user;
//     } catch (e) {
//       throw Exception('Error signing up: $e');
//     }
//   }

//   @override
//   Future<void> login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       throw Exception('Error logging in: $e');
//     }
//   }

//   @override
//   Future<void> logout() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       throw Exception('Error logging out: $e');
//     }
//   }
// }