import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/data/favorite.dart';
import 'package:news_feed/data/article.dart';
import 'package:news_feed/services/database.dart';

class ArticleBookmarkButton extends StatefulWidget {
  final Article article;
  const ArticleBookmarkButton({Key? key, required this.article})
      : super(key: key);

  @override
  State<ArticleBookmarkButton> createState() => _ArticleBookmarkButtonState();
}

class _ArticleBookmarkButtonState extends State<ArticleBookmarkButton> {
  // late bool isBookmarked;
  bool isBookmarked = false;
  final booked = Icon(Icons.bookmark);
  final unBooked = Icon(Icons.bookmark_border);
  // late Widget bookmarkIcon;
  Widget bookmarkIcon = Icon(Icons.bookmark_border);
  final DataBase service = DataBase();

  @override
  void initState() {
    super.initState();
    User? currentUser = FirebaseAuth.instance.currentUser;
    updateBookmarkIcon(currentUser);
    //listener in case user signs out and rerender won't happen
    //for example if already in article list view
    FirebaseAuth.instance
        .authStateChanges()
        .listen((currentUser) => setState(() {
              updateBookmarkIcon(currentUser);
            }));
  }

  void updateBookmarkIcon(User? currentUser) {
    if (currentUser == null) {
      print("Should log in to use bookmarks");
      isBookmarked = false;
      bookmarkIcon = unBooked;
    } else {
      service
          .getFavoriteByArticleAndUserId(widget.article, currentUser.uid)
          .then((value) {
        setState(() {
          if (value.isEmpty) {
            isBookmarked = false;
            bookmarkIcon = unBooked;
          } else {
            isBookmarked = true;
            bookmarkIcon = booked;
          }
        });
      });
    }
  }
  
  void _toggleBookmark() {
    setState(() {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("Please, sign in to use bookmarks!")));
      isBookmarked = !isBookmarked;
      if (isBookmarked) {
        bookmarkIcon = booked;
        //insert into DB
        service
            .putFavorite(Favorite(
                userId: widget.authUserId,
                title: widget.article.title,
                link: widget.article.link.toString(),
                description: widget.article.description,
                imgURL: widget.article.imgURL.toString(),
                pubString: widget.article.pubString))
            .then((value) {
          print("Should insert row №: $value");
        });
      } else {
        isBookmarked = !isBookmarked;
        if (isBookmarked) {
          bookmarkIcon = booked;
          //insert into DB
          service
              .putFavorite(Favorite(
                  userId: currentUser.uid,
                  title: widget.article.title,
                  link: widget.article.link.toString(),
                  description: widget.article.description,
                  imgURL: widget.article.imgURL.toString(),
                  pubString: widget.article.pubDate.toString()))
              .then((value) {
            print(
                "Should store article with date: ${widget.article.pubString}");
          });
        } else {
          bookmarkIcon = unBooked;
          //remove from DB
          service
              .deleteFavoriteByArticleAndUserId(widget.article, currentUser.uid)
              .then((value) {
            print(
                "Should delete article with date: ${widget.article.pubString}");
          });
        }
        service.getAllFavorites().then((allfavorites) {
          for (var fav in allfavorites) {
            print(fav.title);
            print(fav.description);
            print("UserId: ${fav.userId}");
            print(fav.pubString);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      iconSize: 20,
      icon: bookmarkIcon,
      onPressed: () {
        _toggleBookmark();
      },
      color: Theme.of(context).colorScheme.primary,
    ));
  }
}
