import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

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
          'Terms and Conditions',
          style: TextStyle(fontSize: 18,color: Colors.white),
        ),
      ),

       body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '''
Welcome to Style Avenue, an ecommerce platform for clothing. By accessing or using our app, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully before using our services.

1. Acceptance of Terms:  By using our app, you agree to these terms and conditions. If you do not agree with any part of these terms, you may not use our services.

2. User Registration: To make a purchase, you may be required to register for an account. You are responsible for maintaining the confidentiality of your account information, including your username and password.

3. Ordering and Payment:
   - Orders: By placing an order, you agree to purchase the selected products at the specified price.
   - Payments: We use Razorpay for secure online payments. Payment information is encrypted and processed securely.

4. Shipping and Delivery:
   - Address Collection: We collect user addresses for shipping purposes. It is your responsibility to provide accurate and complete address information.
   - Delivery: Delivery times may vary. We strive to deliver products in a timely manner, but we are not responsible for delays caused by factors beyond our control.

5. Returns and Refunds:
   - Returns: Products may be eligible for return according to our return policy.
   - Refunds: Refunds are processed in accordance with our refund policy.

6. Add to Cart and Wishlist:
   - Add to Cart: The "Add to Cart" feature allows you to collect items for purchase. Adding items to the cart does not guarantee availability.
   - Add to Wishlist: The "Add to Wishlist" feature allows you to save items for future consideration. Wishlist items are not reserved.

7. Privacy Policy: Your use of our app is also governed by our Privacy Policy, which can be found.

8. Intellectual Property: All content on our app, including text, graphics, logos, and images, is the property of LeafLoom and is protected by intellectual property laws.

9. Limitation of Liability: We are not liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of our app or the products purchased through our app.

10. Changes to Terms: We reserve the right to update or modify these terms and conditions at any time. Continued use of our app after such changes constitutes acceptance of the updated terms.

11. Governing Law: These terms and conditions are governed by the laws and regulations of India.

If you have any questions or concerns about these terms and conditions, please contact us at ruza89@gmail.com.

Thank you for using Style Avenue
              ''',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Back button color in dark mode
            : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
