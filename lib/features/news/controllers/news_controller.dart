import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_med/features/news/models/article_model.dart';

class NewsController extends GetxController {
  List<ArticleModel> articles = [];
  RxList<dynamic> RxArticles = [].obs;

  void fetchArticles() async {
    print('fetchArticles is called.');
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=82022c43312743c2a74da0f0a75fc9ba';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final articles = json['articles'] as List<dynamic>;
    for (int i = 0; i < articles.length; i++) {
      RxArticles.add(articles[i]);
    }
    if (kDebugMode) {
      print('fetchArticles completed.');
      print('============================');
      print('Number of articles = ${articles.length}');
    }
  }
}
