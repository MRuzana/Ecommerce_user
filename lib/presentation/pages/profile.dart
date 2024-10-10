import 'package:clothing/data/repositories/order_repo_impl.dart';
import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/domain/model/profile_list_model.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/pages/addresses/saved_address.dart';
import 'package:clothing/presentation/pages/order/order.dart';
import 'package:clothing/presentation/pages/about/about.dart';
import 'package:clothing/presentation/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final List<ProfileList> items = [
    ProfileList(
        title: 'My Orders',
        leadingIcon: const Icon(Icons.receipt_long),
        trailingIcon: const Icon(
          Icons.chevron_right,
        )),
    ProfileList(
        title: 'Shipping Addresses',
        leadingIcon: const Icon(Icons.location_on),
        trailingIcon: const Icon(Icons.chevron_right)),
    ProfileList(
        title: 'About App',
        leadingIcon: const Icon(Icons.settings),
        trailingIcon: const Icon(Icons.chevron_right)),
    ProfileList(
        title: 'Logout',
        leadingIcon: const Icon(Icons.logout),
        trailingIcon: const Icon(Icons.chevron_right)),
  ];

  @override
  Widget build(BuildContext context) {
    //final userId = FirebaseAuth.instance.currentUser!.uid;
    //context.read<UserBloc>().add(FetchUserDetails(userId: userId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(230),
        child: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.person_3,
                          size: 50,
                        ),
                      ),
                      UserDetails(),
                    ],
                  ),
                  const SizedBox(height: 20), // Adjust the space as needed
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title!),
                  leading: Icon(items[index].leadingIcon!.icon),
                  trailing: GestureDetector(
                      onTap: () {
                        _handleOnTap(
                          context,
                          items[index].title!,
                        );
                      },
                      child: Icon(items[index].trailingIcon!.icon)),
                );
              })),
    );
  }

  void _handleOnTap(BuildContext context, String title) {
    ShippingAddressImplementation shippingAddressImplementation = ShippingAddressImplementation();
    OrderRepositoryImplementation orderRepositoryImplementation = OrderRepositoryImplementation();
    if (title == 'My Orders') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Order(orderRepositoryImplementation: orderRepositoryImplementation,)));
    } else if (title == 'Shipping Addresses') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SavedAddresses(shippingAddressImplementation: shippingAddressImplementation,)));
   
    } else if (title == 'About App') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AboutApp()));
    } else {
      signoutAlert(context);
    }
  }

  signoutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              'Alert',
              style: TextStyle(fontSize: 14),
            ),
            content: const Text(
              'Do you want to  logout?',
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    signout(context);
                  },
                  child: const Text('YES')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NO')),
            ],
          );
        }));
  }

  signout(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(LogoutEvent());
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}



