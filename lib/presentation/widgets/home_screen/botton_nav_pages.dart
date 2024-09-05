import 'package:flutter/material.dart';

class NavItems extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const NavItems({
    super.key,
    required this.onTap,
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 12,
      selectedFontSize: 12 ,
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
      
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home,size: 30 ,),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,size: 30 ,),label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 30 ,),label: 'favourites'),
      BottomNavigationBarItem(icon: Icon(Icons.person,size: 30 ,),label: 'profile'),
    
    
    ]);
  }
}