import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteData with ChangeNotifier {
  List<dynamic> _headLines = [];

  List<dynamic> get headLinesData => _headLines;

  void getArticle() async {
    try {
      var box = await Hive.openBox('articles');
      _headLines = box.get('articlelist') ?? [];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void removeAllArticle() async {
    try {
      var box = await Hive.openBox('articles');
      box.clear();
      _headLines = [];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void removeArticle(int index) async {
    try {
      var box = await Hive.openBox('articles');
      _headLines.removeAt(index);
      box.put('articlelist', _headLines);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
