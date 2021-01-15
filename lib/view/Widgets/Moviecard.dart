import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/model/Repository/SQLDatabase.dart';
import 'package:movie/view%20model/Sqlite/SqlBloc.dart';
import 'package:movie/view%20model/Sqlite/SqlEvents.dart';
import 'package:movie/view%20model/Sqlite/SqlStates.dart';

class MovieCard extends StatelessWidget {
  final String movieImg;
  final String movieImgCover;
  final String movieOverview;
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
      this.movieImgCover,
      this.movieOverview,
      this.onClick,
      this.movieId})
      : super(key: key);
  // cb;

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<SqlBloc>(context);
    return Material(
      // create:
      child: BlocProvider<SqlBloc>(
        create: (context) =>
            SqlBloc(ButtonInitialState(), SQLDatabase())..add(dataEvents()),
        child: Container(
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
                        icon: BlocBuilder<SqlBloc, SqlStates>(
                            builder: (context, state) {
                          if (state is FetchSuccess) {
                            print(
                                "movieId:$movieId:${state.posts.toString().contains("$movieId")}");
                            if (state.posts.toString().contains("$movieId")) {
                              return Icon(
                                Icons.favorite,
                                color: Colors.red,
                              );
                            } else {
                              return Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.grey,
                              );
                            }
                          } else if(state is ButtonState) {
                            if(state.res==true) {
                              return Icon(
                                Icons.favorite,
                                color: Colors.red,
                              );
                            }else{
                              return Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.grey,
                              );
                            }
                          }else{
                            return Container();
                          }
                        }),
                        onPressed: () {
                          // SqlBloc cb =
                          BlocProvider.of<SqlBloc>(context)
                            ..add(IconEvents(
                                "$movieId",
                                movieRate,
                                "http://image.tmdb.org/t/p/w500$movieImgCover",
                                movieName,
                                movieOverview,
                                movieImg,
                                releaseDate));
                        },
                      ))
                    ],
                  )
                ],
              ),
              onTap: onClick,
            ),
          ),
        ),
      ),
    );
  }
}
