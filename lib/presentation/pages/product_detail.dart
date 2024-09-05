import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/product_detail/product_listview.dart';
import 'package:flutter/material.dart';


class ProductDetail extends StatelessWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductListView(productId: productId),
                    const SizedBox(height: 30,),
                                                   
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: button(
                buttonText: 'ADD TO CART',
                color: Colors.red,
                buttonPressed: () {
                 
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: button(
                buttonText: 'BUY NOW',
                color: Colors.green,
                buttonPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    


