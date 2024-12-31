import 'package:flutter/material.dart';
import 'package:mammocare/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            print('Logged out');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: Icon(Icons.logout_rounded, color: Colors.red[900]),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red[900],
            textStyle: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            side: BorderSide(
              color: Colors.red[900]!,
              width: 0.75,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
          ),
        ),
      ),
    );
  }
}
