import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
       backgroundColor: Colors.red,
       iconTheme: const IconThemeData(
          color:Colors.white
  ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontSize: 18,color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '\nPrivacy Policy \n',
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
                  text: '''\nEffective Date:  08-10-2024 \n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n1. Introduction\n',
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
                      '''\nThank you for using the Style Avenue Ecommerce App. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By using our app, you consent to the terms described in this policy.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n2. Information We Collect\n',
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
                  text: '\n2.1. Personal Information:',
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
                      '''\n1. ID: A unique identifier assigned to your account.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '''\n2. Full Name: Your full name for order processing and personalized communication.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
  
                  ),
                ),
                TextSpan(
                  text:
                      '''\n3. Pincode, City, and State: Required for accurate delivery of your purchased items.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '''\n4. Phone Number: Used for communication regarding your orders and services.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                    
                  ),
                ),
                TextSpan(
                  text:
                      '''\n5. House and Area Information: Specific address details for precise delivery.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n2.2.Payment Information',
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
                  text: '\nWe use Razorpay, a secure payment gateway, to process payments. We do not store your payment information on our servers. Please refer to Razorpay\'s privacy policy for details on how they handle your payment information.',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                    
                  ),
                ),
                TextSpan(
                  text: '\n\n2.3. Usage Information',
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
                      '''\nWe may collect information about how you interact with our app, such as pages visited, products viewed, and actions taken.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n2.4. How We Use Your Information',
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
                      '''\n1. Order Fulfillment: To process and deliver your orders accurately.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                  TextSpan(
                  text:
                      '''\n2. Communication: Sending order updates, promotions, and important notifications.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                  TextSpan(
                  text:
                      '''\n3. Improving our Services: Analyzing user behavior to enhance the app's functionality and user experience.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                
                TextSpan(
                  text: '\n3. Information Sharing',
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
                      '''\nWe do not sell, trade, or otherwise transfer your personal information to third parties unless we provide you with advance notice or as required by law.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n4. Security',
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
                      '''\nWe implement a variety of security measures to protect the safety of your personal information.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n5. Your Choices',
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
                      '''\n\nYou can review and update your account information through the app. You may also opt-out of receiving promotional communications.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n6. Changes to this Privacy Policy',
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
                      '''\n\nWe reserve the right to modify this privacy policy at any time. Please review it frequently. Changes and clarifications will take effect immediately upon their posting on the app.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                 TextSpan(
                  text: '\n' '''Contact Us''',
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
                      '''\n\nIf you have any questions about this Privacy Policy, You can contact by email: ''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: 'ruza89@gmail.com',
                  style: TextStyle(
                       color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = ()async {
                       Uri url = Uri.parse('https://mail.google.com/mail/u/0/#inbox');
                        if (await launchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                    },
                ),
                TextSpan(
                  text:
                      '''\n\nBy using the App, you agree to the terms of this Privacy Policy. If you do not agree with the terms outlined herein, please do not use the App.''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\n''',
                  style: TextStyle(
                    fontSize: 13,
                   
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}