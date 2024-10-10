import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.totalQuantity,
    required this.totalSum,
    this.state,
    this.productDetails,
  });

  final int? totalQuantity;
  final double? totalSum;
  final dynamic state;
  final Map<String, dynamic>? productDetails;

  @override
  Widget build(BuildContext context) {
     print('inside ordersummary page productDetails :${productDetails}');
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Order Summary',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Back button color in dark mode
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Quantity : $totalQuantity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white // Back button color in dark mode
                    : Colors.black,
              ),
            ),
            Text(
              'Total Amount : ₹$totalSum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white // Back button color in dark mode
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Conditional rendering based on whether `state` or `productDetails` is available
            state != null
                ? _buildCartItemsList(context, state.cartItems) // Render items from cart state
                : _buildProductDetailsList(context, productDetails), // Render single product details
          ],
        ),
      ),
    );
  }

  // Method to build the list from the cart state
  Widget _buildCartItemsList(BuildContext context, List<dynamic> cartItems) {
    print('from cart');
    return ListView.builder(
      shrinkWrap: true, // To avoid infinite height error
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return _buildOrderItem(context, item);
      },
    );
  }

  // Method to build the list from the productDetails map
  Widget _buildProductDetailsList(BuildContext context, Map<String, dynamic>? productDetails) {
    print('from product details');
    if (productDetails == null) {
      return const SizedBox(); // Return empty if productDetails is null
    }
    return _buildOrderItem(context, productDetails);

    // Wrap product details in a list to maintain structure for display
    // return ListView(
    //   shrinkWrap: true, // To avoid infinite height error
    //   children: [
    //     _buildOrderItem(context, productDetails),
    //   ],
    // );
  }

  // Method to build the order item row
  Widget _buildOrderItem(BuildContext context, Map<String, dynamic> item) {
    String img = item['image'] ?? '';
    String size = item['size'] ?? '';
  

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            child: img.isNotEmpty
                ? Image.network(
                    img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.grey[200]),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['productName'] ?? 'Unknown Product',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                'Size: $size',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                'Quantity: ${item['quantity'] ?? '1'}',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                'Price: ₹${item['price'] ?? '0'}',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
























// class OrderSummaryWidget extends StatelessWidget {
//   const OrderSummaryWidget({
//     super.key,
//     required this.totalQuantity,
//     required this.totalSum,
//     this.state,
//     this.productDetails
//   });

//   final int? totalQuantity;
//   final double? totalSum;
//   final dynamic state;
//   final Map<String,dynamic>? productDetails;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text('Order Summary',
//                   style: TextStyle(
//                        color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Total Quantity : $totalQuantity',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
//                color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,
//             ),
//             ),
//             Text(
//               'Total Amount : $totalSum',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,
//                color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,
//             ),
//             ),
//             const SizedBox(height: 20,),
//             ListView.builder(
//               shrinkWrap: true, // To avoid infinite height error
//               itemCount: state.cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = state. cartItems[index];
//                 String img = item['image'] ?? '';
//                 String size = item['size'] ?? '';
            
//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
                  
//                     children: [
//                       SizedBox(
//                         height: 100 ,
//                         child: img.isNotEmpty
//                             ? Image.network(img,width: 100,height: 100,fit: BoxFit.cover,)
//                             : Container(color: Colors.grey[200]),
//                       ),
//                       const SizedBox(width: 10),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
                          
//                           Text(item['productName'] ?? 'Unknown Product',style: TextStyle(
//                              color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,
//                           ),),
//                           Text('Size: $size',style: TextStyle(
//                             color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,),),
//                           Text('Quantity: ${item['quantity'] ?? '1'}',style: TextStyle(
//                              color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,),),
//                           Text('Price: ₹${item['price'] ?? '0'}',style: TextStyle(
//                              color: Theme.of(context).brightness == Brightness.dark
//             ? Colors.white // Back button color in dark mode
//             : Colors.black,),),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
        