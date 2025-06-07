import 'dart:convert';
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
      id: json['_id'] ?? '', // تأكد من اسم المفتاح حسب API
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
Future<void> createWaterTank({
  required String nameTank,
  required int amountTank,
  required int maxTank,
  required int minTank,
}) async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('Error: Token not found. Make sure the user is logged in.');
      return;
    }

    final url = Uri.parse('https://automatic-irrigation-system.vercel.app//api/watertank/');

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

// Get All Water Tanks
Future<List<WaterTank>> getWaterTanks() async {
  try {
    final token = await _getToken();
    if (token == null) {
      print('Error: Token not found. Make sure the user is logged in.');
      return [];
    }

    final url = Uri.parse('https://automatic-irrigation-system.vercel.app/api/watertank');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => WaterTank.fromJson(json)).toList();
    } else {
      print('Failed to get water tanks: ${response.statusCode} - ${response.body}');
      return [];
    }
  } catch (e) {
    print('An error occurred while getting water tanks: $e');
    return [];
  }
}


