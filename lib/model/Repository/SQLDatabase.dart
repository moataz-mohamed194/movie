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
        "CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT , movieId TEXT UNIQUE, movieImgPoster TEXT, movieRate TEXT, movieDate TEXT, movieImgCover TEXT, movieOverview TEXT, movieName TEXT)",
      );
    });
  }

  Future<List> getAllMovies() async {
    final db = await database;
    var data = await db.query("movies");
    return data.toList(); //.toList();
  }

  getAllMovies2() async {
    final db = await database;
    var data = await db.rawQuery('SELECT movieId FROM movies  ');
    return data.toList();
  }

  insert(
      String movieId,
      String movieImgPoster,
      String movieRate,
      String movieDate,
      String movieImgCover,
      String movieOverview,
      String movieName) async {
    final db = await database;
    var result;
    print("vvvvvvvvvvvvvvvvvvvvvvvvvvv");
    try {
      result = await db.rawInsert(
          "INSERT Into movies ( movieId, movieImgPoster , movieRate , movieDate , movieImgCover , movieOverview ,movieName)"
          " VALUES ( ?,?,?,?,?,?,?)",
          [
            movieId,
            movieImgPoster,
            movieRate,
            movieDate,
            movieImgCover,
            movieOverview,
            movieName
          ]);
    } catch (e) {
      print("eeeeeeeeeeee$e");
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
