import 'package:flutter/material.dart';
import 'package:mammocare/screens/get_started_screen.dart';
// import 'package:mammocare/screens/navigation_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MammoCare',
      theme: ThemeData(
        fontFamily: 'Quicksand', // Set the default font to Quicksand
      ),
      home: const GetStartedScreen(),
    );
  }
}
