import 'package:appsolute/models/api_response_model.dart';
import 'package:appsolute/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchData with ChangeNotifier {
  ResponseObject _headLines = ResponseObject(
    status: '',
    totalResults: 0,
    articles: [],
  );

  ResponseObject get headLinesData => _headLines;

  void storeData(Article article) async {
    final box = await Hive.openBox('articles');
    List<dynamic> formerList = await box.get('articlelist') ?? [];

    final storeArticle = HiveArticle()
      ..title = article.title
      ..description = article.description
      ..url = article.url
      ..urlToImage = article.urlToImage
      ..publishedAt = article.publishedAt
      ..content = article.content;
    if (formerList.isNotEmpty) {
      for (var i = 0; i < formerList.length; i++) {
        if (formerList[i].toArticle().title == article.title) {
          formerList.removeAt(i);
        }
      }
    }
    await box.put("articlelist", [...formerList, storeArticle]);
  }

  void getTopHeadlines(searchText) async {
    try {
      final apiKey = dotenv.env['NEWSAPIKEY'];

      if (apiKey == null) {
        throw Exception('No API Key');
      }
      Response response;
      var dio = Dio();
      response = await dio.get('https://newsapi.org/v2/everything?q={' +
          searchText +
          '}&sortBy=popularity&apiKey=' +
          apiKey);
      _headLines = ResponseObject(
          status: response.data['status'],
          totalResults: response.data['totalResults'],
          articles: response.data['articles']
              .map<Article>((json) => Article.fromJson(json))
              .toList());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
