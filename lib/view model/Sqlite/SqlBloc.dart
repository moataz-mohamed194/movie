
import 'package:bloc/bloc.dart';

import '../../model/Repository/SQLDatabase.dart';
import 'SqlEvents.dart';
import 'SqlStates.dart';

class SqlBloc extends Bloc<SqlEvents,SqlStates>{
  SQLDatabase repo;
  SqlBloc(SqlStates initialState,this.repo):super(initialState);
  @override
  Stream<SqlStates> mapEventToState(SqlEvents event) async* {
    if(event is IconEvents){
      int data=await SQLDatabase().getAllMovies(event.movieId);
      if(data >0){
        await SQLDatabase().delete("${event.movieId}");
        yield ButtonState(res: false);
      }else{
        await SQLDatabase().insert(
             "${event.movieId}", "${event.moviePoster}", "${event.movieRate}",
             "${event.movieDate}", "${event.movieCover}",
             "${event.movieOverview}");
        yield ButtonState(res: true);
      }
    }else if(event is dataEvents){
      List data=await SQLDatabase().getAllMovies2();
      print("0000$data");
      yield FetchSuccess(posts: data);

    }
  }
}