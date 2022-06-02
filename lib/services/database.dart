import 'package:news_feed/data/article.dart';
import 'package:news_feed/data/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "favorites.db"),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE favorites(id INTEGER PRIMARY KEY, userId INTEGER NOT NULL, title TEXT NOT NULL, link TEXT NOT NULL, description TEXT NOT NULL, imgURL TEXT NOT NULL, pubString TEXT NOT NULL)",
        );
      },
    );
  }

  Future<int> putFavorite(Favorite favorite) async {
    int res = 0;

    final Database db = await initDB();
    res = await db.insert('favorites', favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }

  Future<List<Favorite>> getAllFavorites() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryRes = await db.query(
      'favorites',
    );
    return queryRes.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<List<Favorite>> getFavoritesByUserId(int userId) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryRes = await db.query(
      'favorites',
      where: "userId = ?",
      whereArgs: [userId],
    );
    return queryRes.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<List<Favorite>> getFavoriteByArticleAndUserId(
      Article article, int userId) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryRes = await db.query('favorites',
        where: "userId = ? and title = ? and description = ? and pubString = ?",
        whereArgs: [
          userId,
          article.title,
          article.description,
          article.pubString
        ]);
    return queryRes.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<void> deleteAllFavorites() async {
    final db = await initDB();
    await db.delete(
      'favorites',
    );
  }

  Future<void> deleteFavoriteByUserId(int userId) async {
    final db = await initDB();
    await db.delete(
      'favorites',
      where: "userId = ?",
      whereArgs: [userId],
    );
  }

  Future<void> deleteFavoriteByArticleAndUserId(
      Article article, int userId) async {
    final db = await initDB();
    await db.delete('favorites',
        where: "userId = ? and title = ? and description = ? and pubString = ?",
        whereArgs: [
          userId,
          article.title,
          article.description,
          article.pubString
        ]);
  }
}
