import 'package:clothing/core/constants/constants.dart';
import 'package:flutter/material.dart';

class SuccessEmail extends StatelessWidget {
  const SuccessEmail({super.key});

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
                image: const AssetImage('lib/assets/images/account_created.png')),
            Text(
              successEmailTitle,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            defaultHeight,
            Text(
              successEmailSubTitle,
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.white),
                  )),
            ),         
          ],
        ),
      ),
    );
  }
}
