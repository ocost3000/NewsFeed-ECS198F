import 'package:flutter/material.dart';

class BookmarkFAB extends StatelessWidget {
  const BookmarkFAB({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  void loginRequest() {
    print("Ask to login");
  }

  void goToBookmarks() {
    print("Go to bookmarks");
  }

  @override
  Widget build(BuildContext context) {
    return (FloatingActionButton(
        onPressed: isLoggedIn ? goToBookmarks : loginRequest,
        tooltip: isLoggedIn ? "Bookmarks" : "Log in here",
        child: isLoggedIn
            ? Icon(Icons.bookmark,
                color: Theme.of(context).colorScheme.onSecondary)
            : Icon(Icons.person,
                color: Theme.of(context).colorScheme.onSecondary)));
  }
}
