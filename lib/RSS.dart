import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_feed/Article.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSS {
  String FEED_URL = "";
  final String title = 'RSS Feed Demo';
  int num_articles = 0;
  List<Article> articles = [];

  RSS({required this.FEED_URL}) {}

  Future<RssFeed?> _loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));

      log(RssFeed.parse(response.body).items![10].title.toString());
      log(RssFeed.parse(response.body).items!.length.toString());

      return RssFeed.parse(response.body);
    } catch (e) {
      log("Can't connect to RSS Client");
    }
    return null;
  }

  Future<List<Article>?> getFeeds() async {
    try {
      RssFeed? body = await _loadFeed();
      num_articles = body!.items!.length.toInt();
      for (int i = 0; i < num_articles; i++) {
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
      throw e;
    }
    return null;
  }
}
