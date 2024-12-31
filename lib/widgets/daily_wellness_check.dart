import 'package:flutter/material.dart';
import 'package:mammocare/requests/send_form_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyWellnessCheckIn extends StatefulWidget {
  const DailyWellnessCheckIn({super.key});

  @override
  DailyWellnessCheckInState createState() => DailyWellnessCheckInState();
}

class DailyWellnessCheckInState extends State<DailyWellnessCheckIn> {
  final _formKey = GlobalKey<FormState>();
  bool? tookMedication;
  bool? movedAround;
  String symptoms = '';
  String mood = '';
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _loadFormState();
  }

  Future<void> _loadFormState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('savedDate');
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';

    if (savedDate == todayString) {
      setState(() {
        tookMedication = prefs.getBool('tookMedication');
        movedAround = prefs.getBool('movedAround');
        symptoms = prefs.getString('symptoms') ?? '';
        mood = prefs.getString('mood') ?? '';
        isSubmitted = prefs.getBool('isSubmitted') ?? false;
      });
    } else {
      await prefs.clear();
      await prefs.setString('savedDate', todayString);
    }
  }

  Future<void> _saveFormState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSubmitted', isSubmitted);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFFFFAFC),
      ),
      width: double.maxFinite,
      padding: const EdgeInsets.all(16.0),
      child: isSubmitted
          ? _buildThankYouMessage()
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Daily Wellness Check-In',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (isSubmitted)
                        const Icon(Icons.check_circle, color: Colors.green)
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildYesNoQuestion(
                    'Did you take your medications today?',
                    (value) => setState(() => tookMedication = value),
                    tookMedication,
                  ),
                  const SizedBox(height: 16),
                  _buildYesNoQuestion(
                    'Were you able to move around a bit today?',
                    (value) => setState(() => movedAround = value),
                    movedAround,
                  ),
                  const SizedBox(height: 16),
                  _buildTextInput(
                    'How are you feeling today? Any symptoms or side effects that you’d like to share?',
                    (value) => symptoms = value,
                  ),
                  const SizedBox(height: 16),
                  _buildMoodSelection(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          tookMedication != null &&
                          movedAround != null &&
                          mood.isNotEmpty) {
                        // Print details in debug mode
                        debugPrint('Medications Taken: $tookMedication');
                        debugPrint('Moved Around: $movedAround');
                        debugPrint('Symptoms: $symptoms');
                        debugPrint('Mood: $mood');
                        final List<dynamic> wellnessData = [
                          tookMedication,
                          movedAround,
                          symptoms,
                          mood,
                        ];

                        debugPrint('Wellness Data: ${wellnessData.toString()}');
                        sendFormResponse(
                            "KSH123", DateTime.now(), wellnessData);
                        setState(() {
                          isSubmitted = true;
                        });

                        // Save the form state
                        await _saveFormState();
                      } else {
                        // Show a snackbar or dialog to inform the user to answer all questions
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please answer all questions.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE75D80),
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Submit',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildYesNoQuestion(
      String question, ValueChanged<bool?> onChanged, bool? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('Yes'),
                value: true,
                fillColor: const WidgetStatePropertyAll(Color(0xFFE75D80)),
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool?>(
                title: const Text('No'),
                value: false,
                fillColor: const WidgetStatePropertyAll(Color(0xFFE75D80)),
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration(
            hintText: 'Type here',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 0.75,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildMoodSelection() {
    final moods = ['😊', '😐', '😔', '😡', '😴'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How’s your mood today?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: moods.map((emoji) {
            return ChoiceChip(
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 0.75,
              ),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(6),
              label: Text(emoji, style: const TextStyle(fontSize: 16)),
              selected: mood == emoji,
              checkmarkColor: Colors.white,
              selectedColor: const Color(0xFFE75D80),
              onSelected: (selected) {
                setState(() {
                  mood = selected ? emoji : '';
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildThankYouMessage() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Daily Wellness Check-In',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.check_circle_outline_rounded,
              color: Colors.green, size: 36),
        ],
      ),
    );
  }
}
