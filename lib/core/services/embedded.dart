import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Embedded {
  static Future<double?> fetchHumidity(String plantId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('No token found in SharedPreferences');
      return null;
    }

    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/plants/$plantId/humidity');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Humidity response: $data");

        if (data['humidity'] != null) {
          return double.parse(data['humidity'].toString());
        } else {
          print("No 'humidity' key found");
          return null;
        }
      } else {
        print("Failed to fetch humidity: ${response.statusCode}");
        print("Body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return null;
    }
  }
}
