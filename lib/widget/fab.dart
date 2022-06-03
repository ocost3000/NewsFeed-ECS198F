import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/services/firebase_helper.dart';

class BookmarkFAB extends StatefulWidget {
  /// FAB == Floating Action Button
  const BookmarkFAB({Key? key}) : super(key: key);

  @override
  State<BookmarkFAB> createState() => _BookmarkFABState();
}

class _BookmarkFABState extends State<BookmarkFAB> {
  User? _user;
  void Function() _onPressed = () => log("Uninitialized fireFunc");
  String _tooltip = "Placeholder";
  Icon _icon = const Icon(Icons.abc_outlined);

  void _loginRequest() {
    log("Ask to login");
    FirebaseHelper.signInWithGoogle();
  }

  void _goToBookmarks() {
    log("Go to bookmarks");
    Navigator.pushNamed(context, '/bookmarks');
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) => setState(() {
          _user = user;
          if (_user == null) {
            // not logged in
            _onPressed = _loginRequest;
            _tooltip = "Log in here";
            _icon = Icon(Icons.person,
                color: Theme.of(context).colorScheme.onSecondary);
          } else {
            // logged in
            _onPressed = _goToBookmarks;
            _tooltip = "Bookmarks";
            _icon = Icon(Icons.bookmark,
                color: Theme.of(context).colorScheme.onSecondary);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      tooltip: _tooltip,
      child: _icon,
    );
  }
}
