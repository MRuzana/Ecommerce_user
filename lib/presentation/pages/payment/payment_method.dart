import 'package:clothing/core/utils/validator.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({super.key});

  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 225, 225),
        title: const Text('Payment'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/images/card.jpeg',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20.0),
                textField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  labelText: 'Card number',
                  prefixIcon: const Icon(Icons.credit_card),
                  validator: (value) =>
                      Validator.validate(value, 'card number'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20.0),
                textField(
                  controller: _expDateController,
                  keyboardType: TextInputType.datetime,
                  labelText: 'Expiry date',
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  validator: (value) =>
                      Validator.validate(value, 'Expiry date'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20.0),
                textField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  labelText: 'CVV',
                  prefixIcon: const Icon(Icons.pin),
                  validator: (value) => Validator.validate(value, 'cvv'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20.0),
                button(buttonText: 'CONFIRM', 
                color: Colors.red,
                buttonPressed: (){
                  Navigator.of(context).pop();
                }),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
