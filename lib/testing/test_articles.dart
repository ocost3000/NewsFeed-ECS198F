import 'package:news_feed/data/article.dart';

class TestArticles {
  static const String testTitle =
      "Here's a really long title that can possibly be two lines, not sure to be completely honest.";
  static const String testDesc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static Uri testLink = Uri.parse("https://www.google.com");
  static List<Article> articles = [
    Article(
        title: testTitle,
        link: Uri.parse("https://en.wikipedia.org/wiki/Niland_Geyser"),
        description: testDesc,
        imgURL: Uri.parse(
            "https://media.pitchfork.com/photos/627873d5c7eb1718d8afd386/2:1/w_2560%2Cc_limit/kanye-west.jpg"),
        pubDate: DateTime.now()),
    Article(
        title: testTitle,
        link: Uri.parse("https://www.bbc.com/news/world-europe-61656639"),
        description: testDesc,
        imgURL: Uri.parse(
            "https://upload.wikimedia.org/wikipedia/commons/3/37/NotreDame20190415QuaideMontebello_%28cropped%29.jpg"),
        pubDate: DateTime.now()),
    Article(
        title: testTitle,
        link: Uri.parse(
            "https://www.theguardian.com/commentisfree/2022/may/30/children-read-for-fun"),
        description: testDesc,
        imgURL: Uri.parse(
            "https://api.time.com/wp-content/uploads/2021/01/Malaysia-king.jpg"),
        pubDate: DateTime.now()),
  ];
}
