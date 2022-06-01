import 'package:flutter/material.dart';
import 'package:news_feed/data/article.dart';

import 'article_bookmark_button.dart';

class ArticleCard extends StatelessWidget {
  /// Widget (View) for Card Item
  final Article article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          // TODO: open article.link in external browser
        },
        child: SizedBox(
          height: 330,
          child: Card(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
            // NOTE: perhaps wrap with padding?
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 150,
                  child: Image.network(
                    article.imgURL.toString(),
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('images/rss.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain);
                    },
                  ),
                ),
                // TODO: this listtile cannot be infinitely long...
                // will need wrap
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(article.title,
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            )),
                        subtitle: Text(
                          article.description,
                          maxLines: 3,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // TODO: make this Date a variable
                              Text(
                                article.pubString,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[500],
                                ),
                              ),
                              ArticleBookmarkButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
