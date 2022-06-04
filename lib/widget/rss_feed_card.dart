import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:news_feed/view/article_list_view.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/sign_in_status.dart';

import '../data/article.dart';
import '../data/rss.dart';
import '../testing/test_articles.dart';

class RssFeedCard extends StatelessWidget {
  // Widget (View) for Card Item
  final int idx;
  final String? imageUrl = null;

  final RSS rssFeed;
  final SignInStatus status;
  final BookmarkFAB bookmarkFab;

  const RssFeedCard(
      {Key? key,
      required this.idx,
      required this.status,
      required this.rssFeed,
      required this.bookmarkFab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          log("Clicked RSS #$idx");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ArticleListView(
              rssFeed: rssFeed,
              status: status,
              bookmarkFab: bookmarkFab,
            );
          }));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Image.asset('assets/images/rss.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain),
              // Below is code that was used to retrieve image from network
              // not currently used
              //
              // Image.network(
              //   imageUrl,
              //   width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.contain,
              //   errorBuilder: (context, error, stackTrace) {
              //     return Image.asset('images/rss.png',
              //         width: MediaQuery.of(context).size.width,
              //         fit: BoxFit.contain);
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.rss_feed_outlined),
                title: Text(rssFeed.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
