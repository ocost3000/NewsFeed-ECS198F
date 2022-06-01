import 'package:flutter/material.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/rss_feed_card.dart';

class RssFeedListView extends StatelessWidget {
  /// Uses ListView to display all RSS Feed sources
  const RssFeedListView({Key? key}) : super(key: key);

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
            idx: index),
        growable: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("RSS Feeds"),
      ),
      body: ListView.builder(
        itemCount: rssFeedItems.length,
        itemBuilder: (context, index) => rssFeedItems[index],
      ),
      floatingActionButton: const BookmarkFAB(
        isLoggedIn: false,
      ),
    );
  }
}
