import 'package:appsolute/view_models/search_view_model.dart';
import 'package:appsolute/views/article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchInfo extends StatefulWidget {
  const SearchInfo({Key? key}) : super(key: key);

  @override
  _SearchInfoState createState() => _SearchInfoState();
}

class _SearchInfoState extends State<SearchInfo> {
  var _searchText = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchData>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _searchText = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      provider.getTopHeadlines(_searchText);
                    },
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.headLinesData.articles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: ListTile(
                    leading: Image.network(
                      provider.headLinesData.articles[index].urlToImage ?? '',
                      width: 100,
                      height: 100,
                    ),
                    title: Text(
                        provider.headLinesData.articles[index].title ?? ''),
                    subtitle: Text(
                        provider.headLinesData.articles[index].description ??
                            ''),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailArticle(
                          article: provider.headLinesData.articles[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
