import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:date_time_format/date_time_format.dart';

import 'UpdateNotifier.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<ArticleItem> articles = List<ArticleItem>.generate(
        4,
            (int index) => ArticleItem(
          title: "News ${index + 1}",
          link: Uri.parse("https://www.ucdavis.edu/"),
          description: "Global perspective, human stories ${index + 1}",
          pubDate: DateTime.now(),
          imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_the_United_Nations.svg/640px-Flag_of_the_United_Nations.svg.png",
        ),
        growable: true);
    return Scaffold(
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) => articles[index],
      ),
    );
  }
}




class ArticleItem extends StatelessWidget {
  // Widget (View) for Card Item
  final String title;
  final Uri link; //Uri
  final String description;
  final String imageURL; //Uri
  final DateTime pubDate; //DateTime

  ArticleItem(
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
                            if(update.isFavorite(title)){ // is in the favorite list
                              update.removeFromFavoriteList(title);
                              print("Remove: $title");
                            }
                            else{
                              update.addToFavoriteList(title, link, description, imageURL, pubDate);
                              print("Add: $title");
                            }

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
















