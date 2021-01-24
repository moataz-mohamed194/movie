import 'package:bloc/bloc.dart';

import '../../model/Repository/SQLDatabase.dart';
import 'SqlEvents.dart';
import 'SqlStates.dart';


class SqlBloc extends Bloc<SqlEvents, SqlStates> {
  SQLDatabase repo=SQLDatabase();
  SqlBloc(this.repo) : super(ButtonInitialState());

  @override
  Stream<SqlStates> mapEventToState(SqlEvents event) async* {
    if (event is DeleteFromFavorite) {
       await repo.delete(event.movieId);
       await SQLDatabase().getAllMovies2();
      print(event.movieId);
      yield ButtonInitialState();
      print(state);
    } else if(event is AddToFavorite) {
      print("movieId:${event.movieId},movieName:${event.movieName}");
      await repo.insert(event.movieId,event.moviePoster,event.movieRate,event.movieDate,event.movieCover,event.movieOverview,event.movieName);
      await SQLDatabase().getAllMovies2();
      yield LikedButtonState();
      print(state);
    }else if(event is Start) {
      List data2=await SQLDatabase().getAllMovies2();
      if(data2.toString().contains(event.movieId)){
        yield LikedButtonState();
        print(state);
      }else{
        yield ButtonInitialState();
        print(state);
      }
    }else if(event is GetSavedMovies) {
     try {
        List data = await SQLDatabase().getAllMovies();
        yield GetSaved(data);
        print(state);
      }catch(e){
       yield ErrorState(message: e.toString());
     }
    }
    else if(event is GetSavedMoviesAfterDelete) {
        await SQLDatabase().delete(event.movieId);

        List data = await SQLDatabase().getAllMovies();
        print("00000$data");
        yield GetSaved(data);
        print(state);
    }
  }
  }

