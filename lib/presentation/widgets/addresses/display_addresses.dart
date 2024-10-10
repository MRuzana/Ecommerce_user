// ignore_for_file: use_build_context_synchronously

import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/presentation/bloc/address_checkbox/address_checkbox_bloc.dart';
import 'package:clothing/presentation/pages/checkout/checkout.dart';
import 'package:clothing/presentation/widgets/delete_alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayAddressWidget extends StatelessWidget {
  const DisplayAddressWidget(
      {super.key,
      required this.shippingAddressImplementation,
      this.showShippingSelection = true});

  final ShippingAddressImplementation shippingAddressImplementation;
  final bool showShippingSelection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: shippingAddressImplementation.fetchAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading addresses'));
          }

          // Check if there is data in the snapshot
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No addresses found'));
          }

          // Fetch the list of documents directly from the snapshot
          final addresses = snapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addressData =
                    addresses[index].data() as Map<String, dynamic>;
                final documentId = addresses[index].id;

                final name = addressData['name'] ?? 'No Name';
                final address = addressData['address'] ?? 'No Address';
                final pin = addressData['postalCode'] ?? 'No Pin';
                final state = addressData['state'] ?? 'No State';

                return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      width: double.infinity,
                      height: showShippingSelection ? 160 : 130,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // Text color in dark mode
            : const Color.fromARGB(255, 239, 238, 238), 
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name ,style: const TextStyle(color: Colors.black),),
                                Text(address,style: const TextStyle(color: Colors.black),),
                                Text(pin,style: const TextStyle(color: Colors.black),),
                                Text(state,style: const TextStyle(color: Colors.black),),
                                if (showShippingSelection)
                                  BlocBuilder<AddressCheckboxBloc,
                                      AddressCheckBoxState>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                              value:
                                                  state.isSelected(documentId),
                                              onChanged: (value) {
                                                context
                                                    .read<AddressCheckboxBloc>()
                                                    .add(ToggleAddressCheckbox(
                                                        documentId:
                                                            documentId));
                                              }),
                                          const Text(
                                            'Select this as shipping address',style: TextStyle(color: Colors.black),),
                                    
                                        ],
                                      );
                                    },
                                  ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      editAlert(
                                          context, documentId, addressData);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteAlert(context, documentId);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              });
        });
  }

  deleteAlert(BuildContext context, String documentId) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(onDelete: () async {
            try {
              await shippingAddressImplementation.deleteAddress(documentId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  margin: EdgeInsets.all(10),                 
                  content: Text('Address deleted successfully!'),
                ),
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  margin: const EdgeInsets.all(10),             
                  content: Text('Failed to delete address: $e'),
                ),
              );
            }
          });
        });
  }
}
