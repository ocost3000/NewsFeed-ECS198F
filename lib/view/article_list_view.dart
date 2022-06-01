import 'package:flutter/material.dart';
import 'package:news_feed/data/article.dart';
import 'package:news_feed/testing/test_articles.dart';
import 'package:news_feed/widget/article_card.dart';
import 'package:news_feed/widget/fab.dart';

class ArticleListView extends StatefulWidget {
  final String RssFeed;
  const ArticleListView({Key? key, required this.RssFeed}) : super(key: key);

  @override
  State<ArticleListView> createState() => ArticleListViewState();
}

class ArticleListViewState extends State<ArticleListView> {
  // NOTE: hardcoded testing articles
  final List<Article> _arts = TestArticles.articles;

  @override
  Widget build(BuildContext context) {
    final articleCards = List<ArticleCard>.generate(
        _arts.length, (int index) => ArticleCard(article: _arts[index]),
        growable: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.RssFeed),
      ),
      body: ListView.builder(
        itemCount: articleCards.length,
        itemBuilder: (context, index) => articleCards[index],
      ),
      floatingActionButton: const BookmarkFAB(
        isLoggedIn: false,
      ),
    );
  }
}
