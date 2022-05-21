import 'package:appsolute/models/article_model.dart';

class ResponseObject {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ResponseObject({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
}
