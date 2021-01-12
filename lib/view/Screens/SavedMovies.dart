import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/view/Widgets/SavedCard.dart';

class SavedMovie extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Liked"),
        ),
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
            SavedCard(movieName: "miss peregrine",releaseDate: "2016-09-28",movieImage: "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"),
          ],
        ),
      ),
    ));
  }

}