import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/cart.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20 ),
          const Text(
              "Looks like you haven't made your choice yet"),
              const SizedBox(height: 60,), 
          Padding(
            padding: const EdgeInsets.all(20 ),
            child: button(
                buttonText: 'CONTINUE SHOPPING',
                color: Colors.red,
                buttonPressed: () {
                 // Navigator.pop(context);
                  context
                      .read<BottomNavBloc>()
                      .add(OnNavigationEvent(newIndex: 0));
                }),
          )
        ],
      ),
    );
  }
}