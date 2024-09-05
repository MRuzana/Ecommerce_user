import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 225, 225),
      appBar: AppBar(
        title: const Center(child: Text('Cart'),
        
        ),
        backgroundColor: Color.fromARGB(255, 233, 225, 225) ,
        // leading: 
        //   IconButton(onPressed: (){
        //     Navigator.pushNamed(context, '/home',);
        //   }, 
        //   icon: Icon(Icons.arrow_back)
        // ),
      ),

      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 135,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 80.0,
                                        height: 80.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'lib/assets/images/product1.jpeg',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                     const  Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('name'),
                                          const SizedBox(height: 5.0),
                                          Text('₹price'),
                                          Text(
                                            '₹itemTotalPrice',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(onPressed: () {
                                             
                                      },icon: const Icon(Icons.remove_circle,color: Colors.black,),
                                      ),
                                      Text('1',style: const TextStyle(color: Colors.black),),
                                      IconButton(onPressed: (){

                                      }, icon: const Icon(Icons.add_circle,color: Colors.black),)
                                    ],
                                  )
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  IconButton(onPressed: (){}, 
                                  icon: Icon(Icons.delete,color: Colors.red,))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1 items in cart',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text('Sub total price : ₹sum',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20,),
                  button(buttonText: 'CHECK OUT',color: Colors.red, buttonPressed: (){
                    Navigator.pushNamed(context, '/checkout');
                  }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
