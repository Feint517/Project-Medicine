class DrugModel {
  final int? drugId;
  final String? drugName;
  final String? drugDescription;

  DrugModel({
    this.drugId,
    this.drugName,
    this.drugDescription,
  });

  factory DrugModel.fromSqfliteDatabase(Map<String, dynamic> map) => DrugModel(
    drugId: map['drugID']?.toInt() ?? 0,
    drugName: map['drugName'] ?? '',
    drugDescription: map['drugDescription'] ?? '',
  );

  // //? constructor to convert data from a map
  // DrugModel.fromMap(Map<String, dynamic> item)
  //     : drugId = item['drugId'],
  //       drugName = item['drugName'],
  //       drugDescription = item['drugdescription'];

  // //? method to convert data into a map
  // Map<String, Object?> toMap() {
  //   return {
  //     'id': drugId,
  //     'name': drugName,
  //     'description': drugDescription,
  //   };
  // }

  // @override
  // String toString() {
  //   return 'Drug{id: $drugId, name: $drugName, description: $drugDescription}';
  // }

  // DrugModel.map(dynamic obj) {
  //   this.drugId = obj['drugId'];
  //   this.drugName = obj['drugName'];
  //   this.drugDescription = obj['drugDescription'];
  // }

  // Map<String,dynamic>? toMap() {
  //   var map = new Map<String, dynamic>();
  //   map['drugId'] = drugId;
  //   map['drugName'] = drugName;
  //   map['drugDescription'] = drugDescription;
  // }
}
