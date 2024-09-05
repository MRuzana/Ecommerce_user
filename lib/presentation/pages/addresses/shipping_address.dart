import 'package:clothing/core/utils/validator.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

class ShippingAddresses extends StatelessWidget {
  ShippingAddresses({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pinController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 225, 225),
        title: Text('Add Address'),
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
                      textField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) => Validator.validateUsername(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      textField(
                        controller: _addressController,
                        keyboardType: TextInputType.name,
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.place),
                        validator: (value) => Validator.validateAddress(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      textField(
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        labelText: 'Pin',
                        prefixIcon: const Icon(Icons.pin),
                        validator: (value) => Validator.validatePin(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      textField(
                        controller: _stateController,
                        keyboardType: TextInputType.name,
                        labelText: 'State',
                        prefixIcon: const Icon(Icons.location_city),
                        validator: (value) => Validator.validateState(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            button(
              buttonText: 'SAVE ADDRESS',
              color: Colors.red,
              buttonPressed: () {},
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}