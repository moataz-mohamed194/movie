import 'package:equatable/equatable.dart';
import 'package:movie/model/models/PostModel.dart';

class MovieStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class PostInitialState extends MovieStates{}
class LoadingState extends MovieStates{}
class FetchSuccess extends MovieStates{

var posts;
  FetchSuccess({this.posts});
}
class ErrorState extends MovieStates{
  String message;
  ErrorState({this.message});
}