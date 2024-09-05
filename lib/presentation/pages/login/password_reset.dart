import 'package:clothing/core/constants/constants.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            Image(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                image: const AssetImage('lib/assets/images/email.png')),
            Text(
              passwordResetTitle,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            defaultHeight,
            Text(
              passwordResetSubTitle1,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              passwordResetSubTitle2,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            button(
              buttonText: 'DONE', 
              color: Colors.red,
              buttonPressed: (){
                Navigator.pushNamed(context, '/login');
              }
            ),
            const SizedBox(height: 10,),
            Text('Resend email',style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
