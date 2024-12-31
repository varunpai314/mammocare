import 'package:flutter/material.dart';
import 'package:mammocare/screens/data_access_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  Future<void> _setGetStartedScreenVisited() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('getStartedScreenVisited', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              onPressed: () async {
                await _setGetStartedScreenVisited();
                // Navigate to the registration screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataAccessScreen(),
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
