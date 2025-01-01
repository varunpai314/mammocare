import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mammocare/models/medication.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mammocare/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PatientMedication extends StatefulWidget {
  const PatientMedication({super.key});

  @override
  State<PatientMedication> createState() => _PatientMedicationState();
}

class _PatientMedicationState extends State<PatientMedication> {
  late Future<List<Medication>> _medicationsFuture;
  late Future<bool> _isMealTimeSetFuture = Future.value(false);
  late SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initializePreferences();
    _initializeNotifications();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _medicationsFuture = fetchMedications();
      _isMealTimeSetFuture = _isMealTimeSet();
    });
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<List<Medication>> fetchMedications() async {
    String? token = _prefs.getString('token');
    String? patientId = _prefs.getString('userId');
    if (token == null || token.isEmpty) {
      throw Exception('No token found');
    }

    print('Token: $token\nUser Id: $patientId'); // Debug print statement

    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/api/medication/patient/$patientId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status: ${response.statusCode}'); // Debug print statement
    print('Response body: ${response.body}'); // Debug print statement

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<Medication>((medication) => Medication.fromJson(medication))
          .toList();
    } else {
      throw Exception('Failed to load medications');
    }
  }

  Future<bool> _isMealTimeSet() async {
    return _prefs.containsKey('breakfast_time') &&
        _prefs.containsKey('lunch_time') &&
        _prefs.containsKey('dinner_time');
  }

  Future<void> _setMealTimes(
      TimeOfDay breakfast, TimeOfDay lunch, TimeOfDay dinner) async {
    await _prefs.setString('breakfast_time', breakfast.format(context));
    await _prefs.setString('lunch_time', lunch.format(context));
    await _prefs.setString('dinner_time', dinner.format(context));

    await _scheduleMealNotification(breakfast, 'Breakfast', 1);
    await _scheduleMealNotification(lunch, 'Lunch', 2);
    await _scheduleMealNotification(dinner, 'Dinner', 3);

    setState(() {
      _isMealTimeSetFuture = Future.value(true);
    });
  }

  Future<void> _scheduleMealNotification(
      TimeOfDay time, String mealTime, int id) async {
    final now = DateTime.now();
    final notificationTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Medication Reminder',
      'Take your $mealTime medicine.',
      tz.TZDateTime.from(notificationTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'meal_notifications',
          'Meal Notifications',
          channelDescription: 'Notifications for Meal Times',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Widget _buildMealTimeInput() {
    TimeOfDay? breakfastTime = const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay? lunchTime = const TimeOfDay(hour: 12, minute: 30);
    TimeOfDay? dinnerTime = const TimeOfDay(hour: 18, minute: 0);

    return AlertDialog(
      shadowColor: Colors.grey,
      elevation: 3,
      backgroundColor: Colors.white,
      title: const Text('Set Meal Times'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimePicker('Breakfast', (time) {
            setState(() {
              breakfastTime = time;
            });
          },
              initialTime: _prefs.getString('breakfast_time') != null
                  ? TimeOfDay(
                      hour: int.parse(
                          _prefs.getString('breakfast_time')!.split(":")[0]),
                      minute: int.parse(
                          _prefs.getString('breakfast_time')!.split(":")[1]),
                    )
                  : breakfastTime),
          _buildTimePicker('Lunch', (time) {
            setState(() {
              lunchTime = time;
            });
          },
              initialTime: _prefs.getString('lunch_time') != null
                  ? TimeOfDay(
                      hour: int.parse(
                          _prefs.getString('lunch_time')!.split(":")[0]),
                      minute: int.parse(
                          _prefs.getString('lunch_time')!.split(":")[1]),
                    )
                  : lunchTime),
          _buildTimePicker('Dinner', (time) {
            setState(() {
              dinnerTime = time;
            });
          },
              initialTime: _prefs.getString('dinner_time') != null
                  ? TimeOfDay(
                      hour: int.parse(
                          _prefs.getString('dinner_time')!.split(":")[0]),
                      minute: int.parse(
                          _prefs.getString('dinner_time')!.split(":")[1]),
                    )
                  : dinnerTime),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE75D80)),
          onPressed: () {
            if (breakfastTime != null &&
                lunchTime != null &&
                dinnerTime != null) {
              _setMealTimes(breakfastTime!, lunchTime!, dinnerTime!);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildTimePicker(String label, Function(TimeOfDay) onTimePicked,
      {TimeOfDay? initialTime}) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        TextButton(
          onPressed: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: initialTime ?? TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFFE75D80), // header background color
                      onPrimary: Colors.white, // header text color
                      onSurface: Colors.black, // body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE75D80),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white, // button text color
                        ), // button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onTimePicked(picked);
            }
          },
          child: Text(
            initialTime != null ? initialTime.format(context) : 'Set Time',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(BuildContext context, Medication medication) {
    return ExpansionTile(
      shape: const Border.fromBorderSide(BorderSide.none),
      title: Text(
        medication.tabletName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildMealTimeInput();
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<bool>(
            future: _isMealTimeSetFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load settings.'));
              } else if (snapshot.hasData && !snapshot.data!) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE75D80)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _buildMealTimeInput();
                        },
                      );
                    },
                    child: const Text('Set Meal Times',
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              } else {
                return FutureBuilder<List<Medication>>(
                  future: _medicationsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Failed to load medications.'));
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return const Center(child: Text('No medications found.'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color(0xFFF3F3F3),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: _buildExpandableSection(
                                context, snapshot.data![index]),
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
