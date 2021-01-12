import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view%20model/Posts/MovieBloc.dart';
import 'package:movie/view%20model/Posts/PostEvent.dart';
import 'package:movie/view%20model/Posts/PostStates.dart';
import 'package:movie/view%20model/Posts/TrendingBloc.dart';
import 'package:movie/view/Widgets/Moviecard.dart';

import 'DetailsMovie.dart';

class TrendingMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrendingMoviePage();
  }
}

class TrendingMoviePage extends State<TrendingMovie> {
  // TrendingBloc bloc;
  // @override
  // void initState() {
  //   super.initState();
  //   bloc = BlocProvider.of<TrendingBloc>(context);
  //   bloc.add(DoFetchEvents());
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   bloc.close();
  // }
  MovieBloc bloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     // child: Builder(
      //     //     builder: (context) {
      //     //       BlocProvider.of<TrendingBloc>(context)..add(DoFetchEvents());
      //     //       return Container();
      //     //     }
      //     // ),
      //     // child:       BlocBuilder<TrendingBloc, PostStates>(builder: (context, state) {
      //     //   if (state is InitialState) {
      //     //     return Center(child: CircularProgressIndicator());
      //     //   } else if (state is LoadingState) {
      //     //     return Center(child: CircularProgressIndicator());
      //     //   } else if (state is FetchSuccess) {
      //     //     print(state.posts.length);
      //     //     return Wrap(
      //     //       children: state.posts.map((item) => Container(
      //     //         width: MediaQuery.of(context).size.width / 2,
      //     //         child: MovieCard(
      //     //           movieImg:"http://image.tmdb.org/t/p/w500${item.posterPath}",
      //     //           liked: false,
      //     //           movieName: item.originalTitle,
      //     //           movieRate: "${item.voteAverage}",
      //     //           releaseDate: "${item.releaseDate}",
      //     //           onClick: () {
      //     //             Navigator.push(
      //     //                 context,
      //     //                 MaterialPageRoute(
      //     //                     builder: (context) => DetailsMovie(
      //     //                       nameMovie: "miss peregrine",
      //     //                     )));
      //     //           },
      //     //         ),
      //     //       )).toList().cast<Widget>(),
      //     //     );
      //     //
      //     //   } else if (state is ErrorState) {
      //     //     print(state.message.toString());
      //     //     return Center(child: Text("${state.message.toString()}"));
      //     //   }else{
      //     //     return Center(child: Text("Error"));
      //     //   }
      //     // }),
      //
      //     child: BlocBuilder<MovieBloc, PostStates>(builder: (context, state) {
      //       if (state is InitialState) {
      //         return Center(child: CircularProgressIndicator());
      //       } else if (state is LoadingState) {
      //         return Center(child: CircularProgressIndicator());
      //       } else if (state is FetchSuccess) {
      //         return Wrap(
      //           children: state.posts
      //               .map((item) => Container(
      //             width: MediaQuery.of(context).size.width / 2,
      //             child: MovieCard(
      //               movieImg:
      //               "http://image.tmdb.org/t/p/w500${item.posterPath}",
      //               liked: false,
      //               movieName: item.originalTitle,
      //               movieRate: "${item.voteAverage}",
      //               releaseDate: "${item.releaseDate}",
      //               onClick: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => DetailsMovie(
      //                           nameMovie: "miss peregrine",
      //                         )));
      //               },
      //             ),
      //           ))
      //               .toList()
      //               .cast<Widget>(),
      //         );
      //       } else if (state is ErrorState) {
      //         print(state.message.toString());
      //         return Center(child: Text("${state.message.toString()}"));
      //       } else {
      //         return Center(child: Text("Error"));
      //       }
      //     }),
      //
      //     // Wrap(
      //     //   children: <Widget>[
      //     //     MovieCard(
      //     //       movieImg:
      //     //           "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //       liked: false,
      //     //       movieName: "miss peregrine",
      //     //       movieRate: "6.2",
      //     //       releaseDate: "2016-09-28",
      //     //       onClick: () {
      //     //         Navigator.push(
      //     //             context,
      //     //             MaterialPageRoute(
      //     //                 builder: (context) => DetailsMovie(
      //     //                       nameMovie: "miss peregrine",
      //     //                     )));
      //     //       },
      //     //     ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //     // MovieCard(
      //     //     //   movieImg:
      //     //     //   "http://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      //     //     //   liked: true,
      //     //     //   movieName: "miss peregrine",
      //     //     //   movieRate: "6.2",
      //     //     //   releaseDate: "2016-09-28",
      //     //     // ),
      //     //   ],
      //     // ),
      //   ),
      // ),
      body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: BlocBuilder<MovieBloc, PostStates>(builder: (context, state) {
              if (state is InitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FetchSuccess) {
                return Wrap(
                  children: state.posts
                      .map((item) => Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: MovieCard(
                      movieImg:
                      "http://image.tmdb.org/t/p/w500${item.posterPath}",
                      liked: false,
                      movieName: item.originalTitle,
                      movieRate: "${item.voteAverage}",
                      releaseDate: "${item.releaseDate}",
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsMovie(
                                  nameMovie: "miss peregrine",
                                )));
                      },
                    ),
                  ))
                      .toList()
                      .cast<Widget>(),
                );
              } else if (state is ErrorState) {
                print(state.message.toString());
                return Center(child: Text("${state.message.toString()}"));
              } else {
                return Center(child: Text("Error"));
              }
            }),
          )),
    );
  }
}
