import 'package:flutter/cupertino.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class RssFeedItem extends StatelessWidget {
  // Widget (View) for Card Item
  final String title;
  final String subtitle;
  final String imageURL;

  const RssFeedItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageURL})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
        // NOTE: perhaps wrap with padding?
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
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
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 8),
                // TODO: make this Date a variable
                Text(
                  "3 days ago - April 1st, 2022",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const Spacer(),
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.bookmark),
                  onPressed: () {/*...*/},
                ),
              ],
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
