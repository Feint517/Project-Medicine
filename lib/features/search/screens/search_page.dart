import 'package:flutter/material.dart';
import 'package:project_med/features/search/screens/widgets/search_result.dart';
import 'package:project_med/features/search/screens/widgets/search_section.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchSection(),
            SearchResult(),
          ],
        ),
      ),
    );
  }
}