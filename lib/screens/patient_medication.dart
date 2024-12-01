import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mammocare/models/medication.dart';

class PatientMedication extends StatefulWidget {
  final String patientId;

  const PatientMedication({super.key, required this.patientId});

  @override
  State<PatientMedication> createState() => _PatientMedicationState();
}

class _PatientMedicationState extends State<PatientMedication> {
  late Future<List<Medication>> _medicationsFuture;

  @override
  void initState() {
    super.initState();
    _medicationsFuture = fetchMedications(widget.patientId);
  }

  Future<List<Medication>> fetchMedications(String patientId) async {
    final response = await http.get(
      Uri.parse(
          'https://mamo-care-backend.onrender.com/api/medication/patient/$patientId'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<Medication>((medication) => Medication.fromJson(medication))
          .toList();
    } else {
      throw Exception('Failed to load medications');
    }
  }

  Widget _buildExpandableSection(BuildContext context, Medication medication) {
    return ExpansionTile(
      shape: const Border.fromBorderSide(BorderSide.none),
      title: Text(
        medication.tabletName,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        medication.notes,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        _buildDaySchedule('Monday', medication.monday),
        _buildDaySchedule('Tuesday', medication.tuesday),
        _buildDaySchedule('Wednesday', medication.wednesday),
        _buildDaySchedule('Thursday', medication.thursday),
        _buildDaySchedule('Friday', medication.friday),
        _buildDaySchedule('Saturday', medication.saturday),
        _buildDaySchedule('Sunday', medication.sunday),
      ],
    );
  }

  Widget _buildDaySchedule(String day, List<int> schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          Text(day, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 10),
          ...schedule.map((dose) => _buildDoseIcon(dose)),
        ],
      ),
    );
  }

  Widget _buildDoseIcon(int dose) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(
        Icons.local_hospital,
        color: dose == 1 ? Colors.green : Colors.red,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Medication>>(
      future: _medicationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No medications found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Medication medication = snapshot.data![index];
              return _buildExpandableSection(context, medication);
            },
          );
        }
      },
    );
  }
}
