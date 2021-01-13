import 'package:bloc/bloc.dart';
import 'package:movie/model/models/PostModel.dart';
import 'package:movie/model/Repository/MovieRepository.dart';
import 'package:movie/model/models/TrendingModel.dart';
import 'MovieEvents.dart';
import 'MovieStates.dart';

class MovieBloc extends Bloc<MovieEvents,MovieStates>{
  MovieRepository repo;
  MovieBloc(MovieStates initialState,this.repo):super(initialState);
  @override
  Stream<MovieStates> mapEventToState(MovieEvents event) async*{
    if(event is DoFetchEvents){
      yield LoadingState();
      try{
        var data=await repo.fetchPosts(event.cityName);
        if(data!=null){
          if(event.cityName=="movie/popular") {
            List<Results0> posts;

            posts = MovieModel
                .fromJson(data)
                .results;

            yield FetchSuccess(posts: posts);
          }else{
            List<Results> posts;

            posts = TrendingModel
                .fromJson(data)
                .results;

            yield FetchSuccess(posts: posts);
          }
          }else{
          yield LoadingState();
        }
        // yield FetchSuccess(posts: posts);
      }catch(e){
        yield ErrorState(message: e.toString());
      }
    }
  }

}