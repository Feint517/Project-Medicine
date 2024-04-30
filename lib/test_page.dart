import 'package:flutter/material.dart';
import 'package:project_med/data/medication/drug_model.dart';
import 'package:project_med/data/services/database_service.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  Future<List<DrugModel>>? futureTodos;
  final todoDB = DatabaseService();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() {
    setState(() {
      //futureTodos = todoDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Drug List'),
        ),
        body: FutureBuilder<List<DrugModel>>(
          future: futureTodos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final drugs = snapshot.data!;
              return drugs.isEmpty
                  ? const Center(
                      child: Text(
                        'No Drugs...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: drugs.length,
                      itemBuilder: (context, index) {
                        final todo = drugs[index];

                        return ListTile(
                          title: Text(
                            todo.drugName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            onPressed: () async {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    );
            }
          },
        ),
      );
}
