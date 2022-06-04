import 'dart:developer';

import 'package:news_feed/data/article.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class RSS {
  /// Wrapper for RssFeed class
  final String feedUrl;
  final String title;
  int numArticles = 0;
  List<Article> articles = [];

  RSS({required this.feedUrl, required this.title});

  Future<RssFeed?> _loadFeed() async {
    /// Get the rssFeed file from web
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(feedUrl));

      log(RssFeed.parse(response.body).items![10].title.toString());
      log(RssFeed.parse(response.body).items!.length.toString());

      return RssFeed.parse(response.body);
    } catch (e) {
      log("Can't connect to RSS Client");
    }
    return null;
  }

  Future<List<Article>?> getFeeds() async {
    /// use rssFeed from web to get articles within its content
    try {
      RssFeed? body = await _loadFeed();
      numArticles = body!.items!.length.toInt();
      for (int i = 0; i < numArticles; i++) {
        articles.add(Article(
            title: body.items![i].title.toString(),
            link: Uri.parse(body.items![i].link.toString()),
            description: body.items![i].description.toString(),
            imgURL: Uri.parse(body.items![i].enclosure!.url.toString()),
            pubDate: body.items![i].pubDate!));
      }
      return articles;
    } catch (e) {
      log("Break when trying to get feeds");
      rethrow;
    }
  }
}
