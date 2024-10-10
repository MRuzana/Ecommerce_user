import 'package:flutter/material.dart';

class AddAdressWidget extends StatelessWidget {
  const AddAdressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Shipping Addresses' ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addAddress');
              },
              icon: const Icon(
                Icons.add_circle,
              )),
        ],
      ),
    );
  }
}
