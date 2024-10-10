// ignore_for_file: use_build_context_synchronously

import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/data/repositories/user_repository_impl.dart';
import 'package:clothing/presentation/bloc/add_to_cart/cart_bloc.dart';
import 'package:clothing/presentation/bloc/address_checkbox/address_checkbox_bloc.dart';
import 'package:clothing/presentation/pages/addresses/edit_add_address.dart';
import 'package:clothing/presentation/pages/addresses/add_addresses_widget.dart';
import 'package:clothing/presentation/widgets/addresses/display_addresses.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/checkout/order_summary_widget.dart';
import 'package:clothing/presentation/widgets/edit_alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
    this.totalQuantity,
    this.totalSum,
    this.state, // Cart state containing multiple products
    this.productDetails, // Product details map for single product
  });

  final int? totalQuantity;
  final double? totalSum;
  final dynamic state; // Cart state containing multiple products
  final Map<String, dynamic>? productDetails; // Map for single product details

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final Razorpay _razorpay = Razorpay();
  final UserRepositoryImplementation _userRepository = UserRepositoryImplementation();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes event listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('inside checkout page productDetails :${widget.productDetails}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(child: Text('Checkout', style: TextStyle(color: Colors.white))),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AddAdressWidget(), // Widget to add new address
                        DisplayAddressWidget(
                          showShippingSelection: true,
                          shippingAddressImplementation: ShippingAddressImplementation(),
                        ),
                        OrderSummaryWidget(
                          totalQuantity: widget.totalQuantity,
                          totalSum: widget.totalSum,
                          state: widget.state,
                          productDetails: widget.productDetails,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: button(
                    buttonText: 'SUBMIT ORDER',
                    color: Colors.red,
                    buttonPressed: () {
                      final shippingAddressId =
                          context.read<AddressCheckboxBloc>().state.selectedDocumentId;

                      if (shippingAddressId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: EdgeInsets.all(10),
                            content: Text('Select shipping address'),
                          ),
                        );
                      } else {
                        _handleOrderSubmission();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _handleOrderSubmission() async {
    try {
      // Prepare Razorpay options
      final userDetails = await _userRepository.getCurrentUser();
      var options = {
        'key': 'rzp_test_Gb8r5xitcLWsYv',
        'amount': (widget.totalSum! * 100).toString(), // Amount in paise
        'currency': 'INR',
        'name': 'Style Avenue',
        'description': 'Payment for order from Style Avenue',
        'prefill': {
          'contact': userDetails['phoneNumber']!,
          'email': userDetails['email']!,
        }
      };
      _razorpay.open(options);
    } catch (e) {
      // Handle error
      print('Error fetching user details: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;

    // Prepare the products list from cart or product details
    final List<Map<String, dynamic>> products = widget.state != null
        ? List<Map<String, dynamic>>.from(widget.state.cartItems.map((item) {
            return {
              'productName': item['productName'] ?? 'Unknown Product',
              'size': item['size'] ?? 'N/A',
              'quantity': item['quantity'] ?? '1',
              'price': item['price'] ?? '0',
              'image': item['image'] ?? '',
              'productId': item['productId'] ?? '',
            };
          }).toList())
        : [
            {
              'productName': widget.productDetails?['productName'] ?? 'Unknown Product',
              'size': widget.productDetails?['size'] ?? 'N/A',
              'quantity': widget.productDetails?['quantity'] ?? '1',
              'price': widget.productDetails?['price'] ?? '0',
              'image': widget.productDetails?['image'] ?? '',
              'productId': widget.productDetails?['productId'] ?? '',
            }
        ];

      if(widget.state != null) {
      print('Adding products from cart');
    } else {
      print('Adding single product from widget.productDetails');
    }

    try {
      // Add order to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('orders')
          .add({
        'order_id': response.paymentId,
        'shippingAddressId': context.read<AddressCheckboxBloc>().state.selectedDocumentId,
        'totalQuantity': widget.totalQuantity ?? 1, // Default to 1 for single product
        'totalAmount': widget.totalSum ?? double.tryParse(widget.productDetails?['price'] ?? '0') ?? 0,
        'status': 'Order Placed',
        'products': products,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
      });

      // Update product stock
      for (var product in products) {
        String productId = product['productId'];
        int orderedQuantity = int.parse(product['quantity'] ?? '0');
        DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get();

        if (productSnapshot.exists) {
          int currentStock = int.parse(productSnapshot['stock']);
          int newStock = currentStock - orderedQuantity;
          await FirebaseFirestore.instance.collection('products').doc(productId).update({
            'stock': newStock.toString(),
          });
        }
      }

      // Clear cart if applicable
      if (widget.state != null) {
        context.read<CartBloc>().add(ClearCartEvent());
      }

      // Navigate to success screen
      Navigator.pushReplacementNamed(context, '/successScreen');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          margin: EdgeInsets.all(10),
          content: Text('Your order was placed successfully!'),
        ),
      );
    } catch (error) {
      print('Error saving order details: $error');
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment failed: ${response.message}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}
}































// class Checkout extends StatefulWidget {
//   const Checkout({
//     super.key,
//     this.totalQuantity,
//     this.totalSum,
//     this.state,
//     this.productDetails, // Product details map for single product
//   });

//   final int? totalQuantity;
//   final double? totalSum;
//   final dynamic state; // Cart state containing multiple products
//   final Map<String, dynamic>? productDetails; // Map for single product details  


//   @override
//   State<Checkout> createState() => _CheckoutState();
// }

// class _CheckoutState extends State<Checkout> {
//   final ShippingAddressImplementation shippingAddressImplementation = ShippingAddressImplementation();

//   final Razorpay _razorpay = Razorpay();
//   final UserRepositoryImplementation _userRepository = UserRepositoryImplementation();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear(); // Removes event listeners
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     print('inside checkout updated product : ${widget.productDetails}');
//      print('inside checkout product name : ${widget.productDetails!['name']}');


//     // final isCart = widget.state != null && widget.state.cartItems != null;
//     // final isProductDetails = widget.productDetails != null;

//     // // Define total quantity and total sum
//     // final int totalQuantity = isCart
//     //     ? widget.totalQuantity ?? 0 // Use cart quantity
//     //     : 1; // If from product details, assume quantity 1

//     // final double totalSum = isCart
//     //     ? widget.totalSum ?? 0 // Use cart total sum
//     //     : double.tryParse(widget.productDetails?['price'] ?? '0') ?? 0; // Use product price


//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         iconTheme: const IconThemeData(color: Colors.white,),
//         title: const Center(child: Text('Checkout', style: TextStyle(color: Colors.white))),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator()) // Show loading spinner
//           : Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const AddAdressWidget(),
//                         DisplayAddressWidget(
//                           showShippingSelection: true,
//                           shippingAddressImplementation: ShippingAddressImplementation(),
//                         ),
//                         OrderSummaryWidget(
//                           totalQuantity: widget.totalQuantity,
//                           totalSum: widget.totalSum,
//                           state: widget.state,
//                           productDetails: widget.productDetails,
//                         ),
//                         const SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: button(
//                     buttonText: 'SUBMIT ORDER',
//                     color: Colors.red,
//                     buttonPressed: () {
//                       final shippingAddressId =
//                           context.read<AddressCheckboxBloc>().state.selectedDocumentId;

//                       if (shippingAddressId == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             behavior: SnackBarBehavior.floating,
//                             backgroundColor: Colors.red,
//                             margin: EdgeInsets.all(10),
//                             content: Text('Select shipping address'),
//                           ),
//                         );
//                       } else {
//                         _handleOrderSubmission();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Future<void> _handleOrderSubmission() async {
//     try {
//       // Prepare Razorpay options
//       final userDetails = await _userRepository.getCurrentUser();
//       var options = {
//         'key': 'rzp_test_Gb8r5xitcLWsYv',
//         'amount': (widget.totalSum! * 100).toString(), // Amount in paise
//         'currency': 'INR',
//         'name': 'Style Avenue',
//         'description': 'Payment for order from Style Avenue',
//         'prefill': {
//           'contact': userDetails['phoneNumber']!,
//           'email': userDetails['email']!,
//         }
//       };
//       _razorpay.open(options);
//     } catch (e) {
//       // Handle error
//       print('Error fetching user details: $e');
//     }
//   }

//  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//   setState(() {
//     _isLoading = true; // Set loading state to true
//   });

//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   User? user = firebaseAuth.currentUser;
//   print('product ${widget.productDetails}');

//   // Check if the state is provided for cart or productDetails for a single product
//   final List<Map<String, dynamic>> products = widget.state != null
//       ? List<Map<String, dynamic>>.from(widget.state.cartItems.map((item) {
//           return {
//             'productName': item['productName'] ?? 'Unknown Product',
//             'size': item['size'] ?? 'N/A',
//             'quantity': item['quantity'] ?? '1',
//             'price': item['price'] ?? '0',
//             'image': item['image'] ?? '',
//             'productId': item['productId'] ?? '',
//           };
//         }).toList())
//       : [
//           {
//             'productName': widget.productDetails?['name'] ?? 'Unknown Product',
//             'size': widget.productDetails?['size'] ?? 'N/A',
//             'quantity': widget.productDetails?['quantity'] ?? '1',
//             'price': widget.productDetails?['price'] ?? '0',
//             'image': widget.productDetails?['image'] ?? '',
//             'productId': widget.productDetails?['productId'] ?? '',
//           }
//         ];

//   try {
//     // Add order to Firestore
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .collection('orders')
//         .add({
//       'order_id': response.paymentId,
//       'shippingAddressId': context.read<AddressCheckboxBloc>().state.selectedDocumentId,
//       'totalQuantity': widget.totalQuantity ?? 1, // Default to 1 for single product
//       'totalAmount': widget.totalSum ?? double.tryParse(widget.productDetails?['price'] ?? '0') ?? 0,
//       'status': 'Order Placed',
//       'products': products,
//       'timestamp': FieldValue.serverTimestamp(),
//       'userId': user.uid,
//     });

//     // Update product stock
//     for (var product in products) {
//       String productId = product['productId'];
//       print('inside update productId : $productId');
//       int orderedQuantity = int.parse(product['quantity'] ?? '0');
//       DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .doc(productId)
//           .get();

//       if (productSnapshot.exists) {
//         int currentStock = int.parse(productSnapshot['stock']);
//         int newStock = currentStock - orderedQuantity;
//         await FirebaseFirestore.instance.collection('products').doc(productId).update({
//           'stock': newStock.toString(),
//         });
//       }
//     }

//     // Clear cart if applicable
//     if (widget.state != null) {
//       context.read<CartBloc>().add(ClearCartEvent());
//     }

//     // Navigate to success screen
//     Navigator.pushReplacementNamed(context, '/successScreen');

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.green,
//         margin: EdgeInsets.all(10),
//         content: Text('Your order was placed successfully!'),
//       ),
//     );
//   } catch (error) {
//     print('Error saving order details: $error');
//   } finally {
//     setState(() {
//       _isLoading = false; // Set loading state to false
//     });
//   }
// }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Payment failed: ${response.message}'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {}
// }

































// class Checkout extends StatefulWidget {
//   const Checkout({
//     super.key,
//     this.totalQuantity,
//     this.totalSum,
//     this.state,
//     this.productDetails
//   });

//   final int? totalQuantity;
//   final double? totalSum;
//   final dynamic state;
//   final Map<String,dynamic>? productDetails;

//   @override
//   State<Checkout> createState() => _CheckoutState();
// }

// class _CheckoutState extends State<Checkout> {
//   final ShippingAddressImplementation shippingAddressImplementation =
//       ShippingAddressImplementation();

//   final Razorpay _razorpay = Razorpay();
//   final UserRepositoryImplementation _userRepository = UserRepositoryImplementation();
 
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear(); // Removes event listeners
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         iconTheme: const IconThemeData(
//           color: Colors.white,),
//         title: const Center(child: Text('Checkout',style: TextStyle(color: Colors.white),)),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator()) // Show loading spinner
//           : Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const AddAdressWidget(),
//                         DisplayAddressWidget(shippingAddressImplementation: shippingAddressImplementation,
//                             showShippingSelection: true),
//                       //  const PaymentWidget(),
//                         OrderSummaryWidget(
//                           totalQuantity: widget.totalQuantity,
//                           totalSum: widget.totalSum,
//                           state: widget.state,
//                         ),
//                         const SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: button(
//                     buttonText: 'SUBMIT ORDER',
//                     color: Colors.red,
//                     buttonPressed: () {
//                       final shippingAddressId = context.read<AddressCheckboxBloc>()
//                           .state.selectedDocumentId;

//                       if (shippingAddressId == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               behavior: SnackBarBehavior.floating,
//                               backgroundColor: Colors.red,
//                               margin: EdgeInsets.all(10),
//                               content: Text(' Select shipping address')),
//                         );
//                       } else {
//                         _handleOrderSubmission();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   Future<void> _handleOrderSubmission() async {
//     try {
//       // Fetch user details
//       final userDetails = await _userRepository.getCurrentUser();

//       var options = {
//         'key': 'rzp_test_Gb8r5xitcLWsYv',
//         'amount': (widget.totalSum! * 100).toString(), // Amount in paise
//         'currency': 'INR',
//         'name': 'Style Avenue', 
//         'description': 'Payment for order from Style Avenue',
//         'prefill': {
//           'contact': userDetails['phoneNumber']!,
//           'email': userDetails['email']!,
//         }
//       };

//       _razorpay.open(options);
//     } catch (e) {
//       // Handle error if user details could not be fetched
//       print('Error fetching user details: $e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {

//     setState(() {
//       _isLoading = true; // Set loading state to true
//     });

//     final shippingAddressId =
//         context.read<AddressCheckboxBloc>().state.selectedDocumentId;
//     final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//     User? user = firebaseAuth.currentUser;
  

//      // The list of products to store in the order
//      final List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(widget.state.cartItems.map((item) {

//       return {
//         'productName': item['productName'] ?? 'Unknown Product',
//         'size': item['size'] ?? 'N/A',
//         'quantity': item['quantity'] ?? '1',
//         'price': item['price'] ?? '0',
//         'image': item['image'] ?? '',
//         'productId':item['productId'] ?? '',
//       };
//     }).toList());
//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .collection('orders')
//           .add({
//         'order_id': response.paymentId,
//         'shippingAddressId': shippingAddressId,
//         'totalQuantity': widget.totalQuantity,
//         'totalAmount': widget.totalSum,
//         'status': 'Order Placed',
//         'products': products,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId':user.uid,
        
//       });

//       // Step 2: Update stock of each product
//     for (var product in products) {
//       String productId = product['productId'];
//       int orderedQuantity = int.parse(product['quantity'] ?? '0');

//       // Fetch the current stock from Firestore
//       DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .doc(productId)
//           .get();

//       if (productSnapshot.exists) {
//         int currentStock = int.parse(productSnapshot['stock']);

//         // Calculate the new stock
//         int newStock = currentStock - orderedQuantity;

//         // Update the product stock in Firestore
//         await FirebaseFirestore.instance
//             .collection('products')
//             .doc(productId)
//             .update({'stock': newStock.toString()});
//       }
//     }

//       context.read<CartBloc>().add(ClearCartEvent());

//       // After successful save, navigate to success screen
//       Navigator.pushReplacementNamed(context, '/successScreen');

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.green,
//             margin: EdgeInsets.all(10),
//             content: Text('your order placed successfully!')),
//       );
//     } catch (error) {
//       // Handle Firestore saving error
//       print('Error saving order details: $error');
//     } finally {
//       setState(() {
//         _isLoading = false; // Set loading state to false
//       });
//     }
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Payment failed: ${response.message}'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {}
// }

editAlert(
    BuildContext context, String documentId, Map<String, dynamic> addressData) {
  showDialog(
      context: context,
      builder: (context) {
        return EditAlert(onEdit: () async {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddAddresses(
                        documentId: documentId,
                        addressData: addressData,
                      )));
        });
      });
}
