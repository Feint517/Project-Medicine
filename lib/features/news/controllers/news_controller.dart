import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_med/features/news/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsController extends GetxController {
  static NewsController get instance => Get.find();

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  List<ArticleModel> articles = [];
  RxList<ArticleModel> articlesRx = <ArticleModel>[].obs;

  void fetchArticles() async {
    print('fetchArticles is called.');
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=82022c43312743c2a74da0f0a75fc9ba';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['articles'] as List<dynamic>;
    try {
      final transformed = results.map((article) {
        return ArticleModel(
          //source: article['source'],
          author: article['author'] ?? '',
          title: article['title'] ?? '',
          url: article['url'] ?? '',
          urlToImage: article['urlToImage'] ?? '',
          description: article['description'] ?? '',
          publishedAt: article['publishedAt'] ?? '',
          content: article['content'] ?? '',
        );
      }).toList();
      filterArticles(transformed);
      await Future.delayed(const Duration(milliseconds: 500));
      for (int i = 0; i < transformed.length; i++) {
        articlesRx.add(transformed[i]);
      }
      if (kDebugMode) {
        print('fetchArticles completed.');
        print('Number of articles = ${transformed.length}');
        print('============================');
        print('length of RxList = ${articlesRx.length}');
        print('Article 2 info');
        print('author: ${transformed[1].author}');
        print('title: ${transformed[1].title}');
        print('url: ${transformed[1].url}');
        print('urlToImage: ${transformed[1].urlToImage}');
        print('description: ${transformed[1].description}');
        print('publishedAt: ${transformed[1].publishedAt}');
        print('content: ${transformed[1].content}');
        print('============================');
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
    }
  }

  void filterArticles(List<ArticleModel> articles) {
    for (int j = 0; j < articles.length; j++) {
      if (articles[j].title == '[Removed]' ||
          articles[j].title.contains('sexual')) {
        articles.removeAt(j);
      }
    }
  }

  void launchingUrl(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link));
    } else {
      throw 'Could not open $link';
    }
  }
}
