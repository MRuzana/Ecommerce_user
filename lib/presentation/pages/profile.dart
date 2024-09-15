import 'package:clothing/data/repositories/shipping_address_impl.dart';
import 'package:clothing/domain/model/profile_list_model.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/bloc/user_details/user_bloc.dart';
import 'package:clothing/presentation/pages/addresses/saved_address.dart';
import 'package:clothing/presentation/pages/orders.dart';
import 'package:clothing/presentation/pages/payment/payment_method.dart';
import 'package:clothing/presentation/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: 'Payment Methods',
        leadingIcon: const Icon(Icons.payment_rounded),
        trailingIcon: const Icon(Icons.chevron_right)),
    ProfileList(
        title: 'Settings',
        leadingIcon: const Icon(Icons.settings),
        trailingIcon: const Icon(Icons.chevron_right)),
    ProfileList(
        title: 'Logout',
        leadingIcon: const Icon(Icons.logout),
        trailingIcon: const Icon(Icons.chevron_right)),
  ];

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    context.read<UserBloc>().add(FetchUserDetails(userId: userId));

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
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.person_3,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoadingState) {
                              return const CircularProgressIndicator();
                            } else if (state is UserLoadedState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    state.email,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 82, 82, 82), fontSize: 15),
                                  ),
                                ],
                              );
                            } else if (state is UserErrorState) {
                              state.errorMessage;
                            }

                            return const Text('Unknown state');
                          },
                        ),
                      ),
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
    if (title == 'My Orders') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Orders()));
    } else if (title == 'Shipping Addresses') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SavedAddresses(shippingAddressImplementation: shippingAddressImplementation,)));
    } else if (title == 'Payment Methods') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PaymentMethod()));
    } else if (title == 'Settings') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AppSettings()));
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
