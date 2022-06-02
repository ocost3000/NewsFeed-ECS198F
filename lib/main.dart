import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:news_feed/view/rss_feed_list_view.dart';
import 'package:news_feed/data/rss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_feed/testing/test_rss_feeds.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<RSS> rssFeeds = TestRSSFeeds.rssFeeds;

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? _user;
  final loginSnackBar = SnackBar(content: const Text("Logged in!"));

  @override
  void initState() {
    // TODO: implement initState
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

    return (const RssFeedListView());
  }
}
