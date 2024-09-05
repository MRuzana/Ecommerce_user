import 'package:clothing/presentation/pages/addresses/shipping_address.dart';
import 'package:clothing/presentation/pages/cart/cart.dart';
import 'package:clothing/presentation/pages/checkout/checkout.dart';
import 'package:clothing/presentation/pages/home/home_screen.dart';
import 'package:clothing/presentation/pages/login/forget_password.dart';
import 'package:clothing/presentation/pages/login/login.dart';
import 'package:clothing/presentation/pages/login/password_reset.dart';
import 'package:clothing/presentation/pages/mens_clothing.dart';
import 'package:clothing/presentation/pages/on_boarding.dart';
import 'package:clothing/presentation/pages/product_detail.dart';
import 'package:clothing/presentation/pages/signup/signup.dart';
import 'package:clothing/presentation/pages/signup/success_email.dart';
import 'package:clothing/presentation/pages/signup/verify_email.dart';
import 'package:clothing/presentation/pages/womens_clothing.dart';
import 'package:flutter/material.dart';

class Routes{

  static final Map<String, WidgetBuilder> routes = {

    '/onBoarding':(context) => OnBoarding(),
    '/login': (context) => LoginScreen(),
    '/signup':(context) => SignUpScreen(),
    '/forgetPassword':(context) => ForgetPassword(),
    '/verifyEmail':(context) => const VerifyEmail(),
    '/successEmail':(context) => const SuccessEmail(),
    '/resetPassword':(context) => const PasswordReset(),
    '/home':(context) => const HomeScreen(),
    '/mensClothing':(context)=> const MensClothing(),
    '/womensClothing':(context)=> WomensClothing(),
    '/productDetail':(context)=> ProductDetail(
      productId: ModalRoute.of(context)!.settings.arguments as String,
    ),
    '/cart':(context) => const Cart(),
    '/checkout':(context) => const Checkout(),
    '/address':(context) => ShippingAddresses(),
  };
}