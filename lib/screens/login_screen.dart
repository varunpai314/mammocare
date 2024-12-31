import 'package:flutter/material.dart';
import 'package:mammocare/requests/auth.dart';
import 'package:mammocare/screens/otp_screen.dart';
import 'package:mammocare/screens/registration_screen.dart';
import 'package:mammocare/screens/navigation_screen.dart'; // Import the NavigationScreen
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/splash.png', width: 160),
                  const SizedBox(height: 40),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Welcome Back!\n',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' Please login to continue',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildPhoneNumberField(context, phoneNumberController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final res =
                          await Auth.sendOtp('91${phoneNumberController.text}');
                      print("otp Sent");
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              phoneNumber: phoneNumberController.text,
                              ipNumber: '',
                              orderId: res,
                              isFromRegistration: false,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE75D80),
                      minimumSize: Size(0.85 * size.width, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Login with OTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFE75D80),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(
      BuildContext context, TextEditingController controller) {
    return SizedBox(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 56,
      child: Row(
        children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              border: Border.all(
                color: const Color(0xFFF0F0F0),
                width: 2.0,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: const Center(
              child: Text(
                '+91',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '00000 00000',
                labelStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFF0F0F0),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
