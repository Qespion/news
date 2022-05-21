import 'package:appsolute/models/api_response_model.dart';
import 'package:appsolute/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Data with ChangeNotifier {
  ResponseObject _headLines = ResponseObject(
    status: '',
    totalResults: 0,
    articles: [],
  );

  ResponseObject get headLinesData => _headLines;

  void getTopHeadlines() async {
    try {
      final apiKey = dotenv.env['NEWSAPIKEY'];

      if (apiKey == null) {
        throw Exception('No API Key');
      }
      Response response;
      var dio = Dio();
      response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=' + apiKey);
      _headLines = ResponseObject(
          status: response.data['status'],
          totalResults: response.data['totalResults'],
          articles: response.data['articles']
              .map<Article>((json) => Article.fromJson(json))
              .toList());
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
