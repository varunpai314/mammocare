import 'package:flutter/material.dart';

class SlidingWindow extends StatefulWidget {
  const SlidingWindow({super.key});

  @override
  SlidingWindowState createState() => SlidingWindowState();
}

class SlidingWindowState extends State<SlidingWindow> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.linear,
        );
        setState(() {
          _currentPage = nextPage;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200, // Adjust the height as needed
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  int displayIndex = index % 5;
                  return _buildCard(
                    context,
                    _getCardTitle(displayIndex),
                    _getCardIcon(displayIndex),
                    _getCardColor(displayIndex),
                    () {
                      // Handle card tap
                    },
                  );
                },
              ),
              Positioned(
                bottom: 16.0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(5, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: (_currentPage % 5) == index ? 16.0 : 8.0,
                      decoration: BoxDecoration(
                        color: (_currentPage % 5) == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCardTitle(int index) {
    switch (index) {
      case 0:
        return 'Chemotherapy Details';
      case 1:
        return 'Book an Appointment';
      case 2:
        return 'Stressed?';
      case 3:
        return 'Education';
      case 4:
        return 'Drugs to be Taken';
      default:
        return '';
    }
  }

  IconData _getCardIcon(int index) {
    switch (index) {
      case 0:
        return Icons.local_hospital;
      case 1:
        return Icons.calendar_today;
      case 2:
        return Icons.self_improvement;
      case 3:
        return Icons.school;
      case 4:
        return Icons.medical_services;
      default:
        return Icons.error;
    }
  }

  Color _getCardColor(int index) {
    switch (index) {
      case 0:
        return Colors.pinkAccent;
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }
}
