import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/model/Repository/SQLDatabase.dart';

import 'package:movie/view%20model/Sqlite/SqlBloc.dart';
import 'package:movie/view%20model/Sqlite/SqlEvents.dart';
import 'package:toast/toast.dart';

import '../../view model/LoginByFaceBookAndGoogle/UI.dart';
import '../../view%20model/Sqlite/SqlStates.dart';

class MovieCard extends StatelessWidget {
  final String movieImg;
  final String movieImgCover;
  final String movieOverview;
  final String movieName;
  final String releaseDate;
  final String movieRate;
  final bool liked;
  final Function onClick;
  final String movieId;

  MovieCard({
    Key key,
    this.movieImg,
    this.movieName,
    this.releaseDate,
    this.movieRate,
    this.liked,
    this.movieImgCover,
    this.movieOverview,
    this.onClick,
    this.movieId,
  }) : super(key: key);

  final sql = SqlBloc(SQLDatabase());

  @override
  Widget build(BuildContext context) {
    sql.add(Start(movieId.toString()));

    return BlocBuilder<SqlBloc, SqlStates>(
      cubit: sql,
      builder: (context, state) {
        return Material(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "http://image.tmdb.org/t/p/w500$movieImg",
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
                          ),
                        ),
                        BlocBuilder<UIBloc, bool>(builder: (context, state0) {
                          if (state0 == true) {
                            return IconButton(
                              icon: state is LikedButtonState
                                  ? Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.heart,
                                    ),
                              onPressed: () {

                                  if (state is ButtonInitialState) {
                                    sql.add(
                                      AddToFavorite(
                                          "$movieId",
                                          "$movieRate",
                                          "$movieImgCover",
                                          "$movieName",
                                          "$movieOverview",
                                          "$movieImg",
                                          "$releaseDate"),
                                    );
                                  } else {
                                    sql.add(DeleteFromFavorite("$movieId"));
                                  }

                              },
                            );
                          } else {
                            return IconButton(
                                icon: Icon(
                              FontAwesomeIcons.heart,
                            ),  onPressed: () {
                              Toast.show("you need to login", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            });
                          }
                        })
                      ],
                    )
                  ],
                ),
                onTap: onClick,
              ),
            ),
          ),
        );
      },
    );
  }
}
