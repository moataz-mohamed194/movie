import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/model/Repository/SQLDatabase.dart';
import 'package:movie/view%20model/Sqlite/SqlBloc.dart';
import 'package:movie/view%20model/Sqlite/SqlEvents.dart';
import 'package:movie/view%20model/Sqlite/SqlStates.dart';

import '../../Widgets/SavedCard.dart';
import '../DetailsMovie.dart';

class SavedMovie extends StatelessWidget {
  final sql = SqlBloc(SQLDatabase());

  @override
  Widget build(BuildContext context) {
    sql.add(GetSavedMovies());
    return Expanded(
      child: BlocBuilder<SqlBloc, SqlStates>(
                  cubit: sql,
                  builder: (context, state) {
                    if (state is GetSaved) {
                      if (state.data.length > 0) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: state.data.length,
                              itemBuilder: (context, index) {
                                return SavedCard(
                                  movieName:
                                      state.data[index]['movieName'].toString(),
                                  releaseDate:
                                      state.data[index]['movieDate'].toString(),
                                  movieImage: state.data[index]['movieImgPoster']
                                      .toString(),
                                  movieOverview: state.data[index]
                                          ['movieOverview']
                                      .toString(),
                                  movieImgCover: state.data[index]
                                          ['movieImgCover']
                                      .toString(),
                                  movieRate:
                                      state.data[index]['movieRate'].toString(),
                                  id: state.data[index]['movieId'].toString(),

                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsMovie(
                                                nameMovie: state.data[index]['movieName'].toString(),
                                                date: state.data[index]['movieDate'].toString(),
                                                description: state.data[index]
                                                ['movieOverview']
                                                    .toString(),
                                                imageCover: state.data[index]
                                                ['movieImgCover']
                                                    .toString(),
                                                imagePoster: state.data[index]['movieImgPoster']
                                                    .toString(),
                                                rate: state.data[index]['movieRate'].toString(),
                                                )));
                                  },
                                  deleteFunction: (){
                                    sql.add(GetSavedMoviesAfterDelete(state.data[index]['movieId'].toString()));
                                  },
                                );
                              }),
                        );
                      } else {
                        return Center(child: Text("Nothing"));
                      }
                    } else {
                      return Center(child: Text("Error$state"));
                    }
                  }),
    );
  }
}
