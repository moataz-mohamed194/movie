import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SQLDatabase {
  SQLDatabase();

  List results;
  bool start = false;

  SQLDatabase._();

  static final SQLDatabase db = SQLDatabase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'movie.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT , movieId TEXT UNIQUE, movieImgPoster TEXT,user TEXT, movieRate TEXT, movieDate TEXT, movieImgCover TEXT, movieOverview TEXT, movieName TEXT)",
      );
    });
  }

  Future<List> getAllMovies(String user) async {
    final db = await database;
    var data = await db.query("movies" , where: "user = ?",
      whereArgs: [user],);
    return data.toList();
  }

  getAllMovies2(String user) async {
    final db = await database;
    var data = await db.rawQuery("SELECT movieId FROM movies WHERE user='$user' ");
    return data.toList();
  }

  insert(
      String movieId,
      String movieImgPoster,
      String movieRate,
      String movieDate,
      String movieImgCover,
      String movieOverview,
      String user,
      String movieName) async {
    final db = await database;
    var result;
    try {
      result = await db.rawInsert(
          "INSERT Into movies ( movieId, movieImgPoster , movieRate , movieDate , movieImgCover , movieOverview ,movieName, user)"
          " VALUES ( ?,?,?,?,?,?,?,?)",
          [
            movieId,
            movieImgPoster,
            movieRate,
            movieDate,
            movieImgCover,
            movieOverview,
            movieName,user
          ]);
    } catch (e) {
      print("error: $e");
    }

    return result;
  }

  Future<void> delete(String id) async {
    final db = await database;
    await db.delete(
      'movies',
      where: "movieId = ?",
      whereArgs: [id],
    );
  }
}
