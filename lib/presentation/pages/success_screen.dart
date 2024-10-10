import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20 ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/images/shopping.jpg',fit: BoxFit.cover,width: 200,height: 200 ,),
              const SizedBox(height: 20,),
              const Text('Your order will be delivered soon.\n ThankYou for choosing our App!'),
              const SizedBox(height: 40 ,),
              button(buttonText: 
              'CONTINUE SHOPPING',
              color: Colors.red, 
              buttonPressed: (){
              //  Navigator.pop(context);
                context.read<BottomNavBloc>().add(OnNavigationEvent(newIndex: 0));
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            )
            ],
          ),
        ),
      ),
    );
  }
}

