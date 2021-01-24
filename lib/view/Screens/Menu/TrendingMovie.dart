import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/Repository/MovieRepository.dart';
import '../../../view%20model/Movies/MovieBloc.dart';
import '../../../view%20model/Movies/MovieEvents.dart';
import '../../../view%20model/Movies/MovieStates.dart';
import '../../Widgets/Moviecard.dart';
import '../DetailsMovie.dart';

class TrendingMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(MovieRepository())
              ..add(DoFetchEvents("trending/tv/day")),
            child: SingleChildScrollView(
                child: Container(
              alignment: Alignment.center,
              child: BlocBuilder<MovieBloc, MovieStates>(
                  builder: (context, state) {
                if (state is PostInitialState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchSuccess) {
                  return Wrap(
                    children: state.posts
                        .map((item) => Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: MovieCard(
                                movieImg: item.posterPath.toString(),
                                liked: false,
                                movieName: item.originalName.toString(),
                                movieRate: item.voteAverage.toString(),
                                releaseDate: item.firstAirDate.toString(),
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsMovie(
                                                nameMovie: item.originalName
                                                    .toString(),
                                                rate:
                                                    item.voteAverage.toString(),
                                                imagePoster:
                                                    item.posterPath.toString(),
                                                description:
                                                    item.overview.toString(),
                                                date: item.firstAirDate
                                                    .toString(),
                                                imageCover: item.backdropPath
                                                    .toString(),
                                              )));
                                },
                                movieId: item.id.toString(),
                                movieImgCover: item.backdropPath.toString(),
                                movieOverview: item.overview.toString(),
                              ),
                            ))
                        .toList()
                        .cast<Widget>(),
                  );
                } else if (state is ErrorState) {
                  return Center(child: Text("${state.message.toString()}"));
                } else {
                  return Center(child: Text("Error"));
                }
              }),
            ))));
  }
}
