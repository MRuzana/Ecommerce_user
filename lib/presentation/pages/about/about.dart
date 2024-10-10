import 'package:clothing/presentation/pages/about/developer_options.dart';
import 'package:clothing/presentation/pages/about/privacy_policy.dart';
import 'package:clothing/presentation/pages/about/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white, 
        
  ),
        title: const Row(
          children: [
            Text(
              'About  ',
              style: TextStyle(fontSize: 18,
              color: Colors.white,
            ),
            ),
             Text(
              'Style Avenue',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,                 
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Style Avenue',
                style: TextStyle(
                    fontSize: 30,                    
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5,),
              const Text('1.0.0',
                style: TextStyle(fontSize: 12),),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'About this app\n\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Style Avenue',
                          style: TextStyle(
                            fontSize: 13,
                           color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' is a online clothing application that helps users to select,browse and purchase. Items are categorised as mens and womens clothing.\nWith ',
                          style: TextStyle(
                            fontSize: 13,
                             color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: 'Style Avenue',
                          style: TextStyle(
                            fontSize: 13,
                             color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ', users can shop with confidence using our secure payment gateway powered by Razorpay. Provide us with your address, and we will ensure timely delivery of your items. ',
                          style: TextStyle(
                            fontSize: 13,
                             color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                          ),
                        ),
                       
                        TextSpan(
                          text: '\n\nDeveloper Information\n',
                          style: TextStyle(
                            fontSize: 13,
                             color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DeveloperInformation(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nPrivacy Policy\n',
                          style:  TextStyle(
                            fontSize: 13,
                             color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nTerms & Conditions\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
