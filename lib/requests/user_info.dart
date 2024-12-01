import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mammocare/models/patient.dart';

Future<Patient?> fetchPatient(String userId, String token) async {
  final url = Uri.parse('http://localhost:3000/api/user/profile/$userId');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Patient.fromJson(data);
  } else {
    print('Failed to load patient info');
    return null;
  }
}
