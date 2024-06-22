import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCkrkqgBBHc5HgIKM4CGSC354yHD1auqUU'),
      body: json.encode({
        'email': data.name,
        'password': data.password,
        'returnSecureToken': true,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return null; // Sign-in berhasil
    } else {
      return responseData['error']['message'];
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCkrkqgBBHc5HgIKM4CGSC354yHD1auqUU'),
      body: json.encode({
        'email': data.name!,
        'password': data.password!,
        'returnSecureToken': true,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return null; // Sign-up berhasil
    } else {
      return responseData['error']['message'];
    }
  }

  Future<String?> _recoverPassword(String name) async {
    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyCkrkqgBBHc5HgIKM4CGSC354yHD1auqUU'),
      body: json.encode({
        'requestType': 'PASSWORD_RESET',
        'email': name,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return null; // Email reset password telah dikirim
    } else {
      return responseData['error']['message'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My-INA',
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
