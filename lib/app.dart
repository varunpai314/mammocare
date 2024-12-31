import 'package:flutter/material.dart';
import 'package:mammocare/screens/get_started_screen.dart';
import 'package:mammocare/screens/login_screen.dart';
import 'package:mammocare/screens/navigation_screen.dart'; // Assuming this is the homepage screen
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<Map<String, dynamic>> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();
  }

  Future<Map<String, dynamic>> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final getStartedScreenVisited = prefs.getBool('getStartedScreenVisited') ?? false;
    final token = prefs.getString('token');
    return {
      'getStartedScreenVisited': getStartedScreenVisited,
      'token': token,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MammoCare',
      theme: ThemeData(
        fontFamily: 'Quicksand', // Set the default font to Quicksand
      ),
      home: FutureBuilder<Map<String, dynamic>>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else {
            final data = snapshot.data ?? {};
            final visited = data['getStartedScreenVisited'] ?? false;
            final token = data['token'];

            if (token != null && token.isNotEmpty) {
              return const NavigationScreen(); // Redirect to homepage if token is not null
            } else if (visited) {
              return const LoginScreen();
            } else {
              return const GetStartedScreen();
            }
          }
        },
      ),
    );
  }
}
