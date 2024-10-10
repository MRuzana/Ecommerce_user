import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInformation extends StatelessWidget {
  const DeveloperInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color:Colors.white
  ),
        title: const Text(
          'Developer Info',
          style: TextStyle(fontSize: 18,color: Colors.white),
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      '''Welcome to our app! We're excited to introduce you to the developer behind this project.\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\nMeet the Developer: ',
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
                  text: 'Ruzana',
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
                  text: '\n\nRole: Flutter Developer',
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
                      '\nBio: Ruzana is a highly skilled Flutter developer with a passion for crafting stunning and intuitive user interfaces. With a strong background in mobile app development, Ruzana brings creativity and expertise to the table. Her dedication to understanding user behavior allows him to create an aesthetically pleasing app interface that delights users. Ruzana takes pride in her work and collaborates closely with the team to ensure a seamless integration of design and functionality, resulting in an exceptional user experience.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n\n\nDevelopment Philosophy: ',
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
                      '''\n\nAt the core of our app development process is the belief in creating a user-centric platform. We value user feedback and take it seriously in shaping the app's future. Our goal is to provide a user-friendly and efficient app that meets the needs of our valued users. Ruzana's expertise in Flutter development plays a crucial role in achieving this vision.''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '\n\n\nGet in Touch: ',
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
                      '''\n\nWe'd love to hear from you! If you have any questions, suggestions, or feedback, please feel free to reach out to us at ''',
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
                      '''. Your input is invaluable in helping us build an app that continuously evolves and improves.''',
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
                      '''\n\nThank you for choosing our app and being a part of our journey!''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: '''\n\nSincerely,\nThe Development Team\n\n\n''',
                  style: TextStyle(
                    fontSize: 13,
                     color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
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