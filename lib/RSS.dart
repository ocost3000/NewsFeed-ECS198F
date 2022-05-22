import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSS extends StatefulWidget {
  const RSS({Key? key}) : super(key: key);
  final String title = 'RSS Feed Demo';

  @override
  State<RSS> createState() => _RSSState();
}

// https://www.youtube.com/watch?v=F0xh7LMr_V0
// at 3:03
class _RSSState extends State<RSS> {
  static const String FEED_URL =
      'https://news.un.org/feed/subscribe/en/news/all/rss.xml';
  // RssFeed _feed;
  // String _title;

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));

      return RssFeed.parse(response.body);
    } catch (e) {
      log("Please no error");
      log(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(
          child: Text("Press Me"),
          onPressed: () {
            loadFeed();
          }),
    );
  }
}
