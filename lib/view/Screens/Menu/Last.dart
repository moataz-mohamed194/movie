import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view%20model/Movies/MovieBloc.dart';
import '../../../view%20model/Movies/MovieStates.dart';
import '../../Widgets/Moviecard.dart';
import '../DetailsMovie.dart';

class Last extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Last> {
  @override
  Widget build(BuildContext context) {
   return
      Expanded(
        child: SingleChildScrollView(
            child: Container(
          alignment: Alignment.center,
          child: BlocBuilder<MovieBloc, MovieStates>(builder: (context, state) {
            if (state is PostInitialState) {
              return Center(child: Center(child: CircularProgressIndicator()));
            } else if (state is LoadingState) {
              return Center(child: Center(child: CircularProgressIndicator()));
            } else if (state is FetchSuccess) {
              return Wrap(
                children: state.posts
                    .map((item) => Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: MovieCard(
                            movieImg:
                                item.posterPath.toString(),
                            movieName: item.originalTitle.toString(),
                            movieRate: item.voteAverage.toString(),
                            releaseDate: item.releaseDate.toString(),
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsMovie(
                                            nameMovie: item.originalTitle.toString(),
                                            date: item.releaseDate.toString(),
                                            description: item.overview.toString(),
                                            imageCover: item.backdropPath.toString(),
                                            imagePoster: item.posterPath.toString(),
                                            rate: item.voteAverage.toString(),
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
        )),
      );

  }

}
