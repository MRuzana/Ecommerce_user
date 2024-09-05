// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:clothing/core/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key,this.email});
  final String? email;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late User user;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    timer = Timer.periodic(const Duration(seconds: 3), (timer) { 
      checkEmailVerified();
    });
  }

  @override
  void didUpdateWidget(covariant VerifyEmail oldWidget) {
    super.didUpdateWidget(oldWidget);
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }, icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              Image(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  image: const AssetImage('lib/assets/images/email.png')),
              Text(
                verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              defaultHeight,
              Text(
                user.email ?? 'Email not provided',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                verifyEmailSubTitle2,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  ),
                    onPressed: () {
                       null;
                    },
                    child: const Text(
                      'CONTINUE',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  resendVerificationEmail();
                },
                child: Text('Resend email',style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      ),
    );
  }

   Future<void> checkEmailVerified() async {
    user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      // Navigate to success screen when email is verified
      Navigator.pushReplacementNamed(context, '/successEmail');
    }
  }

   void resendVerificationEmail() {
    user.sendEmailVerification();
    // Show a snackbar to indicate email has been resent
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification email resent'),
      ),
    );
  }
}





















// class VerifyEmail extends StatelessWidget {
//   const VerifyEmail({super.key,this.email});
//   final String? email;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: (){
//             Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//           }, icon: const Icon(Icons.close))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: screenPadding,
//           child: Column(
//             children: [
//               Image(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   image: const AssetImage('lib/assets/images/email.png')),
//               Text(
//                 verifyEmailTitle,
//                 style: Theme.of(context).textTheme.headlineLarge,
//                 textAlign: TextAlign.center,
//               ),
//               defaultHeight,
//               Text(
//                 email ?? 'Email not provided',
//                 style: Theme.of(context).textTheme.headlineMedium,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 verifyEmailSubTitle2,
//                 style: Theme.of(context).textTheme.headlineSmall,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30,),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 16.0, horizontal: 24.0),
//                   ),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/successEmail');
//                     },
//                     child: const Text(
//                       'CONTINUE',
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ),
//               const SizedBox(height: 10,),
//               Text('Resend email',style: Theme.of(context).textTheme.headlineSmall,
//                 textAlign: TextAlign.center,)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
