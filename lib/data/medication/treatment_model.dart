class TreatmentModel {
  final int id;
  final String type;
  final String name;
  final int dose;
  final String frequency;
  final String timing;
  String injectingSite;
  final int date;
  final String hour;

  TreatmentModel({
    required this.id,
    required this.type,
    required this.name,
    this.dose = 0,
    required this.frequency,
    required this.timing,
    this.injectingSite = '',
    required this.date,
    required this.hour,
  });

  static TreatmentModel empty() => TreatmentModel(
        id: 0,
        type: '',
        name: '',
        dose: 0,
        frequency: '',
        timing: '',
        date: 0,
        hour: '',
      );

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
        id: json['id'] ?? 0,
        type: json['type'] ?? '',
        name: json['name'] ?? '',
        dose: json['dose'] ?? 0,
        frequency: json['frequency'] ?? '',
        timing: json['timing'] ?? '',
        injectingSite: json['injectingSite'] ?? '',
        date: json['date'] ?? 0,
        hour: json['hour'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'dose': dose,
        'frequency': frequency,
        'timing': timing,
        'injectingSite': injectingSite,
        'date': date,
        'hour': hour,
      };
}
