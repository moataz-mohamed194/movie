class MovieStates {}

class PostInitialState extends MovieStates {}

class LoadingState extends MovieStates {}

class FetchSuccess extends MovieStates {
  var posts;
  FetchSuccess({this.posts});
}

class ErrorState extends MovieStates {
  String message;
  ErrorState({this.message});
}
