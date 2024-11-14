import 'package:flutter/material.dart';
import 'package:mammocare/screens/navigation_screen.dart';

class DataAccessScreen extends StatefulWidget {
  const DataAccessScreen({super.key});

  @override
  DataAccessScreenState createState() => DataAccessScreenState();
}

class DataAccessScreenState extends State<DataAccessScreen> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                '"Your Data Matters"',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'To provide you with the personalized care and support, we kindly ask for your demographic details and medication information. Rest assured, your data is safe with us and will never be shared with any third parties.',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'It will solely be used for diagnostic purposes and to enhance our understanding through research, ensuring we offer you the most effective treatment and support. Thank you for helping us improve our services and care for you better.',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    checkBox(),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "I confirm that in providing information about myself and submitting this form, I give MammoCare my permission to store and use the information I provide for patient care and study purposes.",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (val) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please confirm the data access agreement'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE75D80),
                  minimumSize:
                      Size(0.85 * MediaQuery.of(context).size.width, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          val = !val;
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: val ? const Color(0xFF43DB57) : Colors.transparent,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: const Color(0xFF43DB57),
            width: 2,
          ),
        ),
        child: val
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              )
            : null,
      ),
    );
  }
}
