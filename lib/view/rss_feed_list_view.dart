import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/rss_feed_card.dart';
import 'package:news_feed/widget/sign_in_status.dart';

class RssFeedListView extends StatelessWidget {
  final SignInStatus status;
  final BookmarkFAB bookmarkFab;

  const RssFeedListView(
      {Key? key, required this.bookmarkFab, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rssFeedItems = List<RssFeedCard>.generate(
        4,
        // TODO: Implement Rss Class
        (int index) => RssFeedCard(
              title: "UN News ${index + 1}",
              subtitle: "Global perspective, human stories ${index + 1}",
              imageURL:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_the_United_Nations.svg/640px-Flag_of_the_United_Nations.svg.png",
              idx: index,
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
