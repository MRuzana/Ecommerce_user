import 'package:clothing/data/repositories/order_repo_impl.dart';
import 'package:clothing/presentation/pages/order/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Order extends StatelessWidget {
  const Order({super.key, required this.orderRepositoryImplementation});

  final OrderRepositoryImplementation orderRepositoryImplementation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color.fromARGB(255, 233, 225, 225),
        appBar: AppBar(
          title: const Text(
            'My orders',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: orderRepositoryImplementation.fetchOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading orders'));
              }
              // Check if there is data in the snapshot
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No orders found'),
                );
              }

              // Fetch the list of documents directly from the snapshot
              final orders = snapshot.data!.docs;

              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final orderData =
                        orders[index].data() as Map<String, dynamic>;

                    final orderId = orderData['order_id'];
                    final timestamp = orderData['timestamp'] as Timestamp;
                    final date = DateTime.fromMillisecondsSinceEpoch(
                        timestamp.millisecondsSinceEpoch);
                    final formattedDate = DateFormat('dd-MM-yyyy').format(date);
                    final int totalQty = orderData['totalQuantity'];
                    final double totalSum = orderData['totalAmount'];
                    final String status = orderData['status'];

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : const Color.fromARGB(255, 239, 238, 238),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order Id : $orderId',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                'Quantity : ${totalQty.toString()}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Tot amt : ${totalSum.toString()}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetails(
                                                        orderId: orderId,
                                                        status: status,
                                                      )));
                                        },
                                        child: const Text(
                                          'Details',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ));
  }
}
