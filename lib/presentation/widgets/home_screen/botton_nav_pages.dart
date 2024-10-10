import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class NavItems extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const NavItems({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      selectedIconTheme: const IconThemeData(
        color: Colors.red,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      onTap: onTap,
      currentIndex: currentIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int cartItemCount = 0;

              // Check if the cart is loaded and get the item count
              if (state is CartLoadedState) {
                cartItemCount = state.cartItems.length; // Adjust based on your CartState implementation
              }

              return badges.Badge(
                showBadge: cartItemCount > 0, // Show badge only if there's at least one item
                badgeContent: Text(
                  '$cartItemCount',
                  style: const TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.shopping_cart, size: 30),
              );
            },
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 30),
          label: 'Favourites',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
    );
  }
}










// class NavItems extends StatelessWidget {
//   final Function(int) onTap;
//   final int currentIndex;
//   const NavItems({
//     super.key,
//     required this.onTap,
//     required this.currentIndex
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       unselectedFontSize: 12,
//       selectedFontSize: 12 ,
//       selectedItemColor: Colors.red,
//       unselectedItemColor: Colors.black,
//       selectedIconTheme: const IconThemeData(
//         color: Colors.red,
//       ),
//       unselectedIconTheme: const IconThemeData(
//         color: Colors.black,
//       ),
      
//       onTap: onTap,
//       currentIndex: currentIndex,
      
//       items: const [
//       BottomNavigationBarItem(icon: Icon(Icons.home,size: 30 ,),label: 'Home'),
//       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,size: 30 ,),label: 'Cart'),
//       BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 30 ,),label: 'favourites'),
//       BottomNavigationBarItem(icon: Icon(Icons.person,size: 30 ,),label: 'profile'),
    
    
//     ]);
//   }
// }