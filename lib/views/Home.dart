import 'package:appsolute/views/article.dart';
import 'package:appsolute/view_models/api_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Data>(
        builder: (context, data, child) {
          return data.headLinesData.articles.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.headLinesData.articles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              data.headLinesData.articles[index].urlToImage ==
                                      null
                                  ? Image.asset(
                                      'assets/images/noImages.jpg',
                                      height: 200,
                                      width: 200,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        imageUrl: data.headLinesData
                                            .articles[index].urlToImage!,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.headLinesData.articles[index].title ??
                                      '',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.headLinesData.articles[index].url ??
                                      'Unknown source',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailArticle(
                              article: data.headLinesData.articles[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
