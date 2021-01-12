import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/model/models/PostModel.dart';
import 'package:movie/model/Repository/PostRepository.dart';
import 'package:movie/view%20model/Posts/PostEvent.dart';
import 'package:movie/view%20model/Posts/PostStates.dart';

class TrendingBloc extends Bloc<PostEvents,PostStates>{
  PostRepository repo;

  TrendingBloc(PostStates initialState,this.repo):super(initialState);
  @override
  Stream<PostStates> mapEventToState(PostEvents event) async*{
    if(event is DoFetchEvents){
      yield LoadingState();
      try{
        List<Results> posts=await repo.fetchPosts("trending/tv/day");
        print(posts);
        if(posts!=null){
          print("00000000000000000000000000");
          print(posts[0].originalTitle);
          print("00000000000000000000000000");
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
class PostStates0 extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class InitialState0 extends PostStates0{}
class LoadingState0 extends PostStates0{}
class FetchSuccess0 extends PostStates0{
  List<Results> posts;
  FetchSuccess0({this.posts});
}
class ErrorState0 extends PostStates0{
  String message;
  ErrorState0({this.message});
}
class PostEvents0 extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class DoFetchEvents0 extends PostEvents0{}