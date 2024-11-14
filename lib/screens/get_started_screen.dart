import 'package:flutter/material.dart';
import 'package:mammocare/screens/registration_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/splash.png',
              width: 160,
            ),
            // Rich text for 'Welcome to\n(bold-MammoCare)'
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Welcome to\n',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  height: 1.25,
                  color: Color(0xFF2A2A2A),
                ),
                children: [
                  TextSpan(
                    text: 'MammoCare',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                ],
              ),
            ),
            // Rich text for 'Your pocket companion towards\n(bold - Breast Cancer Care)'
            RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                text: 'Your pocket companion\ntowards ',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Breast Cancer Care',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Elevated button with 'Get Started' text
            ElevatedButton(
              onPressed: () {
                // Navigate to the registration screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE75D80),
                minimumSize: Size(0.85 * MediaQuery.of(context).size.width, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
