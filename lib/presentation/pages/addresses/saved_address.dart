import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/presentation/pages/addresses/add_addresses_widget.dart';
import 'package:clothing/presentation/widgets/addresses/display_addresses.dart';
import 'package:flutter/material.dart';

class SavedAddresses extends StatelessWidget {
  const SavedAddresses({super.key, required this.shippingAddressImplementation});
    final ShippingAddressImplementation shippingAddressImplementation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const AddAdressWidget(),
            DisplayAddressWidget(shippingAddressImplementation: shippingAddressImplementation,showShippingSelection: false,),

          ],
        )
   
     ),
    );
  }
}