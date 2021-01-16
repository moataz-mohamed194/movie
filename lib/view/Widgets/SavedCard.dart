import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedCard extends StatelessWidget {
  final int id;
  final String movieName;
  final String movieImage;
  final String releaseDate;

  const SavedCard(
      {Key key, this.id, this.movieName, this.movieImage, this.releaseDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: InkWell(
        child: Card(
          child: Center(
            child: Row(
              children: [
                Expanded(child: Image.network(movieImage)),
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
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
