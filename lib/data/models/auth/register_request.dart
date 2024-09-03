import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      passwordConfirmation: map['password_confirmation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }

  @override
  List<Object> get props {
    return [name, email, phone, password, passwordConfirmation];
  }
}