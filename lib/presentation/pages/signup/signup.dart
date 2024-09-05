import 'package:clothing/core/constants/constants.dart';
import 'package:clothing/core/utils/validator.dart';
import 'package:clothing/domain/model/user_model.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/bloc/checkbox/checkbox_bloc.dart';
import 'package:clothing/presentation/bloc/password/password_bloc.dart';
import 'package:clothing/presentation/widgets/button_widget.dart';
import 'package:clothing/presentation/widgets/google_widget.dart';
import 'package:clothing/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final authbloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthenticatedState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/verifyEmail', (route) => false);
        });
      }

      else if(state is AuthErrorState){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));

      }
      
    },
    child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset('lib/assets/images/logo.png',
              // width: 150.0,
              // height: 150.0 ,
              // ),

              Text(signupTitle,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 10.0),

              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      textField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Username',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) => Validator.validateUsername(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      textField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        validator: (value) => Validator.validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      textField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone number',
                        prefixIcon: const Icon(Icons.phone),
                        validator: (value) =>
                            Validator.validatePhoneNumber(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10.0),
                      BlocBuilder<PasswordBloc, PasswordState>(
                          builder: (context, state) {
                        return textField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          labelText: 'Password',
                          isObscured: !state.isVisible,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<PasswordBloc>()
                                  .add(TogglePasswordVisibility());
                            },
                            icon: Icon(state.isVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          validator: (value) =>
                              Validator.validatePassword(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        );
                      }),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BlocBuilder<CheckboxBloc, CheckBoxState>(
                                  builder: (context, state) {
                                return Checkbox(
                                    value: state.isChecked,
                                    onChanged: (value) {
                                      context
                                          .read<CheckboxBloc>()
                                          .add(ToggleCheckBox());
                                    });
                              }),
                              Text(
                                'I Agree to privacy policy and terms of use',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      button(
                          buttonText: 'CREATE ACCOUNT',
                          color: Colors.red,
                          buttonPressed: () {
                            signUp(context);
                            
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Or Sign up with',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const GoogleWidget(),
                    ],
                  )),
            ],
          ),
        ))),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
   
    final authbloc = BlocProvider.of<AuthBloc>(context);
    
    final checkboxState = context.read<CheckboxBloc>().state;
    final String? checkBoxValidationMessage =
        Validator.validateCheckbox(checkboxState.isChecked);
    if (checkBoxValidationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(10),
          content: Text(checkBoxValidationMessage)),
      );
      return;
    }

    if (!_formkey.currentState!.validate()) {

      return;
    }

    UserModel user = UserModel(
      username: _nameController.text.trim(),
      password: _passwordController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),

    );
    authbloc.add(SignUpEvent(user: user));
  }
}
