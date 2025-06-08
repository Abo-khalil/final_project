import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WaterTank {
  final String id;
  final String nameTank;
  final int amountTank;
  final int maxTank;
  final int minTank;

  WaterTank({
    required this.id,
    required this.nameTank,
    required this.amountTank,
    required this.maxTank,
    required this.minTank,
  });

  factory WaterTank.fromJson(Map<String, dynamic> json) {
    return WaterTank(
      id: json['_id'] ?? '',
      nameTank: json['nameTank'] ?? '',
      amountTank: json['amountTank'] ?? 0,
      maxTank: json['maxTank'] ?? 0,
      minTank: json['minTank'] ?? 0,
    );
  }
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

// Create Water Tank
Future<bool> createWaterTank({
  required String nameTank,
  required int amountTank,
  required int maxTank,
  required int minTank,
}) async {
  try {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      print('Error: Token not found or empty.');
      return false;
    }

    print('Using token: $token'); // Debug

    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/watertank/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nameTank': nameTank,
        'amountTank': amountTank,
        'maxTank': maxTank,
        'minTank': minTank,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error creating water tank: $e');
    return false;
  }
}

// Get Water Tanks by User ID
Future<List<WaterTank>> getWaterTanks() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId'); // تأكد أنك خزّنت userId مسبقًا

    if (token == null || userId == null) {
      print(
          'Error: Token or User ID not found. Make sure the user is logged in.');
      return [];
    }

    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/watertank/$userId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];
      return data.map((json) => WaterTank.fromJson(json)).toList();
    } else {
      print(
          'Failed to get water tanks: ${response.statusCode} - ${response.body}');
      return [];
    }
  } catch (e) {
    print('An error occurred while getting water tanks: $e');
    return [];
  }
}

Future<void> editWaterTank({
  required BuildContext context,
  required String tankId,
  required String nameTank,
  required int amountTank,
  required int maxTank,
  required int minTank,
}) async {
  final url = Uri.parse(
    'https://automatic-irrigation-system.vercel.app/api/watertank/$tankId',
  );

  final body = {
    "nameTank": nameTank,
    "amountTank": amountTank,
    "maxTank": maxTank,
    "minTank": minTank,
  };

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found. Please log in again.')),
      );
      return;
    }

    log("Sending PUT request to edit tank...");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    log("Response status: ${response.statusCode}");
    log("Response body: ${response.body}");
    print('Editing tank with id: $tankId');

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tank updated successfully!')),
      );
      Navigator.of(context).pop(); // إغلاق النافذة إذا كان تعديل من Dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: ${response.body}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
