import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class ArticleBookmarkButton extends StatefulWidget {
  const ArticleBookmarkButton({Key? key}) : super(key: key);

  @override
  State<ArticleBookmarkButton> createState() => _ArticleBookmarkButtonState();
}

class _ArticleBookmarkButtonState extends State<ArticleBookmarkButton> {
  late bool isBookmarked;
  final booked = Icon(Icons.bookmark);
  final unBooked = Icon(Icons.bookmark_border);
  late Widget bookmarkIcon;

  @override
  void initState() {
    // TODO:
    // The values here would be initialized with data from Firebase, letting us
    // know which ones are already bookmarked and which one's arent
    isBookmarked = false;
    bookmarkIcon = unBooked;
    super.initState();
  }

  void _toggleBookmark() {
    setState(() {
      // TODO: update Firebase
      isBookmarked = !isBookmarked;
      if (isBookmarked) {
        bookmarkIcon = booked;
      } else {
        bookmarkIcon = unBooked;
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
