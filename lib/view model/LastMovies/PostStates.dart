import 'package:equatable/equatable.dart';
import 'package:movie/model/models/PostModel.dart';

class PostStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class PostInitialState extends PostStates{}
class LoadingState extends PostStates{}
class FetchSuccess extends PostStates{

  List<Results0> posts;
  FetchSuccess({this.posts});
}
class ErrorState extends PostStates{
  String message;
  ErrorState({this.message});
}