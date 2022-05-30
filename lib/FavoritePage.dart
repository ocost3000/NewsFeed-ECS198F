import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:date_time_format/date_time_format.dart';

import 'UpdateNotifier.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritePage();

}

class _FavoritePage extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favoriteUpdate = Provider.of<UpdateNotifier>(context);
    var articles = favoriteUpdate.getFavoriteList();
    return Scaffold(
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) => articles[index],
      ),
    );
  }
}


class FavoriteArticle extends StatelessWidget {
  // Widget (View) for Card Item
  final String title;
  final Uri link; //Uri
  final String description;
  final String imageURL; //Uri
  final DateTime pubDate; //DateTime

  FavoriteArticle(
      {Key? key,
        required this.title,
        required this.link,
        required this.description,
        required this.imageURL,
        required this.pubDate,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateNotifier>(
      builder: (context, update, child){
        return Center(
          child: InkWell(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Image.network(
                    imageURL,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('images/rss.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain);
                    },
                  ),
                  ListTile(
                    title: Text(title),
                    subtitle: Text(description),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 15),
                          Text( DateTimeFormat.relative(pubDate.subtract(Duration(days: 5, hours: 10))) + " ago - " + pubDate.format(AmericanDateFormats.dayOfWeek)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(update.getIcon(title)),
                        onPressed: (){
                            update.removeFromFavoriteList(title);
                        },
                      ),
                    ],
                  ),
                  // const Spacer(),
                ],
              ),
            ),
            onTap: () async {
              if(!await launchUrl(link)) throw 'Could not launch $link';
            },
          ),
        );
      },
    );
  }
}
















