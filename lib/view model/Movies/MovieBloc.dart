import 'package:bloc/bloc.dart';
import '../../model/Repository/MovieRepository.dart';
import '../../model/models/PostModel.dart';
import '../../model/models/TrendingModel.dart';
import 'MovieEvents.dart';
import 'MovieStates.dart';

class MovieBloc extends Bloc<MovieEvents, MovieStates> {
  MovieRepository repo = MovieRepository();
  MovieBloc(this.repo) : super(PostInitialState());
  @override
  Stream<MovieStates> mapEventToState(MovieEvents event) async* {
    if (event is DoFetchEvents) {
      yield LoadingState();
      try {
        var data = await repo.fetchPosts(event.cityName);
        if (data != null) {
          if (event.cityName == "movie/popular") {
            List<Results0> posts;

            posts = MovieModel.fromJson(data).results;
            yield FetchSuccess(posts: posts);
          } else {
            List<Results> posts;

            posts = TrendingModel.fromJson(data).results;

            yield FetchSuccess(posts: posts);
          }
        }
        // yield FetchSuccess(posts: posts);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }
  }
}
