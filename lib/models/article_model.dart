import 'package:hive_flutter/hive_flutter.dart';

class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

@HiveType(typeId: 1)
class HiveArticle {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? url;

  @HiveField(3)
  String? urlToImage;

  @HiveField(4)
  String? publishedAt;

  @HiveField(5)
  String? content;

  @override
  String toString() {
    return 'HiveArticle{title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }

  Article toArticle() {
    return Article(
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}

class ArticleAdapter extends TypeAdapter<HiveArticle> {
  @override
  final typeId = 1;

  @override
  HiveArticle read(BinaryReader reader) {
    return HiveArticle()
      ..title = reader.read()
      ..description = reader.read()
      ..url = reader.read()
      ..urlToImage = reader.read()
      ..publishedAt = reader.read()
      ..content = reader.read();
  }

  @override
  void write(BinaryWriter writer, HiveArticle obj) {
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.url);
    writer.write(obj.urlToImage);
    writer.write(obj.publishedAt);
    writer.write(obj.content);
  }
}
