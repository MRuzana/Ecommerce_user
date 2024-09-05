import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_state.dart';
import 'package:clothing/presentation/pages/cart/cart.dart';
import 'package:clothing/presentation/pages/favourites.dart';
import 'package:clothing/presentation/pages/home/home_screen_content.dart';
import 'package:clothing/presentation/pages/profile.dart';
import 'package:clothing/presentation/widgets/home_screen/botton_nav_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
     
          body: SafeArea(
            child: BlocBuilder<BottomNavBloc, NavigationStates>(
            builder: (context, state) {
              switch (state.pageIndex) {
                case 0:
                  return const HomeScreenContent();
                case 1:
                  return const Cart();
                case 2:
                  return const Favourites();
                case 3:
                  return Profile();
                default:
                  return const HomeScreenContent();
              }
            },
                    ),
          ),
      
      bottomNavigationBar: BlocBuilder<BottomNavBloc,NavigationStates>(
        builder: (context,state){
          return NavItems(
            currentIndex: state.pageIndex,
            onTap: (index) {
               context.read<BottomNavBloc>().add(OnNavigationEvent(newIndex: index));
            },
          );
        }
      )
    );
  }
}

