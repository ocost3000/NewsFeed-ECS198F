import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Article {
  final String title;
  final Uri link;
  final String description;
  final Uri imgURL;
  final DateTime pubDate;

  const Article(
      {required this.title,
      required this.link,
      required this.description,
      required this.imgURL,
      required this.pubDate});
}
