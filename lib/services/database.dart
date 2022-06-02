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
          "CREATE TABLE favorites(id INTEGER PRIMARY KEY, userId INTEGER NOT NULL, title TEXT NOT NULL, link TEXT NOT NULL, description TEXT NOT NULL, imgURL TEXT NOT NULL, pubDate TEXT NOT NULL)",
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

  Future<List<Favorite>> getFavoritesByUserId(int userIdIn) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryRes = await db.query(
      'favorites',
      where: "userId = ?",
      whereArgs: [userIdIn],
    );
    return queryRes.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<void> deleteAllFavorites() async {
    final db = await initDB();
    await db.delete('favorites',);
  }

  Future<void> deleteFavoriteByUserId(int userIdIn) async {
    final db = await initDB();
    await db.delete(
      'favorites',
      where: "userId = ?",
      whereArgs: [userIdIn],
    );
  }
}
