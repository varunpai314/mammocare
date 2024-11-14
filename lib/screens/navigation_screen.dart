import 'package:flutter/material.dart';
import 'package:mammocare/screens/diet_and_nutrition_screen.dart';
import 'package:mammocare/screens/home_screen.dart';
import 'package:mammocare/screens/medication_screen.dart';
import 'package:mammocare/screens/physical_activity_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const MedicationScreen(),
    const DietAndNutritionScreen(),
    const PhysicalActivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F8),
        leading: Image.asset(
          'assets/splash.png',
          scale: 0.5,
        ),
        title: Image.asset(
          'assets/branding.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 32,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_2_rounded, size: 32),
            onPressed: () {},
          ),
        ],
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
          indicatorColor: const Color(0xFFE75D80),
          backgroundColor: const Color(0xFFFFF8F8),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/icons/home.png'),
                color: Colors.grey.shade500,
              ),
              selectedIcon: const ImageIcon(
                AssetImage('assets/icons/home.png'),
                color: Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/icons/medicine.png'),
                color: Colors.grey.shade500,
              ),
              selectedIcon: const ImageIcon(
                AssetImage('assets/icons/medicine.png'),
                color: Colors.white,
              ),
              label: 'Medicine',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/icons/food.png'),
                color: Colors.grey.shade500,
              ),
              selectedIcon: const ImageIcon(
                AssetImage('assets/icons/food.png'),
                color: Colors.white,
              ),
              label: 'Diet',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/icons/exercise.png'),
                color: Colors.grey.shade500,
              ),
              selectedIcon: const ImageIcon(
                AssetImage('assets/icons/exercise.png'),
                color: Colors.white,
              ),
              label: 'Exercise',
            ),
          ]),
    );
  }
}
