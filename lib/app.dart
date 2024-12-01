import 'package:flutter/material.dart';
import 'package:mammocare/screens/get_started_screen.dart';
import 'package:mammocare/screens/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mammocare/screens/navigation_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<bool> _getStartedScreenVisited;

  @override
  void initState() {
    super.initState();
    _getStartedScreenVisited = _checkIfGetStartedScreenVisited();
  }

  Future<bool> _checkIfGetStartedScreenVisited() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('getStartedScreenVisited') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MammoCare',
      theme: ThemeData(
        fontFamily: 'Quicksand', // Set the default font to Quicksand
      ),
      home: FutureBuilder<bool>(
        future: _getStartedScreenVisited,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else {
            final visited = snapshot.data ?? false;
            if (visited) {
              return const NavigationScreen();
            } else {
              return const GetStartedScreen();
            }
          }
        },
      ),
    );
  }
}
