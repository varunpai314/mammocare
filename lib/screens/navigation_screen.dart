import 'package:flutter/material.dart';
import 'package:mammocare/screens/diet_and_nutrition_screen.dart';
import 'package:mammocare/screens/home_screen.dart';
import 'package:mammocare/screens/patient_medication.dart';
import 'package:mammocare/screens/physical_activity_screen.dart';
import 'package:mammocare/screens/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PatientMedication(
      patientId: '103iu3',
    ),
    const DietAndNutritionScreen(),
    const PhysicalActivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              }));
            },
          ),
          const SizedBox(width: 10),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color(0xFFE75D80),
        backgroundColor: const Color(0xFFFFDADA),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: ImageIcon(
              AssetImage('assets/icons/home.png'),
              color: Color(0xFF757575),
            ),
            selectedIcon: ImageIcon(
              AssetImage('assets/icons/home.png'),
              color: Color(0xFF211417),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('assets/icons/medicine.png'),
              color: Colors.grey.shade600,
            ),
            selectedIcon: const ImageIcon(
              AssetImage('assets/icons/medicine.png'),
              color: Color(0xFF211417),
            ),
            label: 'Medicine',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('assets/icons/food.png'),
              color: Colors.grey.shade600,
            ),
            selectedIcon: const ImageIcon(
              AssetImage('assets/icons/food.png'),
              color: Color(0xFF211417),
            ),
            label: 'Diet',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('assets/icons/exercise.png'),
              color: Colors.grey.shade600,
            ),
            selectedIcon: const ImageIcon(
              AssetImage('assets/icons/exercise.png'),
              color: Color(0xFF211417),
            ),
            label: 'Exercise',
          ),
        ],
      ),
    );
  }
}
