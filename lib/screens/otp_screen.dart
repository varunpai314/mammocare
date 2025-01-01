import 'package:flutter/material.dart';
import 'package:mammocare/requests/auth.dart';
import 'package:mammocare/screens/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String orderId;
  final bool isFromRegistration;
  final String? ipNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.orderId,
    required this.isFromRegistration,
    required this.ipNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Create a list of 6 TextEditingControllers
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose all controllers to free up resources
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Future<void> _savePatientDetails(Map<String, dynamic> patient) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('patientName', patient['patientName']);
  //   await prefs.setString('ipNumber', patient['ipNumber']);
  //   await prefs.setString('bloodGroup', patient['bloodGroup']);
  //   await prefs.setStringList(
  //       'patientContacts', List<String>.from(patient['patientContacts']));
  //   if (patient['height'] != null) {
  //     await prefs.setInt('height', patient['height']);
  //   }
  //   if (patient['weight'] != null) {
  //     await prefs.setInt('weight', patient['weight']);
  //   }
  //   if (patient['dob'] != null) {
  //     await prefs.setString('dob', patient['dob']);
  //   }
  //   if (patient['doa'] != null) {
  //     await prefs.setString('doa', patient['doa']);
  //   }
  //   if (patient['dod'] != null) {
  //     await prefs.setString('dod', patient['dod']);
  //   }
  //   if (patient['dose'] != null) {
  //     await prefs.setString('dose', patient['dose']);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2A2A),
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Enter the OTP sent to +91${widget.phoneNumber}',
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2A2A2A),
                ),
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 48,
                            height: 60,
                            child: Center(
                              child: TextField(
                                controller: otpControllers[index],
                                textInputAction: index < 5
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1 && index < 5) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty && index > 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final otp = otpControllers
                              .map((controller) => controller.text)
                              .join();
                          final veriToken = await Auth.verifyOtp(
                            '91${widget.phoneNumber}',
                            otp,
                            widget.orderId,
                          );
                          if (widget.isFromRegistration) {
                            final res =
                                await Auth.signUp(widget.ipNumber!, veriToken);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('token', res['token']);
                            print(res);

                            await prefs.setString('ipNumber', widget.ipNumber!);
                            await prefs.setString('userId', res['user_id']);
                          } else {
                            final token = await Auth.signIn(veriToken);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('token', token['token']);
                            await prefs.setString('userId', token['user_id']);

                            // Save patient details to shared_preferences
                            // await _savePatientDetails(token['patient']);
                            print(token);
                          }
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigationScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE75D80),
                          minimumSize: Size(
                              0.85 * MediaQuery.of(context).size.width, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
