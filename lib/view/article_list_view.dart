import 'package:flutter/material.dart';
import 'package:news_feed/widget/article_card.dart';
import 'package:news_feed/widget/fab.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final RssFeedItems = List<ArticleCard>.generate(
        4,
        (int index) => ArticleCard(
              title: "UN News ${index + 1}",
              subtitle: "Global perspective, human stories ${index + 1}",
              imageURL:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_the_United_Nations.svg/640px-Flag_of_the_United_Nations.svg.png",
            ),
        growable: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: RssFeedItems.length,
        itemBuilder: (context, index) => RssFeedItems[index],
      ),
      floatingActionButton: const BookmarkFAB(
        isLoggedIn: false,
      ),
    );
  }
}
