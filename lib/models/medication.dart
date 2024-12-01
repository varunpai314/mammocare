class Medication {
  String patientId;
  String tabletName;
  String notes;
  List<int> monday;
  List<int> tuesday;
  List<int> wednesday;
  List<int> thursday;
  List<int> friday;
  List<int> saturday;
  List<int> sunday;

  Medication({
    required this.patientId,
    required this.tabletName,
    required this.notes,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      patientId: json['patient_id'],
      tabletName: json['tablet_name'],
      notes: json['notes'],
      monday: List<int>.from(json['Monday'].map((x) => int.parse(x))),
      tuesday: List<int>.from(json['Tuesday'].map((x) => int.parse(x))),
      wednesday: List<int>.from(json['Wednesday'].map((x) => int.parse(x))),
      thursday: List<int>.from(json['Thursday'].map((x) => int.parse(x))),
      friday: List<int>.from(json['Friday'].map((x) => int.parse(x))),
      saturday: List<int>.from(json['Saturday'].map((x) => int.parse(x))),
      sunday: List<int>.from(json['Sunday'].map((x) => int.parse(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'tablet_name': tabletName,
      'notes': notes,
      'Monday': monday.map((x) => x.toString()).toList(),
      'Tuesday': tuesday.map((x) => x.toString()).toList(),
      'Wednesday': wednesday.map((x) => x.toString()).toList(),
      'Thursday': thursday.map((x) => x.toString()).toList(),
      'Friday': friday.map((x) => x.toString()).toList(),
      'Saturday': saturday.map((x) => x.toString()).toList(),
      'Sunday': sunday.map((x) => x.toString()).toList(),
    };
  }
}
