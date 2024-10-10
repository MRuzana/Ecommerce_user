import 'package:clothing/presentation/pages/checkout/checkout.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class CartItemTotal extends StatelessWidget {
  const CartItemTotal({
    super.key,
    required this.totalQuantity,
    required this.totalSum,
    required this.state,
  });

  final int totalQuantity;
  final double totalSum;
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$totalQuantity items in cart', // Display total quantity
            style: TextStyle(fontSize: 18.0,
            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,),
          ),
          Text(
            'Sub total price : ₹${totalSum.toStringAsFixed(2)}', // Display total sum
            style: TextStyle(fontSize: 18.0,
            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
          ),
          ),
          const SizedBox(height: 20),
          button(
            buttonText: 'CHECK OUT',
            color: Colors.red,
            buttonPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Checkout(
                        totalQuantity: totalQuantity,
                        totalSum: totalSum,
                        state: state,
                      )));
            },
          ),
        ],
      ),
    );
  }
}