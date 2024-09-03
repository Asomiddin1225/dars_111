import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String token;

  const AuthResponse({
    required this.token,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(token: map['token']);
  }

  @override
  List<Object> get props => [token];
}