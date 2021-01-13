import 'package:bloc/bloc.dart';
import 'package:movie/model/models/PostModel.dart';
import 'package:movie/model/Repository/LastRepository.dart';
import 'PostEvent.dart';
import 'PostStates.dart';

class MovieBloc extends Bloc<PostEvents,PostStates>{
  LastRepository repo;
  MovieBloc(PostStates initialState,this.repo):super(initialState);
  @override
  Stream<PostStates> mapEventToState(PostEvents event) async*{
    if(event is DoFetchEvents){
      yield LoadingState();
      try{
        List<Results0> posts=await repo.fetchPosts(event.cityName);
        if(posts!=null){
          yield FetchSuccess(posts: posts);
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