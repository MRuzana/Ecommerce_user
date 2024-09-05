import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clothing/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;

  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>(checkLoginStatusEvent);
    on<LoginEvent>(loginEvent);
    on<SignUpEvent>(signUpEvent);
    on<LogoutEvent>(logoutEvent);
    on<GoogleSignInEvent>(googleSignInEvent);
    on<FacebookSignInEvent>(facebookSignInEvent);
  }

  FutureOr<void> checkLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        user = _auth.currentUser;
      });

      final prefs = await SharedPreferences.getInstance();
      final hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;

      if (user != null) {
        emit(AuthenticatedState(user: user));
      }
      else if(!hasCompletedOnboarding){
        emit(OnboardingIncompleteState());
      }
      else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user.email.toString(),
          password: event.user.password.toString());

      final user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": user.email,
          "name": event.user.username,
          "phoneNumber": event.user.phoneNumber,
          "createdAt": DateTime.now(),
        });
        emit(AuthenticatedState(user: user));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _auth.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final user = userCredential.user;

      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(UnAuthenticatedState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(errorMessage: 'Wrong password provided.'));
      } else {
        emit(AuthErrorState(errorMessage: 'Firebase Auth error: ${e.message}'));
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> googleSignInEvent(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // retrieves the authentication tokens (ID token and access token) for the signed-in Google user.
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final user = userCredential.user;
        if (user != null) {
          emit(AuthenticatedState());
        } else {
          emit(UnAuthenticatedState());
        }
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> facebookSignInEvent(
      FacebookSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final userCredential = await _auth.signInWithCredential(credential);
        final user = userCredential.user;

        if (user != null) {
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnAuthenticatedState());
        }
      } else {
        emit(AuthErrorState(
            errorMessage: 'Facebook login failed: ${result.message}'));
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }
}















// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRrepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthInitial()) {
//     on<CheckLoginStatusEvent>(checkLoginStatusEvent);
//     on<LoginEvent>(loginEvent);
//     on<SignUpEvent>(signUpEvent);
//     on<LogoutEvent>(logoutEvent);
//   }

//   Future<void> checkLoginStatusEvent(CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
//     try {
//       final user = await authRepository.getCurrentUser();

//       if (user != null) {
//         emit(AuthenticatedState(user: user));
//       } else {
//         emit(UnAuthenticatedState());
//       }
//     } catch (e) {
//       emit(AuthErrorState(errorMessage: e.toString()));
//     }
//   }

//   Future<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());

//     try {
//       final user = await authRepository.signUp(
//         event.user.email!,
//         event.user.password!,
//         event.user.username!,
//         event.user.phoneNumber!,
//       );

//       if (user != null) {
//         emit(AuthenticatedState(user: user));
//       } else {
//         emit(UnAuthenticatedState());
//       }
//     } catch (e) {
//       emit(AuthErrorState(errorMessage: e.toString()));
//     }
//   }

//   Future<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());

//     try {
//       await authRepository.login(event.email, event.password);
//       final user = await authRepository.getCurrentUser();

//       if (user != null) {
//         emit(AuthenticatedState(user: user));
//       } else {
//         emit(UnAuthenticatedState());
//       }
//     } catch (e) {
//       emit(AuthErrorState(errorMessage: e.toString()));
//     }
//   }

//   Future<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
//     try {
//       await authRepository.logout();
//       emit(UnAuthenticatedState());
//     } catch (e) {
//       emit(AuthErrorState(errorMessage: e.toString()));
//     }
//   }
// }
