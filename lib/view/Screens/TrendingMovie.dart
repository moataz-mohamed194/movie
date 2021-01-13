import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/model/Repository/MovieRepository.dart';
import 'package:movie/view%20model/Movies/MovieBloc.dart';
import 'package:movie/view%20model/Movies/MovieEvents.dart';
import 'package:movie/view%20model/Movies/MovieStates.dart';
import 'package:movie/view/Widgets/Moviecard.dart';
import 'DetailsMovie.dart';

class TrendingMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: BlocProvider<MovieBloc>(
        create: (context) => MovieBloc(PostInitialState(), MovieRepository())
          ..add(DoFetchEvents("trending/tv/day")),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Trending"),
            ),
            body: SingleChildScrollView(
                child: Container(
              alignment: Alignment.center,
              child:
                  BlocBuilder<MovieBloc, MovieStates>(builder: (context, state) {
                if (state is PostInitialState) {
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
                                                    movieName: item.originalName,
                                                    movieRate: "${item.voteAverage}",
                                                    releaseDate: "${item.firstAirDate}",
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsMovie(
                                                nameMovie: item.originalName,
                                                rate: item.voteAverage,
                                                imagePoster: item.posterPath,
                                                description: item.overview,
                                                date: item.firstAirDate,
                                                imageCover: item.backdropPath,
                                              )));
                                },
                                movieId: item.id,
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
            ))),
      ),
    );
  }
}
