class InteractionModel {
  final String drug1Name;
  final String drug2Name;
  final String explanation;

  InteractionModel({
    required this.drug1Name,
    required this.drug2Name,
    required this.explanation,
  });

  factory InteractionModel.fromSqfliteDatabase(Map<String, dynamic> map) => InteractionModel(
    drug1Name: map['drug1Name'] ?? '',
    drug2Name: map['drug2Name'] ?? '',
    explanation: map['explanation'] ?? '',
  );

}
