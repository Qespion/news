import 'package:appsolute/view_models/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteData>(context, listen: false).getArticle();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FavoriteData>(context);
    return Scaffold(
      body: provider.headLinesData.isEmpty
          ? Center(
              child: Text('No Articles saved',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 20)),
            )
          : ListView.builder(
              itemCount: provider.headLinesData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.headLinesData[index].title),
                  subtitle: Text(provider.headLinesData[index].description),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(provider.headLinesData[index].urlToImage),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<FavoriteData>(context, listen: false)
                          .removeArticle(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: provider.headLinesData.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                provider.removeAllArticle();
              },
              child: const Text(
                'Clear all',
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}
