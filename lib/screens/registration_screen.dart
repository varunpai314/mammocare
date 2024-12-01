import 'package:flutter/material.dart';
import 'package:mammocare/requests/auth.dart';
import 'package:mammocare/screens/login_screen.dart';
import 'package:mammocare/screens/otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController ipNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/splash.png', width: 160),
                  const SizedBox(height: 40),
                  RichText(
                    text: const TextSpan(
                      text: 'Our mission',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              ' is to help you\nimprove your disease\nmanagement and Quality of life',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildTextField(
                    context,
                    controller: ipNumberController,
                    labelText: 'IP Number',
                  ),
                  const SizedBox(height: 20),
                  _buildPhoneNumberField(context, phoneNumberController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final res =
                          await Auth.sendOtp('91${phoneNumberController.text}');

                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              phoneNumber: phoneNumberController.text,
                              ipNumber: ipNumberController.text,
                              orderId: res,
                              isFromRegistration: true,
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
                      'Register with OTP',
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
                        'Already have an account? ',
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
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

  Widget _buildTextField(BuildContext context,
      {required TextEditingController controller, required String labelText}) {
    return SizedBox(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 56,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF0F0F0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
        ),
        textInputAction: TextInputAction.next,
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
