import 'dart:convert';
import 'package:http/http.dart' as http;

String formatDateTimeWithoutMilliseconds(DateTime dateTime) {
  // Format DateTime to ISO-8601 without milliseconds
  return '${dateTime.toIso8601String().split('.').first}Z';
}

Future<void> sendFormResponse(
    String patientId, DateTime submittedAt, List<dynamic> responses) async {
  // Define the API endpoint
  const String url = 'http://localhost:3000/api/form/form';
//https://mamo-care-backend.onrender.com
  // Format the date to exclude milliseconds
  final String formattedDate = formatDateTimeWithoutMilliseconds(submittedAt);

  // Create the JSON body
  final Map<String, dynamic> body = {
    'patient_id': patientId,
    'submitted_at': formattedDate,
    'responses': responses
  };

  // Send the POST request
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Request was successful
      print('Form response submitted successfully');
    } else {
      // Handle other status codes
      print('Failed to submit form response: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print('Error occurred while submitting form response: $e');
  }
}

// void main() {
//   // Example data
//   String patientId = "103iu3";
//   DateTime submittedAt = DateTime.now();
//   List<dynamic> responses = ["response1", "response2", "response3"];

//   // Send the form response
//   sendFormResponse(patientId, submittedAt, responses);
// }
