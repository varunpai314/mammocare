import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mammocare/constants.dart';

class Auth {
  String baseUrl = '${Constants.baseUrl}/api';
  static Future<String> sendOtp(String phoneNumber) async {
    final response = await http.post(
      Uri.parse(
          'https://mamo-care-backend-otp-initiator.onrender.com/api/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone_number': phoneNumber}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['orderId'];
    } else {
      throw Exception('Failed to send OTP: ${response.body}');
    }
  }

  static Future<String> verifyOtp(
      String phoneNumber, String otp, String orderId) async {
    final response = await http.post(
      Uri.parse('${Auth().baseUrl}/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone_number': phoneNumber,
        'otp': otp,
        'order_id': orderId,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['verification_token'];
    } else {
      throw Exception('Failed to verify OTP: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> signIn(String verificationToken) async {
    final response = await http.post(
      Uri.parse('${Auth().baseUrl}/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'verification_token': verificationToken}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> signUp(
      String ipNumber, String verificationToken) async {
    final response = await http.post(
      Uri.parse('${Auth().baseUrl}/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ip_number': ipNumber,
        'verification_token': verificationToken,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  static Future<String> logOut(String token) async {
    final response = await http.put(
      Uri.parse('${Auth().baseUrl}/user/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['msg'];
    } else {
      throw Exception('Failed to log out: ${response.body}');
    }
  }
}
