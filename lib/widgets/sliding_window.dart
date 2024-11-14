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
        if (nextPage >= 5) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInToLinear,
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
          // padding: const EdgeInsets.all(8.0),
          height: 200, // Adjust the height as needed
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  _buildCard(
                    context,
                    'Chemotherapy Details',
                    Icons.local_hospital,
                    Colors.pinkAccent,
                    () {
                      // Navigate to chemotherapy details
                    },
                  ),
                  _buildCard(
                    context,
                    'Book an Appointment',
                    Icons.calendar_today,
                    Colors.blueAccent,
                    () {
                      // Open calendar
                    },
                  ),
                  _buildCard(
                    context,
                    'Stressed?',
                    Icons.self_improvement,
                    Colors.greenAccent,
                    () {
                      // Open mindfulness and relaxation techniques
                    },
                  ),
                  _buildCard(
                    context,
                    'Education',
                    Icons.school,
                    Colors.orangeAccent,
                    () {
                      // Navigate to education details (from different file)
                    },
                  ),
                  _buildCard(
                    context,
                    'Drugs to be Taken',
                    Icons.medical_services,
                    Colors.purpleAccent,
                    () {
                      // Show drug name and time
                    },
                  ),
                ],
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
                      width: _currentPage == index ? 16.0 : 8.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index
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
}
