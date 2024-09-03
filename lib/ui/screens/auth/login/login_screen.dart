import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:recipe_app/bloc/auth/auth_bloc.dart';
import 'package:recipe_app/data/models/auth/login_request.dart';
import 'package:recipe_app/data/models/user/user.dart';
import 'package:recipe_app/ui/screens/home_Screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthenticatedAuthState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }),
            (route) => false,
          );
          final User user = state.user;
          print("Ism: ${user.name}");
          print("Email: ${user.email}");
          print("phone: ${user.phone}");
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator:
                      EmailValidator(errorText: 'Enter a valid email').call,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: MinLengthValidator(6,
                          errorText: 'Password must be at least 6 digits long')
                      .call,
                ),
                const SizedBox(height: 20),
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
                            final request = LoginRequest(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            context
                                .read<AuthBloc>()
                                .add(LoginAuthEvent(request: request));
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
    );
  }
}
