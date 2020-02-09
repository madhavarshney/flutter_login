import 'package:flutter/foundation.dart';

class LoginData {
  final String email;
  final String password;

  LoginData({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return '$runtimeType($email, $password)';
  }
}

class SignupData {
  final String name;
  final String email;
  final String password;

  SignupData({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return '$runtimeType($name, $email, $password)';
  }
}
