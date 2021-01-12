import 'package:bloc/bloc.dart';
import 'package:movie/model/models/PostModel.dart';
import 'package:movie/model/Repository/PostRepository.dart';
import 'package:movie/view%20model/Posts/PostEvent.dart';
import 'package:movie/view%20model/Posts/PostStates.dart';

class MovieBloc extends Bloc<PostEvents,PostStates>{
  PostRepository repo;
  MovieBloc(PostStates initialState,this.repo):super(initialState);
  @override
  Stream<PostStates> mapEventToState(PostEvents event) async*{
    if(event is DoFetchEvents){
      yield LoadingState();
      try{
        List<Results> posts=await repo.fetchPosts("movie/popular");
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