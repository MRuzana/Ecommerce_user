import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 225, 225) ,
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping Addresses',style: Theme.of(context).textTheme.headlineMedium,),
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, '/address');
                  }, icon: Icon(Icons.add_circle))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}