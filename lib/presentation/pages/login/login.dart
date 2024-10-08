import 'package:clothing/core/constants/constants.dart';
import 'package:clothing/core/utils/validator.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/bloc/password/password_bloc.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/google_widget.dart';
import 'package:clothing/presentation/widgets/outlined_button_widget.dart';
import 'package:clothing/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


    @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context,state){
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 4),
              ),
            );
          } else if (state is AuthenticatedState) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        },
        builder: (context,state){
          if(state is AuthLoadingState){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100,),
                    // Image.asset('lib/assets/images/logo.png',
                    // alignment: Alignment.topLeft,
                    // width: 200,
                    // height: 200 ,
                    // fit: BoxFit.cover,
                    // ),
                    //const SizedBox(height: 100),
                    Text(loginTitle,
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 10.0),
                    Text(loginSubtitle,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          textField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            validator: (value) => Validator.validateEmail(value),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(height: 10.0),
                          BlocBuilder<PasswordBloc, PasswordState>(
                            builder: (context, passwordState) {
                              return textField(
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                labelText: 'Password',
                                isObscured: !passwordState.isVisible,
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<PasswordBloc>()
                                        .add(TogglePasswordVisibility());
                                  },
                                  icon: Icon(passwordState.isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                validator: (value) =>
                                    Validator.validatePassword(value),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              );
                            },
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Row(
                                children: [
                                  // Checkbox(value: true, onChanged: (value) {}),
                                  // Text(
                                  //   'Remember me',
                                  //   style: Theme.of(context).textTheme.headlineSmall,
                                  // )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/forgetPassword');
                                },
                                child: Text(
                                  'Forget password?',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          button(
                            buttonText: 'SIGN IN',
                            color: Colors.red,
                            buttonPressed: () {
                              
                              if (_formKey.currentState!.validate()) {
                                authBloc.add(LoginEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim()));
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          outlinedButton(
                            buttonText: 'CREATE ACCOUNT',
                            buttonPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'Or Sign in with',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const GoogleWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                        ),
            );
          }

        }, 
        
      ),
    );
  }
}



































































































