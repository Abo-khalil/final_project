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
        'https://automatic-irrigation-system.vercel.app/api/system');

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



 static Future<dynamic> fetchGlobalSystemData() async {
  final url = Uri.parse(
    'https://automatic-irrigation-system.vercel.app/api/system/',
  );

  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return 'No token found in SharedPreferences.';

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 401) {
      return 'Unauthorized: Invalid or expired token.';
    } else {
      return 'Failed with status ${response.statusCode}: ${response.body}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}


static Future<void> editSystem({
    required BuildContext context,
    required String name,
    required String description,
    required int amountWater,
    required int irrigationEvery,
    required String duration,
    required String type,
    required String systemId,
  }) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/system/$systemId');

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
      final response = await http.put(
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
  Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
Future<bool> deleteSystem(String systemId) async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('Error: Token not found. Make sure the user is logged in.');
      return false;
    }

    final url = Uri.parse('https://automatic-irrigation-system.vercel.app/api/system/67f911a7ae724f11f3bddfab');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Water tank deleted successfully.');
      return true;
    } else {
      print('Failed to delete water tank: ${response.statusCode} - ${response.body}');
      return false;
    }
  } catch (e) {
    print('An error occurred while deleting water tank: $e');
    return false;
  }
}
}