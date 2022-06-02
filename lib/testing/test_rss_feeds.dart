import 'package:news_feed/RSS.dart';

class TestRSSFeeds {
  static final List<RSS> rssFeeds = [
    RSS(
        feedUrl: "https://news.un.org/feed/subscribe/en/news/all/rss.xml",
        title: "UN Top Stories"),
    RSS(
        feedUrl:
            "https://news.un.org/feed/subscribe/en/news/region/americas/feed/rss.xml",
        title: "Americas"),
    RSS(
        feedUrl:
            "https://news.un.org/feed/subscribe/en/news/topic/health/feed/rss.xml",
        title: "Health"),
    RSS(
        feedUrl:
            "https://news.un.org/feed/subscribe/en/news/topic/women/feed/rss.xml",
        title: "Women"),
  ];
}
