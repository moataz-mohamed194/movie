import 'package:bloc/bloc.dart';
import 'package:movie/model/Repository/TrendingRepository.dart';
import 'package:movie/model/models/TrendingModel.dart';
import 'TrendingEvent.dart';
import 'TrendingStates.dart';

class TrendingBloc extends Bloc<TrendingEvents,TrendingStates>{
  TrendingRepository repo;

  TrendingBloc(TrendingStates initialState,this.repo):super(initialState);
  @override
  Stream<TrendingStates> mapEventToState(TrendingEvents event) async*{
    if(event is TrendingDoFetchEvents){
      yield LoadingState();
      try{
        List<Results> posts=await repo.fetchPosts("trending/tv/day");
        print(posts);
        if(posts!=null){
          print("00000000000000000000000000");
          print(posts[0].originalName);
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