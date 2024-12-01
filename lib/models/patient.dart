class Patient {
  final String patientName;
  final String ipNumber;
  final String bloodGroup;
  final List<String> patientContacts;
  final int? height;
  final int? weight;
  final String? dob;
  final String? doa;
  final String? dod;
  final String? dose;

  Patient({
    required this.patientName,
    required this.ipNumber,
    required this.bloodGroup,
    required this.patientContacts,
    this.height,
    this.weight,
    this.dob,
    this.doa,
    this.dod,
    this.dose,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientName: json['patient_name'] ?? '',
      ipNumber: json['ip_number'] ?? '',
      bloodGroup: json['blood_group'] ?? '',
      patientContacts: List<String>.from(json['patient_contacts'] ?? []),
      height: json['height'] != null ? json['height'] as int : null,
      weight: json['weight'] != null ? json['weight'] as int : null,
      dob: json['dob'],
      doa: json['doa'],
      dod: json['dod'],
      dose: json['dose'],
    );
  }

  String get formattedBloodGroup {
    switch (bloodGroup) {
      case 'Aplus':
        return 'A+';
      case 'Aminus':
        return 'A-';
      case 'Bplus':
        return 'B+';
      case 'Bminus':
        return 'B-';
      case 'ABplus':
        return 'AB+';
      case 'ABminus':
        return 'AB-';
      case 'Oplus':
        return 'O+';
      case 'Ominus':
        return 'O-';
      default:
        return bloodGroup;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_name': patientName,
      'ip_number': ipNumber,
      'blood_group': deFormattedBloodGroup,
      'patient_contacts': patientContacts,
      'height': height,
      'weight': weight,
      'dob': dob ?? '',
      'doa': doa ?? '',
      'dod': dod ?? '',
      'dose': dose ?? '',
    };
  }

  @override
  String toString() {
    return 'Patient(patientName: $patientName, ipNumber: $ipNumber, bloodGroup: $bloodGroup, patientContacts: $patientContacts, height: $height, weight: $weight, dob: $dob, doa: $doa, dod: $dod, dose: $dose)';
  }

  String get deFormattedBloodGroup {
    switch (bloodGroup) {
      case 'A+':
        return 'Aplus';
      case 'A-':
        return 'Aminus';
      case 'B+':
        return 'Bplus';
      case 'B-':
        return 'Bminus';
      case 'AB+':
        return 'ABplus';
      case 'AB-':
        return 'ABminus';
      case 'O+':
        return 'Oplus';
      case 'O-':
        return 'Ominus';
      default:
        return bloodGroup;
    }
  }
}
