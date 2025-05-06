import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>?> loginUser(
      String email, String password, BuildContext context) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login Success: $data');
        return data;
      } else {
        final error = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error['message'] ?? 'Login failed'),
          backgroundColor: Colors.red,
        ));
        return null;
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }

  static Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'address': address,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Register Success: $data');
        return true;
      } else {
        final error = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error['message'] ?? 'Registration failed'),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }
}
