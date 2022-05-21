import 'package:appsolute/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticleData with ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void setFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  void addFavorite(Article article) async {
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
    setFavorite(true);
  }

  void removeFavorite(Article article) async {
    final box = await Hive.openBox('articles');
    List<dynamic> formerList = await box.get('articlelist') ?? [];

    for (var i = 0; i < formerList.length; i++) {
      if (formerList[i].toArticle().title == article.title) {
        formerList.removeAt(i);
      }
    }
    await box.put("articlelist", formerList);
    setFavorite(false);
  }

  void clickFavorite(Article article) {
    if (isFavorite) {
      removeFavorite(article);
    } else {
      addFavorite(article);
    }
  }

  void checkFavorite(Article article) async {
    try {
      var box = await Hive.openBox('articles');
      List<dynamic> formerList = await box.get('articlelist') ?? [];

      if (formerList.isNotEmpty) {
        for (var i = 0; i < formerList.length; i++) {
          if (formerList[i].toArticle().title == article.title) {
            setFavorite(true);
            return;
          }
        }
      }
      setFavorite(false);
    } catch (e) {
      print(e);
    }
  }
}
