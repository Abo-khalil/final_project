import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createWaterTank({
  required String nameTank,
  required int amountTank,
  required int maxTank,
  required int minTank,
}) async {
  final url = Uri.parse('https://automatic-irrigation-system-eirp.vercel.app/api/watertank/');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'nameTank': nameTank,
      'amountTank': amountTank,
      'maxTank': maxTank,
      'minTank': minTank,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Tank created successfully');
  } else {
    print('Failed to create tank: ${response.statusCode} - ${response.body}');
  }
}
