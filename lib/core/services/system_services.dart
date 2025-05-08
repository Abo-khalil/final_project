import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SystemServices {
 static Future<void> addSystem({
    required BuildContext context,
    required String name,
    required String description,
    required int amountWater,
    required int irrigationEvery,
    required int duration,
    required String type,
  }) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/system');

    final body = {
      'name': name,
      'description': description,
      'amountWater': amountWater,
      'IrrigationEvery': irrigationEvery,
      'duration': duration,
      'type': type,
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
      log("Sending request with token...");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      log("Response received");
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('System added successfully!')),
        );
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
}
