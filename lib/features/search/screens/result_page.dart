// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_med/data/medication/drug_model.dart';
// import 'package:project_med/data/services/database_helper.dart';

// class ResultPage extends StatelessWidget {
//   const ResultPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final drugDBHelper = Get.put(DatabaseHelper());
//     final database = drugDBHelper.database;
//     final drugsList = database.fetchAll();
    
//     return Scaffold(
//       body: ListView(
//         children: [
//           FutureBuilder<List<DrugModel>>(
//             future: drugsList,
//             builder: (context, snapshot) {
//               final drugs = snapshot.data!;
//               return drugs.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No Drugs...',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 28,
//                         ),
//                       ),
//                     )
//                   : ListView.separated(
//                       separatorBuilder: (context, index) => const SizedBox(
//                         height: 12,
//                       ),
//                       itemCount: drugs.length,
//                       itemBuilder: (context, index) {
//                         final drug = drugs[index];
//                         return ListTile(
//                           title: Text(
//                             drug.drugName!,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         );
//                       },
//                     );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
