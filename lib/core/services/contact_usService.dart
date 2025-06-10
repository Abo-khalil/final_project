import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsService {
  static Future<String> sendMessage({
    required String subject,
    required String message,
  }) async {
    final url = Uri.parse(
        'https://automatic-irrigation-system.vercel.app/api/user/cuntact-us');

    final body = {
      "subject": subject.trim(),
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

print("Status: ${response.statusCode}");
print("Response Body: ${response.body}");

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  print("Decoded data: $data");

  if (data['message'] == "Message sent successfully") {
  return "success";
} else {
  return "Unexpected response from server";
}

} else {
  return "Failed to send: ${response.statusCode} - ${response.body}";
}

  }
}
