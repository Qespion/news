import 'package:appsolute/models/article_model.dart';
import 'package:appsolute/view_models/article_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailArticle extends StatefulWidget {
  final Article article;
  const DetailArticle({Key? key, required this.article}) : super(key: key);

  @override
  _DetailArticleState createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArticleData>(context, listen: false)
        .checkFavorite(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            if (widget.article.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: Text(
                  widget.article.title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            if (widget.article.urlToImage != null)
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 30),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.article.urlToImage!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.article.description ?? '',
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      if (widget.article.url != null) {
                        Share.share(widget.article.url!);
                      }
                    },
                  ),
                  Consumer<ArticleData>(
                    builder: (context, provider, child) {
                      return IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () => provider.clickFavorite(widget.article),
                        color: provider.isFavorite ? Colors.red : Colors.grey,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.open_in_browser),
                    onPressed: () {
                      launch(widget.article.url ?? '');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onPanUpdate: (details) {
        if (details.delta.dx != 0) {
          Navigator.pop(context);
        }
      },
    );
  }
}
