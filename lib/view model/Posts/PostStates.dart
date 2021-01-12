import 'package:equatable/equatable.dart';
import 'package:movie/model/models/PostModel.dart';

class PostStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class InitialState extends PostStates{}
class LoadingState extends PostStates{}
class FetchSuccess extends PostStates{
  List<Results> posts;
  FetchSuccess({this.posts});
}
class ErrorState extends PostStates{
  String message;
  ErrorState({this.message});
}