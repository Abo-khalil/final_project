import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsservice {
  static Future<String> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system-eirp.vercel.app/api/user/cuntact-us');

    final body = {
      "name": name.trim(),
      "email": email.trim(),
      "message": message.trim(),
    };

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] == "send Message") {
        print('Status code: ${response.statusCode}');
        return "success";
      } else {
        return "Unexpected response from server";
      }
    } else {
      return "Failed to send: ${response.statusCode}";
    }
  }
}
