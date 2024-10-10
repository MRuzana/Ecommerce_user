// ignore_for_file: use_build_context_synchronously

import 'package:clothing/core/utils/validator.dart';
import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

class AddAddresses extends StatelessWidget {
  AddAddresses({super.key,this.documentId,this.addressData});

  final String? documentId;
  final Map<String,dynamic>? addressData;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pinController = TextEditingController();
  final _stateController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

     if (addressData != null) {
      _nameController.text = addressData!['name'] ?? '';
      _addressController.text = addressData!['address'] ?? '';
      _pinController.text = addressData!['postalCode'] ?? '';
      _stateController.text = addressData!['state'] ?? '';
      _phoneController.text = addressData!['phone'] ?? '';
    }
  
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(
        backgroundColor: Colors.red,
      
        title: addressData == null
        ? const Text('Add Address',style: TextStyle(
          color: Colors.white, 
        ),)
        : const Text('Edit Address',style: TextStyle(
          color: Colors.white,
        ),),
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color in light mode
  ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) => Validator.validateUsername(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _addressController,
                        keyboardType: TextInputType.name,
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.place),
                        validator: (value) => Validator.validateAddress(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        labelText: 'Pin',
                        prefixIcon: const Icon(Icons.pin),
                        validator: (value) => Validator.validatePin(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _stateController,
                        keyboardType: TextInputType.name,
                        labelText: 'State',
                        prefixIcon: const Icon(Icons.location_city),
                        validator: (value) => Validator.validateState(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone',
                        prefixIcon: const Icon(Icons.call),
                        validator: (value) =>
                            Validator.validatePhoneNumber(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            button(
              buttonText: addressData == null
              ? 'SAVE ADDRESS'
              : 'UPDATE ADDRESS',
              color: Colors.red,
              buttonPressed: () {               
                saveAddress(context);
              },
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  void saveAddress(BuildContext context) async {
    final ShippingAddressImplementation shippingAddressImplementation =
        ShippingAddressImplementation();

    if (_formKey.currentState!.validate()) {
      try {
        if (documentId == null) {
          // Add a new address
          await shippingAddressImplementation.saveAddress(
            _nameController.text,
            _addressController.text,
            _pinController.text,
            _stateController.text,
            _phoneController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Address saved successfully!'),
            ),
          );
        } else {
          // Update the existing address
          await shippingAddressImplementation.editAddress(
            documentId!,
            _nameController.text,
            _addressController.text,
            _pinController.text,
            _stateController.text,
            _phoneController.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Address updated successfully!'),
            ),
          );
        }

       Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to save address: $e'),
          ),
        );
      }
    }
  }
}
  