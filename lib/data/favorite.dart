class Favorite {
  final int userId;
  final String title;
  final String link;
  final String description;
  final String imgURL;
  final String pubDate;

  Favorite(
      {required this.userId,
      required this.title,
      required this.link,
      required this.description,
      required this.imgURL,
      required this.pubDate});

  Favorite.fromMap(Map<String, dynamic> result)
      : userId = result["userId"],
        title = result["title"],
        link = result["link"],
        description = result["description"],
        imgURL = result["imgURL"],
        pubDate = result["pubDate"];

  Map<String, Object> toMap() {
    return {
      'userId': userId,
      'title': title,
      'link': link,
      'description': description,
      'imgURL': imgURL,
      'pubDate': pubDate,
    };
  }
}
