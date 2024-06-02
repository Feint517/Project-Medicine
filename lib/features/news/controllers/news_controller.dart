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

  RxList<ArticleModel> articlesRx = <ArticleModel>[].obs;
  List<String> bannedWords = ['[Removed]', 'sexual', 'Sex', 'Penis'];

  void fetchArticles() async {
    if (kDebugMode) {
      print('fetchArticles is called.');
    }
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=82022c43312743c2a74da0f0a75fc9ba';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final results = json['articles'] as List<dynamic>;
    try {
      final transformed = results.map((article) {
        return ArticleModel(
          author: article['author'] ?? '',
          title: article['title'] ?? '',
          url: article['url'] ?? '',
          urlToImage: article['urlToImage'] ?? '',
          description: article['description'] ?? '',
          publishedAt: article['publishedAt'] ?? '',
          content: article['content'] ?? '',
        );
      }).toList();

      if (kDebugMode) {
        print('================');
        print('Articles list length before filtering = ${transformed.length}');
        print('================');
      }

      //* filtering unwanted articles
      for (int i = 0; i < transformed.length; i++) {
        for (var word in bannedWords) {
          if (transformed[i].title.contains(word)) {
            transformed.removeAt(i);
            if (kDebugMode) {
              print('removed because of title');
            }
          }
        }
      }
      for (int k = 0; k < transformed.length; k++) {
        if (transformed[k].author!.contains('https')) {
          transformed.removeAt(k);
          if (kDebugMode) {
            print('removed because of author');
          }
        }
      }
      for (int j = 0; j < transformed.length; j++) {
        if (transformed[j].urlToImage!.isEmpty) {
          transformed.removeAt(j);
          if (kDebugMode) {
            print('removed because of urlToImage');
          }
        }
      }

      //* add filtered articles list to the obesrved list
      articlesRx.assignAll(transformed);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
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
