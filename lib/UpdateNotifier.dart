import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_playground/theHomePage.dart';

import 'FavoritePage.dart';

class UpdateNotifier with ChangeNotifier {
  FlexScheme _themeData = FlexScheme.amber;

  List<FavoriteArticle> favoriteList = <FavoriteArticle>[];

  getTheme() => _themeData;

  setTheme(FlexScheme themeData) {
    _themeData = themeData;
    notifyListeners();
  }


  getFavoriteList() => favoriteList;

  addToFavoriteList(title, link, description, imageURL, pubDate){
    var article = FavoriteArticle(
        title: title,
        link: link,
        description: description,
        imageURL: imageURL,
        pubDate: pubDate);
    favoriteList.add(article);
    notifyListeners();
  }

  removeFromFavoriteList(title){
    if(isFavorite(title)){
      for(var i = 0; i < favoriteList.length; i++){
        if(title == favoriteList[i].title){
          favoriteList.remove(favoriteList[i]);
        }
      }
    }

    notifyListeners();
  }

  isFavorite(title){
    for(var i = 0; i < favoriteList.length; i++){
      if(title == favoriteList[i].title){
        print("is in the list");
        return true;
      }
    }
    print("not in the list");
    return false;
  }

  getIcon(title){
    if(isFavorite(title)){
      return Icons.bookmark;
    }
    return Icons.bookmark_border;
  }
}