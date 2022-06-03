import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/testing/test_rss_feeds.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/rss_feed_card.dart';
import 'package:news_feed/widget/sign_in_status.dart';

import '../data/rss.dart';

class RssFeedListView extends StatelessWidget {
  final SignInStatus status;
  final BookmarkFAB bookmarkFab;
  final List<RSS> feeds = TestRSSFeeds.rssFeeds;

  RssFeedListView({Key? key, required this.bookmarkFab, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rssFeedItems = List<RssFeedCard>.generate(
        feeds.length,
        // TODO: Implement Rss Class
        (int index) => RssFeedCard(
              idx: index,
              rssFeed: feeds[index],
              status: status,
              bookmarkFab: bookmarkFab,
            ),
        growable: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("RSS Feeds"),
        actions: [
          status,
        ],
      ),
      body: ListView.builder(
        itemCount: rssFeedItems.length,
        itemBuilder: (context, index) => rssFeedItems[index],
      ),
      floatingActionButton: bookmarkFab,
    );
  }
}
