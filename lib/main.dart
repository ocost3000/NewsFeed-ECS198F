import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:news_feed/view/article_list_view.dart';
import 'package:news_feed/view/rss_feed_list_view.dart';
import 'package:news_feed/data/rss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_feed/testing/test_rss_feeds.dart';
import 'package:news_feed/widget/fab.dart';
import 'package:news_feed/widget/sign_in_status.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SignInStatus _signInStatus = const SignInStatus();
  final BookmarkFAB _bookmarkFab = const BookmarkFAB();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(
              signInStatus: _signInStatus,
              bookmarkFab: _bookmarkFab,
            ),
        '/bookmarks': ((context) => ArticleListView(
              rssFeed: null,
              status: _signInStatus,
              bookmarkFab: null,
            )),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final SignInStatus signInStatus;
  final BookmarkFAB bookmarkFab;
  const MyHomePage(
      {Key? key, required this.signInStatus, required this.bookmarkFab})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? _user;
  final loginSnackBar = SnackBar(content: const Text("Logged in!"));

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) => setState(() {
          _user = user;
          if (_user != null) {
            ScaffoldMessenger.of(context).showSnackBar(loginSnackBar);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      log("not signed into google!");
    } else {
      log("signed into google!");
    }

    return RssFeedListView(
      status: widget.signInStatus,
      bookmarkFab: widget.bookmarkFab,
    );
  }
}
