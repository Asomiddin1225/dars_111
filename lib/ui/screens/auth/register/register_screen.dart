import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:recipe_app/bloc/auth/auth_bloc.dart';
import 'package:recipe_app/data/models/auth/register_request.dart';
import 'package:recipe_app/ui/screens/home_Screen.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedAuthState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: SizedBox(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator:
                        RequiredValidator(errorText: 'Name is required').call,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator:
                        EmailValidator(errorText: 'Enter a valid email').call,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Phone number is required'),
                      MinLengthValidator(10,
                          errorText: 'Enter a valid phone number'),
                    ]).call,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: MinLengthValidator(6,
                            errorText:
                                'Password must be at least 6 digits long')
                        .call,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty) return 'Confirm your password';
                      if (val != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state is LoadingAuthState) {
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              final request = RegisterRequest(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                password: _passwordController.text,
                                passwordConfirmation:
                                    _passwordConfirmController.text,
                              );
                              context
                                  .read<AuthBloc>()
                                  .add(RegisterAuthEvent(request: request));
                            }
                          },
                          child: state is LoadingAuthState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Register'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
