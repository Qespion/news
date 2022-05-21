import 'package:appsolute/models/article_model.dart';
import 'package:appsolute/view_models/article_view_model.dart';
import 'package:appsolute/view_models/bottomBar.dart';
import 'package:appsolute/view_models/api_view_model.dart';
import 'package:appsolute/view_models/favorite_view_model.dart';
import 'package:appsolute/view_models/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  Hive.registerAdapter(ArticleAdapter());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Data()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => SearchData()),
        ChangeNotifierProvider(create: (_) => ArticleData()),
        ChangeNotifierProvider(create: (_) => FavoriteData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavBar(),
    );
  }
}
