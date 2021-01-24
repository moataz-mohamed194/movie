import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedCard extends StatelessWidget {
  final String id;
  final String movieName;
  final String movieImage;
  final String releaseDate;
  final String movieImgCover;
  final String movieOverview;
  final String movieRate;
  final bool liked;
  final Function onClick;
  final Function deleteFunction;

  SavedCard({Key key,this.deleteFunction ,this.id, this.movieName, this.movieImage, this.releaseDate, this.movieImgCover, this.movieOverview, this.movieRate, this.liked, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("http://image.tmdb.org/t/p/w500$movieImage");
    return Container(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        child: Card(
          child: Center(
            child: Row(
              children: [
                Expanded(child: Image.network("http://image.tmdb.org/t/p/w500$movieImage")),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movieName,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      releaseDate,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                )),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 35,
                    ),
                    onPressed: deleteFunction,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: onClick,
      ),
    );
  }
}
