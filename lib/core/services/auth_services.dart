import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>?> loginUser(
      String email, String password, BuildContext context) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //print('Login Success: $data');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('userId', data['userId']);
        final token = prefs.getString('token');

        print(token);
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
        'https://automatic-irrigation-system.vercel.app/api/auth/register');

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

  static Future<String?> sendOtp(String email) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/auth/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 200) {
      return "OTP sent successfully";
    } else {
      return jsonDecode(response.body)["message"] ?? "Error sending OTP";
    }
  }

  static Future<String?> resetPassword(
      String email, String otp, String newPassword) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/auth/forget-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
    if (response.statusCode == 200) {
      return "Password reset successfully";
    } else {
      return jsonDecode(response.body)["message"] ?? "Error resetting password";
    }
  }

  static Future<bool> verifyOtp(String email, String otp) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/auth/verify-account');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "otp": otp}),
    );

    print('Verify OTP Status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'OTP verification failed');
    }
  }
}
