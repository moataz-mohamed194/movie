import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieCard extends StatelessWidget {
  final String movieImg;
  final String movieName;
  final String releaseDate;
  final String movieRate;
  final bool liked;
  final Function onClick;
  final int movieId;

  const MovieCard(
      {Key key,
      this.movieImg,
      this.movieName,
      this.releaseDate,
      this.movieRate,
      this.liked,
      this.onClick,
      this.movieId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                movieImg,
                height: 250,
              ),
              Text(movieName),
              Text(releaseDate),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Text(movieRate),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      )
                    ],
                  )),
                  Expanded(
                      child: IconButton(
                    icon: liked == true
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey,
                          ),
                    onPressed: () {},
                  ))
                ],
              )
            ],
          ),
          onTap: onClick,
        ),
      ),
    );
  }
}
