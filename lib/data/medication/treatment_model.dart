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
    required this.dose,
    required this.frequency,
    required this.timing,
    this.injectingSite = '',
    required this.date,
    required this.hour,
  });

  factory TreatmentModel.fromSqfliteDatabase(Map<String, dynamic> map) =>
      TreatmentModel(
        id: map['id']?.toInt() ?? 0,
        type: map['type'] ?? '',
        name: map['name'] ?? '',
        dose: map['dose'] ?? '',
        frequency: map['frequency'] ?? '',
        timing: map['timing'] ?? '',
        injectingSite: map['injectingSite'] ?? '',
        date: map['date'] ?? 0,
        hour: map['hour'] ?? '',
      );
}
