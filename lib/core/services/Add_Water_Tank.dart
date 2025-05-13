import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> createWaterTank({
  required String nameTank,
  required int amountTank,
  required int maxTank,
  required int minTank,
}) async {
  try {
    // Get the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Error: Token not found. Make sure the user is logged in.');
      return;
    }

    final url = Uri.parse('https://automatic-irrigation-system-eirp.vercel.app/api/watertank/');

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

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Water tank created successfully.');
    } else {
      print('Failed to create water tank: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('An error occurred while creating the water tank: $e');
  }
}