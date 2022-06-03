import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/data/article.dart';
import 'package:news_feed/services/database.dart';
import 'package:news_feed/testing/test_articles.dart';
import 'package:news_feed/widget/article_card.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/sign_in_status.dart';

import '../data/rss.dart';

class ArticleListView extends StatefulWidget {
  final RSS? rssFeed;
  final SignInStatus status;
  final BookmarkFAB? bookmarkFab;
  final String feedName;
  const ArticleListView(
      {Key? key,
      required this.feedName,
      required this.rssFeed,
      required this.status,
      required this.bookmarkFab})
      : super(key: key);

  @override
  State<ArticleListView> createState() => ArticleListViewState();
}

class ArticleListViewState extends State<ArticleListView> {
  // NOTE: hardcoded testing articles
  final DataBase service = DataBase();

  Future<List<Article>?> _handleGenerating() async {
    List<Article>? articles = null;
    if (widget.rssFeed == null) {
      // bookmarks
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("Shouln't even get to this block! Loggin to see your favorites!");
      } else {
        var favoritesList = await service.getFavoritesByUserId(currentUser.uid);
        articles = favoritesList.map((e) {
          var favoriteArticle = Article(
            title: e.title,
            link: Uri.parse(e.link),
            description: e.description,
            imgURL: Uri.parse(e.imgURL),
            pubDate: DateTime.parse(e.pubString),
          );
          return favoriteArticle;
        }).toList();
      }
      return articles;
    } else {
      try {
        articles = await widget.rssFeed!.getFeeds();
      } catch (e) {
        log("Can't connect to RSS Client");
      }
      return articles;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.feedName),
        actions: [
          widget.status,
        ],
      ),
      body: FutureBuilder<List<Article>?>(
          future: _handleGenerating(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>?> snapshot) {
            List<Article> arts;
            List<Widget> cards;
            Widget bodyWidget;
            if (snapshot.hasData) {
              arts = snapshot.data!;
              cards = List<ArticleCard>.generate(
                  arts.length, (int index) => ArticleCard(article: arts[index]),
                  growable: true);
              bodyWidget = ListView.builder(
                  itemBuilder: (context, index) => cards[index]);
            } else if (snapshot.hasError) {
              bodyWidget = Column(children: <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ]);
            } else {
              bodyWidget = const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
              );
            }
            return bodyWidget;
          }),
      floatingActionButton: widget.bookmarkFab,
    );
  }
}
