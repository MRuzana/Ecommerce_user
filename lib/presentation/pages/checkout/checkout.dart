import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/presentation/pages/addresses/edit_add_address.dart';
import 'package:clothing/presentation/pages/addresses/add_addresses_widget.dart';
import 'package:clothing/presentation/widgets/addresses/display_addresses.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/edit_alert_widget.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  Checkout({super.key, this.totalQuantity, this.totalSum});

  final ShippingAddressImplementation shippingAddressImplementation =
      ShippingAddressImplementation();
  final int? totalQuantity;
  final double? totalSum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 225, 225),
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddAdressWidget(),
                  DisplayAddressWidget(
                      shippingAddressImplementation:
                          shippingAddressImplementation,showShippingSelection: true,),
                  const PaymentWidget(),
                  OrderSummaryWidget(
                      totalQuantity: totalQuantity, totalSum: totalSum),
                      const SizedBox(height: 50,),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: button(
              buttonText: 'SUBMIT ORDER',
              color: Colors.red,
              buttonPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.totalQuantity,
    required this.totalSum,
  });

  final int? totalQuantity;
  final double? totalSum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Total Quantity : $totalQuantity',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            'Total Amount : $totalSum',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  )),
            ],
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'lib/assets/images/card1.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const Text('**** **** **** 3947')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



  editAlert(BuildContext context, String documentId,
      Map<String, dynamic> addressData) {
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


