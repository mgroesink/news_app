import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  News({this.category, this.country});
  final String category;
  final String country;

  List<ArticleModel> news = <ArticleModel>[];

  Future<void> getNews() async {
    String url = country != null
        ? 'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=1bcf4a2f3d98402bab5d89bf1e05ae50'
        : 'https://newsapi.org/v2/top-headlines?category=$category&apiKey=1bcf4a2f3d98402bab5d89bf1e05ae50';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
              url: element["url"],
              author: element['author'],
              content: element['content'],
              description: element['description'],
              title: element['title'],
              publishedAt: DateTime.parse(element['publishedAt']),
              urlToImage: element['urlToImage']);
          news.add(article);
        }
      });
    }
  }
}
