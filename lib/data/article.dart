class Article {
  final String title;
  final Uri link;
  final String description;
  final Uri imgURL;
  final DateTime pubDate;
  late final String pubString;

  Article(
      {required this.title,
      required this.link,
      required this.description,
      required this.imgURL,
      required this.pubDate}) {
    pubString = getDate();
  }

  Article.fromMap(Map<String, dynamic> result)
      : title = result["title"],
        link = result["link"],
        description = result["description"],
        imgURL = result["imgURL"],
        pubDate = result["pubDate"],
        pubString = result["pubString"];

  Map<String, Object> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'imgURL': imgURL,
      'pubDate': pubDate,
      'pubString': pubString
    };
  }

  String getDate() {
    /// Parses DateTime date to get string for card use
    /// Example: "April 1st, 2021 — 12 days ago"
    String month = getMonth(pubDate.month);
    String day = getDay(pubDate.day);
    int year = pubDate.year;
    String relTime = getRelativeTime(pubDate);

    String d = "$month $day, $year — $relTime";
    return d;
  }

  String getMonth(int monthNum) {
    switch (monthNum) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Error!";
    }
  }

  String getDay(int dayNum) {
    switch (dayNum) {
      case 1:
        return "1st";
      case 2:
        return "2nd";
      case 3:
        return "3rd";
      default:
        return "${dayNum}th";
    }
  }

  String getRelativeTime(DateTime pubDate) {
    final Duration difference = DateTime.now().difference(pubDate);
    switch (difference.inDays) {
      case 0:
        return "Today";
      case 1:
        return "1 day ago";
      default:
        return "${difference.inDays} days ago";
    }
  }
}
