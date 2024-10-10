import 'package:clothing/data/repositories/order_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderId,required this.status});
  final String orderId;
  final String status;

  @override
  Widget build(BuildContext context) {
    OrderRepositoryImplementation orderRepositoryImplementation =
        OrderRepositoryImplementation();
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        title: const Text('Order details',style: TextStyle(
           color: Colors.white, 
          ),),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white 
  ),
      ),
    body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: orderRepositoryImplementation.getOrderDetails(orderId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Order not found'));
            } else {

              final orderData = snapshot.data!;
              final products = orderData['products'];
              
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID: ${orderData['order_id']}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          FutureBuilder<DocumentSnapshot>(
                          future: orderRepositoryImplementation.fetchAddressById(orderData['shippingAddressId']),
                          builder: (context, addressSnapshot) {
                            if (addressSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (addressSnapshot.hasError) {
                              return Center(child: Text('Error fetching address: ${addressSnapshot.error}'));
                            } else if (addressSnapshot.hasData &&addressSnapshot.data != null) {

                              final addressData = addressSnapshot.data!.data() as Map<String, dynamic>;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Shipping Address',style: TextStyle(
                                    fontSize: 16,                                  
                                    fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Padding(padding: const EdgeInsets.only(left: 15 ),
                                    child: Text('${addressData['name']}'),),
                                  Padding(padding: const EdgeInsets.only(left: 15 ),
                                    child: Text('${addressData['address']}'),),
                                  Padding(padding: const EdgeInsets.only(left: 15 ),
                                    child: Text('${addressData['postalCode']}'),),
                                  Padding(padding: const EdgeInsets.only(left: 15 ),
                                    child: Text('${addressData['state']}'),),
                                  Padding(padding: const EdgeInsets.only(left: 15 ),
                                    child: Text('${addressData['phone']}'),),
                                ],
                             );
                          } else {
                              return const Center(
                                child: Text('Shipping address not found'));
                            }
                          },
                        ),
                          const SizedBox(height: 15 ,),
                           const Text('Product Details',style: TextStyle(
                                    fontSize: 16,
                                    
                                    fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6 ,),          
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Total Quantity: ${orderData['totalQuantity']}',style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Total Price: ₹${orderData['totalAmount']}',style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ),

                     const SizedBox(height: 10 ),
                    ProductList(products: products),
                    Padding(
                      padding: const EdgeInsets.all(20 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Track Order',style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold)),
                          IconButton(onPressed: (){
                            _buildTrackOrder(context,status);
                          }, icon: Icon(Icons.location_on_outlined,
                           color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.red
                        : Colors.green,
                          size: 30 ,))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void _buildTrackOrder(BuildContext context, String orderStatus) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineItem('Order Placed', 'Order Placed', orderStatus),
            _buildTimelineItem('Shipped', 'Shipped', orderStatus),
            _buildTimelineItem('Out for delivery', 'Out for delivery', orderStatus),
            _buildTimelineItem('Delivered', 'Delivered', orderStatus, isLast: true),
          ],
        ),
      );
    },
  );
}

// Helper method to build each timeline item
Widget _buildTimelineItem(String label, String status, String currentStatus, {bool isLast = false}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(
            currentStatus == status || _isStatusCompleted(currentStatus, status)
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: currentStatus == status || _isStatusCompleted(currentStatus, status)
                ? Colors.green
                : Colors.grey,
            size: 28,
          ),
          if (!isLast)
            Container(
              height: 40,
              width: 2,
              color: Colors.green, // Color of the line connecting the statuses
            ),
        ],
      ),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          if (currentStatus == status)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text("Completed", style: TextStyle(fontSize: 12, color: Colors.green)),
            ),
        ],
      ),
    ],
  );
}

// Helper function to check if the status is completed or reached
bool _isStatusCompleted(String currentStatus, String status) {
  const statusOrder = [
    'Order Placed',
    'Shipped',
    'Out for delivery',
    'Delivered'
  ];

  int currentIndex = statusOrder.indexOf(currentStatus);
  int statusIndex = statusOrder.indexOf(status);

  return currentIndex >= statusIndex;
}

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.products,
  });

  final products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['productName'] ??
                              'Unknown Product',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                        Text('Size: ${product['size']}',style: const TextStyle(color: Colors.black),),
                        Text(
                            'Quantity: ${product['quantity']}',style: const TextStyle(color: Colors.black),),
                        Text('Price: ₹${product['price']}',style: const TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}