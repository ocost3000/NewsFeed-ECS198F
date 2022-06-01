import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  // Widget (View) for Card Item
  final String title;
  final String subtitle;
  final String imageURL;
  final String testSubtitle =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  final String testTitle =
      "Here's a really long title that can possibly be two lines, not sure to be completely honest.";

  const ArticleCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageURL,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Card(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
          // NOTE: perhaps wrap with padding?
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              Image.network(
                imageURL,
                height: 130,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('images/rss.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain);
                },
              ),
              // TODO: this listtile cannot be infinitely long...
              // will need wrap
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(testTitle,
                          maxLines: 2,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          )),
                      subtitle: Text(
                        testSubtitle,
                        maxLines: 3,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // TODO: make this Date a variable
                            Text(
                              "3 days ago - April 1st, 2022",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[500],
                              ),
                            ),
                            ArticleBookmarkButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

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
