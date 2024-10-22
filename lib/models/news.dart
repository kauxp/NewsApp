import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsModel {
  String headline;
  String imagePath;
  String source;
  String description;
  String content;
  String date;
  String url;
  NewsModel(
      {required this.headline,
      this.imagePath = '',
      required this.source,
      required this.description,
      required this.content,
      required this.date,
      required this.url});

  @override
  String toString() {
    return 'NewsModel(headline: $headline, source: $source, description: $description, url: $url, imagePath: $imagePath)';
  }

  static Future<List<NewsModel>> getNews(String query, String category, int page) async {
    List<NewsModel> news = [];
    String apiKey = dotenv.env['API_KEY'] ?? '';
    print(query + " * " + category);
    String apiUrl =
        'https://newsapi.org/v2/everything?q=bitcoin&page=$page&apiKey=$apiKey';

    if (category != '' && query != '') {
      apiUrl =
          'https://newsapi.org/v2/top-headlines?q=$query&category=$category&page=$page&apiKey=$apiKey';
    } else if (query != '') {
      apiUrl =
          'https://newsapi.org/v2/everything?q=$query&page=$page&apiKey=$apiKey';
    } else if (category != '') {
      apiUrl =
          'https://newsapi.org/v2/top-headlines?category=$category&page=$page&apiKey=$apiKey';
    }

    print(apiUrl);

    try {
      var res = await http.get(Uri.parse(apiUrl));

      if (res.statusCode == 200) {
        // Parse the response
        var jsonData = jsonDecode(res.body);

        // Process the articles
        var articles = jsonData['articles'];
        // print(articles);
        for (var article in articles) {
          NewsModel newsItem = NewsModel(
            headline: article['title'],
            imagePath: article['urlToImage'] ?? '',
            source: article['source']['name'],
            description: article['description'],
            content: article['content'],
            date: article['publishedAt'],
            url: article['url'],
          );
          news.add(newsItem);
        }
      } else {
        print('Failed to fetch news: ${res.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return news;
  }
}
