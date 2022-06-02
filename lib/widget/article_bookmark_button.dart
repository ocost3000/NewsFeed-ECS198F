import 'package:flutter/material.dart';
import 'package:news_feed/data/favorite.dart';
import 'package:news_feed/data/article.dart';
import 'package:news_feed/services/database.dart';

class ArticleBookmarkButton extends StatefulWidget {
  final Article article;
  final int authUserId;
  const ArticleBookmarkButton(
      {Key? key, required this.article, required this.authUserId})
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
    // DONE???:
    // The values here would be initialized with data from Firebase, letting us
    // know which ones are already bookmarked and which one's arent
    super.initState();
    service
        .getFavoriteByArticleAndUserId(widget.article, widget.authUserId)
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

  void _toggleBookmark() {
    setState(() {
      // TODO: update Firebase
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
        bookmarkIcon = unBooked;
        //remove from DB
        service
            .deleteFavoriteByArticleAndUserId(widget.article, widget.authUserId)
            .then((value) {
          print("Should delete unbooked article");
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
